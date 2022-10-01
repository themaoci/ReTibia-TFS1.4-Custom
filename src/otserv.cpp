// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "server.h"

#include "game.h"

#include "iomarket.h"

#include "configmanager.h"
#include "scriptmanager.h"
#include "rsa.h"
#include "protocolold.h"
#include "protocollogin.h"
#include "protocolstatus.h"
#include "databasemanager.h"
#include "scheduler.h"
#include "databasetasks.h"
#include "script.h"
#include "const.h"
#include <fstream>
#include <fmt/color.h>
#if __has_include("gitmetadata.h")
	#include "gitmetadata.h"
#endif
#include "discord.h"

DatabaseTasks g_databaseTasks;
Dispatcher g_dispatcher;
Scheduler g_scheduler;

Game g_game;
Discord g_discord;
ConfigManager g_config;
Monsters g_monsters;
Vocations g_vocations;
extern Scripts* g_scripts;
RSA g_RSA;

std::mutex g_loaderLock;
std::condition_variable g_loaderSignal;
std::unique_lock<std::mutex> g_loaderUniqueLock(g_loaderLock);

void startupErrorMessage(const std::string& errorStr)
{
	fmt::print(fg(fmt::color::crimson) | fmt::emphasis::bold, "> ERROR: {:s}\n", errorStr);
	g_loaderSignal.notify_all();
}

void mainLoader(int argc, char* argv[], ServiceManager* services);
bool argumentsHandler(const StringVector& args);

[[noreturn]] void badAllocationHandler()
{
	// Use functions that only use stack allocation
	puts("Allocation failed, server out of memory.\nDecrease the size of your map or compile in 64 bits mode.\n");
	getchar();
	exit(-1);
}

int main(int argc, char* argv[])
{
	StringVector args = StringVector(argv, argv + argc);
	if(argc > 1 && !argumentsHandler(args)) {
		return 0;
	}

	// Setup bad allocation handler
	std::set_new_handler(badAllocationHandler);

	ServiceManager serviceManager;

	g_dispatcher.start();
	g_scheduler.start();

	g_dispatcher.addTask(createTask(std::bind(mainLoader, argc, argv, &serviceManager)));

	g_loaderSignal.wait(g_loaderUniqueLock);

	if (serviceManager.is_running()) {
		std::cout << ">> " << g_config.getString(ConfigManager::SERVER_NAME) << " Server Online!" << std::endl << std::endl;
		serviceManager.run();
	} else {
		std::cout << ">> No services running. The server is NOT online." << std::endl;
		g_scheduler.shutdown();
		g_databaseTasks.shutdown();
		g_dispatcher.shutdown();
	}

	g_scheduler.join();
	g_databaseTasks.join();
	g_dispatcher.join();
	return 0;
}

void printServerVersion()
{
	std::cout << 
	"----------------------- " << STATUS_SERVER_NAME << " - " << STATUS_SERVER_VERSION << "--------------------------------\n" << 
	"Compiled: " << BOOST_COMPILER << " | " << __DATE__ << ' ' << __TIME__ << " | " << 
#if defined(__amd64__) || defined(_M_X64)
	"x64" << 
#elif defined(__i386__) || defined(_M_IX86) || defined(_X86_)
	"x86" << 
#elif defined(__arm__)
	"ARM" << 
#else
	"unknown" << 
#endif
	"\nLua: " <<
#if defined(LUAJIT_VERSION)
	LUAJIT_VERSION << 
#else
	LUA_RELEASE << 
#endif
	"\nNetMsgSize: " << NETWORKMESSAGE_MAXSIZE << "\n" <<
	"Devs: " << STATUS_SERVER_DEVELOPERS << "\nWeb: https://retibia.app/\n" 
	"-----------------------------------------------------------" << std::endl;
}

void mainLoader(int, char*[], ServiceManager* services)
{
	auto ServerStartTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
	//dispatcher thread
	g_game.setGameState(GAME_STATE_STARTUP);

	srand(static_cast<unsigned int>(OTSYS_TIME()));
#ifdef _WIN32
	SetConsoleTitle(STATUS_SERVER_NAME);
#endif

	printServerVersion();

	// check if config.lua or config.lua.dist exist
	const std::string& configFile = g_config.getString(ConfigManager::CONFIG_FILE);
	std::ifstream c_test("./" + configFile);
	if (!c_test.is_open()) {
		std::ifstream config_lua_dist("./config.lua.dist");
		if (config_lua_dist.is_open()) {
			std::cout << ">> copying config.lua.dist to " << configFile << std::endl;
			std::ofstream config_lua(configFile);
			config_lua << config_lua_dist.rdbuf();
			config_lua.close();
			config_lua_dist.close();
		}
	} else {
		c_test.close();
	}

	// read global config
	if (!g_config.load()) {
		startupErrorMessage("Unable to load " + configFile + "!");
		return;
	}

#ifdef _WIN32
	const std::string& defaultPriority = g_config.getString(ConfigManager::DEFAULT_PRIORITY);
	if (strcasecmp(defaultPriority.c_str(), "high") == 0) {
		SetPriorityClass(GetCurrentProcess(), HIGH_PRIORITY_CLASS);
	} else if (strcasecmp(defaultPriority.c_str(), "above-normal") == 0) {
		SetPriorityClass(GetCurrentProcess(), ABOVE_NORMAL_PRIORITY_CLASS);
	}
#endif

	//set RSA key
	try {
		g_RSA.loadPEM("key.pem");
	} catch(const std::exception& e) {
		startupErrorMessage(e.what());
		return;
	}


	if (!Database::getInstance().connect()) {
		startupErrorMessage("Failed to connect to database.");
		return;
	}


	// run database manager

	if (!DatabaseManager::isDatabaseSetup()) {
		startupErrorMessage("The database you have specified in config.lua is empty, please import the schema.sql to your database.");
		return;
	}
	g_databaseTasks.start();

	DatabaseManager::updateDatabase();

	if (g_config.getBoolean(ConfigManager::OPTIMIZE_DATABASE) && !DatabaseManager::optimizeTables()) {
		std::cout << " | (**No tables were optimized**)";
	}

	//load vocations
	if (!g_vocations.loadFromXml()) {
		startupErrorMessage("Unable to load vocations!");
		return;
	}

	// load item data
	if (!Item::items.loadFromOtb("data/items/items.otb")) {
		startupErrorMessage("Unable to load items (OTB)!");
		return;
	}

	if (!Item::items.loadFromXml()) {
		startupErrorMessage("Unable to load items (XML)!");
		return;
	}

	if (!ScriptingManager::getInstance().loadScriptSystems()) {
		startupErrorMessage("Failed to load script systems");
		return;
	}

	if (!g_scripts->loadScripts("scripts", false, false)) {
		startupErrorMessage("Failed to load lua scripts");
		return;
	}

	if (!g_monsters.loadFromXml()) {
		startupErrorMessage("Unable to load monsters!");
		return;
	}

	if (!g_scripts->loadScripts("monster", false, false)) {
		startupErrorMessage("Failed to load lua monsters");
		return;
	}

	if (!Outfits::getInstance().loadFromXml()) {
		startupErrorMessage("Unable to load outfits!");
		return;
	}

	std::string worldType = asLowerCaseString(g_config.getString(ConfigManager::WORLD_TYPE));
	if (worldType == "pvp") {
		g_game.setWorldType(WORLD_TYPE_PVP);
	} else if (worldType == "no-pvp") {
		g_game.setWorldType(WORLD_TYPE_NO_PVP);
	} else if (worldType == "pvp-enforced") {
		g_game.setWorldType(WORLD_TYPE_PVP_ENFORCED);
	} else {
		std::cout << std::endl;
		startupErrorMessage(fmt::format("Unknown world type: {:s}, valid world types are: pvp, no-pvp and pvp-enforced.", g_config.getString(ConfigManager::WORLD_TYPE)));
		return;
	}
	std::cout << asUpperCaseString(worldType);

	if (!g_game.loadMainMap(g_config.getString(ConfigManager::MAP_NAME))) {
		startupErrorMessage("Failed to load map");
		return;
	}

	g_game.setGameState(GAME_STATE_INIT);

	// Game client protocols
	services->add<ProtocolGame>(static_cast<uint16_t>(g_config.getNumber(ConfigManager::GAME_PORT)));
	services->add<ProtocolLogin>(static_cast<uint16_t>(g_config.getNumber(ConfigManager::LOGIN_PORT)));

	// OT protocols
	services->add<ProtocolStatus>(static_cast<uint16_t>(g_config.getNumber(ConfigManager::STATUS_PORT)));

	// Legacy login protocol
	services->add<ProtocolOld>(static_cast<uint16_t>(g_config.getNumber(ConfigManager::LOGIN_PORT)));

	RentPeriod_t rentPeriod;
	std::string strRentPeriod = asLowerCaseString(g_config.getString(ConfigManager::HOUSE_RENT_PERIOD));

	if (strRentPeriod == "yearly") {
		rentPeriod = RENTPERIOD_YEARLY;
	} else if (strRentPeriod == "weekly") {
		rentPeriod = RENTPERIOD_WEEKLY;
	} else if (strRentPeriod == "monthly") {
		rentPeriod = RENTPERIOD_MONTHLY;
	} else if (strRentPeriod == "daily") {
		rentPeriod = RENTPERIOD_DAILY;
	} else {
		rentPeriod = RENTPERIOD_NEVER;
	}

	g_game.map.houses.payHouses(rentPeriod);

	IOMarket::checkExpiredOffers();
	IOMarket::getInstance().updateStatistics();

	std::cout << " | (All Done!!)" << std::endl;
	auto ServerEndTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();

	std::cout << "Elapsed: " << ServerEndTime - ServerStartTime << "ms" << std::endl;
#ifndef _WIN32
	if (getuid() == 0 || geteuid() == 0) {
		std::cout << "> Warning: " << STATUS_SERVER_NAME << " has been executed as root user, please consider running it as a normal user." << std::endl;
	}
#endif

	g_game.start(services);
	g_game.setGameState(GAME_STATE_NORMAL);
	g_loaderSignal.notify_all();
}

bool argumentsHandler(const StringVector& args)
{
	for (const auto& arg : args) {
		if (arg == "--help") {
			std::clog << "Usage:\n"
			"\n"
			"\t--config=$1\t\tAlternate configuration file path.\n"
			"\t--ip=$1\t\t\tIP address of the server.\n"
			"\t\t\t\tShould be equal to the global IP.\n"
			"\t--login-port=$1\tPort for login server to listen on.\n"
			"\t--game-port=$1\tPort for game server to listen on.\n";
			return false;
		} else if (arg == "--version") {
			printServerVersion();
			return false;
		}

		StringVector tmp = explodeString(arg, "=");

		if (tmp[0] == "--config")
			g_config.setString(ConfigManager::CONFIG_FILE, tmp[1]);
		else if (tmp[0] == "--ip")
			g_config.setString(ConfigManager::IP, tmp[1]);
		else if (tmp[0] == "--login-port")
			g_config.setNumber(ConfigManager::LOGIN_PORT, std::stoi(tmp[1]));
		else if (tmp[0] == "--game-port")
			g_config.setNumber(ConfigManager::GAME_PORT, std::stoi(tmp[1]));
	}

	return true;
}

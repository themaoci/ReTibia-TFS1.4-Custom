// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"
#include "discord.h"
#include "protocollogin.h"

#include "outputmessage.h"
#include "tasks.h"

#include "configmanager.h"
#include "iologindata.h"
#include "ban.h"
#include "game.h"

#include <fmt/format.h>

extern ConfigManager g_config;
extern Game g_game;
extern Discord g_discord;

void ProtocolLogin::disconnectClient(const std::string& message, uint16_t version)
{
	auto output = OutputMessagePool::getOutputMessage();

	output->addByte(version >= 1076 ? 0x0B : 0x0A);
	output->addString(message);
	send(output);

	disconnect();
}

void ProtocolLogin::getCharacterList(const std::string& accountName, const std::string& password, const std::string& token, uint16_t version)
{
	Account account;
	if (!IOLoginData::loginserverAuthentication(accountName, password, account)) {
		disconnectClient("Account name or password is not correct.", version);
		return;
	}

	uint32_t ticks = time(nullptr) / AUTHENTICATOR_PERIOD;

	auto output = OutputMessagePool::getOutputMessage();
	if (!account.key.empty()) {
		if (token.empty() || !(token == generateToken(account.key, ticks) || token == generateToken(account.key, ticks - 1) || token == generateToken(account.key, ticks + 1))) {
			output->addByte(0x0D);
			output->addByte(0);
			send(output);
			disconnect();
			return;
		}
		output->addByte(0x0C);
		output->addByte(0);
	}

	const std::string& motd = g_config.getString(ConfigManager::MOTD);
	if (!motd.empty()) {
		//Add MOTD
		output->addByte(0x14);
		output->addString(fmt::format("{:d}\n{:s}", g_game.getMotdNum(), motd));
	}

	//Add session key
	output->addByte(0x28);
	output->addString(accountName + "\n" + password + "\n" + token + "\n" + std::to_string(ticks));

	//Add char list
	output->addByte(0x64);

	uint8_t size = std::min<size_t>(std::numeric_limits<uint8_t>::max(), account.characters.size());

	if (g_config.getBoolean(ConfigManager::ONLINE_OFFLINE_CHARLIST)) {
		output->addByte(2); // number of worlds

		for (uint8_t i = 0; i < 2; i++) {
			output->addByte(i); // world id
			output->addString(i == 0 ? "Offline" : "Online");
			output->addString(g_config.getString(ConfigManager::IP));
			output->add<uint16_t>(g_config.getNumber(ConfigManager::GAME_PORT));
			output->addByte(0);
		}
	} else {
		output->addByte(1); // number of worlds
		output->addByte(0); // world id
		output->addString(g_config.getString(ConfigManager::SERVER_NAME));
		output->addString(g_config.getString(ConfigManager::IP));
		output->add<uint16_t>(g_config.getNumber(ConfigManager::GAME_PORT));
		output->addByte(0);
	}

	output->addByte(size);
	for (uint8_t i = 0; i < size; i++) {
		const std::string& character = account.characters[i];
		if (g_config.getBoolean(ConfigManager::ONLINE_OFFLINE_CHARLIST)) {
			output->addByte(g_game.getPlayerByName(character) ? 1 : 0);
		} else {
			output->addByte(0);
		}
		output->addString(character);
	}

	//Add premium days
	output->addByte(0);
	if (g_config.getBoolean(ConfigManager::FREE_PREMIUM)) {
		output->addByte(1);
		output->add<uint32_t>(0);
	} else {
		output->addByte(account.premiumEndsAt > time(nullptr) ? 1 : 0);
		output->add<uint32_t>(account.premiumEndsAt);
	}

	send(output);

	disconnect();
}

void ProtocolLogin::onRecvFirstMessage(NetworkMessage& msg)
{
	if (g_game.getGameState() == GAME_STATE_SHUTDOWN) {
		disconnect();
		return;
	}
  
  uint16_t OS = msg.get<uint16_t>();
  uint16_t version = msg.get<uint16_t>();
  uint32_t clientFileSize = std::stoi(msg.getString());
  uint32_t version2 = msg.get<uint32_t>();
  uint32_t signature_module = msg.get<uint32_t>();
  uint32_t signature_dat = msg.get<uint32_t>();
  uint32_t signature_spr = msg.get<uint32_t>();
  uint32_t signature_pic = msg.get<uint32_t>();
  bool isDevTest = OS == 19203;
  //std::cout << msg.getPosition() << std::endl;
  if(isDevTest) {
    std::cout << "OS = " << OS << std::endl;
    std::cout << "version = " << version << std::endl;
    std::cout << "sec_fileSize = " << clientFileSize << std::endl;
    std::cout << "sec_datSig = " << signature_dat << std::endl;
    std::cout << "sec_sprSig = " << signature_spr << std::endl;
    std::cout << "sec_picSig = " << signature_pic << std::endl;
    std::cout << "sec_moduleSig = " << signature_module << std::endl;
    // std::cout << version << " vs " << version2 << std::endl; 
  }  

  const int32_t SEC_moduleSig = g_config.getNumber(ConfigManager::SECURITY_MODULESIG);
  const int32_t SEC_fileSize = g_config.getNumber(ConfigManager::SECURITY_FILESIZE);
  const int32_t SEC_datSig = g_config.getNumber(ConfigManager::SECURITY_DATSIG);
  const int32_t SEC_sprSig = g_config.getNumber(ConfigManager::SECURITY_SPRSIG);
  const int32_t SEC_picSig = g_config.getNumber(ConfigManager::SECURITY_PICSIG);


  // if(version != version2){
		// disconnectClient("Usage of custom client detected!! Check #5", version);
		// return;
  // }
	// if (version >= 971) {
		// msg.skipBytes(17);
	// } else {
		// msg.skipBytes(12);
	// }
	/*
	 * Skipped bytes:
	 * 4 bytes: protocolVersion
	 * 12 bytes: dat, spr, pic signatures (4 bytes each)
	 * 1 byte: 0
	 */

	// if (version <= 760) {
		// disconnectClient(fmt::format("Only clients with protocol {:s} allowed!", CLIENT_VERSION_STR), version);
		// return;
	// }

	if (!Protocol::RSA_decrypt(msg)) {
		disconnect();
		return;
	}

	xtea::key key;
	key[0] = msg.get<uint32_t>();
	key[1] = msg.get<uint32_t>();
	key[2] = msg.get<uint32_t>();
	key[3] = msg.get<uint32_t>();
	enableXTEAEncryption();
	setXTEAKey(std::move(key));

	if (version != CLIENT_VERSION_MIN && version != CLIENT_VERSION_MAX) {
		std::cout << "client version" << std::endl;
		disconnectClient("Usage of custom client detected!! Check #6", version);
		return;
	}

	if (g_game.getGameState() == GAME_STATE_STARTUP) {
		std::cout << "server not up" << std::endl;
		disconnectClient("Gameworld is starting up. Please wait.", version);
		return;
	}

	if (g_game.getGameState() == GAME_STATE_MAINTAIN) {
		std::cout << "maintain" << std::endl;
		disconnectClient("Gameworld is under maintenance.\nPlease re-connect in a while.", version);
		return;
	}

  
	BanInfo banInfo;
	auto connection = getConnection();
	if (!connection) {
		return;
	}


	if (IOBan::isIpBanned(connection->getIP(), banInfo)) {
		if (banInfo.reason.empty()) {
			banInfo.reason = "(none)";
		}

		disconnectClient(fmt::format("Your IP has been banned until {:s} by {:s}.\n\nReason specified:\n{:s}", formatDateShort(banInfo.expiresAt), banInfo.bannedBy, banInfo.reason), version);
		return;
	}

	std::string accountName = msg.getString();
	if (accountName.empty()) {
		disconnectClient("Invalid account name.", version);
		return;
	}

	std::string password = msg.getString();
	if (password.empty()) {
		disconnectClient("Invalid password.", version);
		return;
	}

	// read authenticator token and stay logged in flag from last 128 bytes
	msg.skipBytes((msg.getLength() - 128) - msg.getBufferPosition());
	if (!Protocol::RSA_decrypt(msg)) {
		disconnectClient("Invalid authentication token.", version);
		return;
	}

	if (version != CLIENT_VERSION_MIN && version != CLIENT_VERSION_MAX) {
		//g_discord.webhook("https://discord.com/api/webhooks/1033439759315521547/zVzt7q0yKOiqyI1sBBt7IC-LEAFNkZR2h1bEFvlE6uz98wf14Gt0O60R0svdh6UcXAo3",
		//	fmt::format("IP: {:s} / Username: {:s} -> Version Mismatch (disconnected)", connection->getIP(), accountName));
		disconnectClient("Usage of custom client detected!!", version);
		return;
	}
  
	if(signature_module != SEC_moduleSig && SEC_moduleSig != 0){
		if (!isDevTest)
		{
		//	g_discord.webhook("https://discord.com/api/webhooks/1033439759315521547/zVzt7q0yKOiqyI1sBBt7IC-LEAFNkZR2h1bEFvlE6uz98wf14Gt0O60R0svdh6UcXAo3",
		//		fmt::format("IP: {:s} / Username: {:s} -> Client Modules Mismatch (disconnected)", connection->getIP(), accountName));
			//disconnectClient("Usage of custom client detected!!", version);
			//return;
		}
		std::cout << "CheckFailed for SEC_moduleSig (" << signature_module << " != " << SEC_moduleSig << ") [" << connection->getIP() << "] - " << accountName << std::endl;
	}
	if(clientFileSize != SEC_fileSize && SEC_fileSize != 0){
		if (!isDevTest)
		{
		//	g_discord.webhook("https://discord.com/api/webhooks/1033439759315521547/zVzt7q0yKOiqyI1sBBt7IC-LEAFNkZR2h1bEFvlE6uz98wf14Gt0O60R0svdh6UcXAo3",
		//		fmt::format("IP: {:s} / Username: {:s} -> Client Executable Mismatch (disconnected)", connection->getIP(), accountName));
			//disconnectClient("Usage of custom client detected!!", version);
			//return;
		}
		std::cout << "CheckFailed for SEC_fileSize (" << clientFileSize << " != " << SEC_fileSize << "> [" << connection->getIP() << "] - " << accountName << std::endl;
	}
	if(signature_dat != SEC_datSig && SEC_datSig != 0){
		if (!isDevTest)
		{
		//	g_discord.webhook("https://discord.com/api/webhooks/1033439759315521547/zVzt7q0yKOiqyI1sBBt7IC-LEAFNkZR2h1bEFvlE6uz98wf14Gt0O60R0svdh6UcXAo3",
		//		fmt::format("IP: {:s} / Username: {:s} -> Client Dat Mismatch (disconnected)", connection->getIP(), accountName));
			//disconnectClient("Usage of custom client detected!!", version);
			//return;
		}
		std::cout << "CheckFailed for SEC_datSig (" << signature_dat << " != " << SEC_datSig << ") [" << connection->getIP() << "] - " << accountName << std::endl;
	}
	if(signature_spr != SEC_sprSig && SEC_sprSig != 0){
		if (!isDevTest)
		{
		//	g_discord.webhook("https://discord.com/api/webhooks/1033439759315521547/zVzt7q0yKOiqyI1sBBt7IC-LEAFNkZR2h1bEFvlE6uz98wf14Gt0O60R0svdh6UcXAo3",
		//		fmt::format("IP: {:s} / Username: {:s} -> Client Sprites Mismatch (disconnected)", connection->getIP(), accountName));
			//disconnectClient("Usage of custom client detected!!", version);
			//return;
		}
		std::cout << "CheckFailed for SEC_sprSig (" << signature_spr << " != " << SEC_sprSig << ") [" << connection->getIP() << "] - " << accountName << std::endl;
	}
	if(signature_pic != SEC_picSig && SEC_picSig != 0){
		if (!isDevTest)
		{
		//	g_discord.webhook("https://discord.com/api/webhooks/1033439759315521547/zVzt7q0yKOiqyI1sBBt7IC-LEAFNkZR2h1bEFvlE6uz98wf14Gt0O60R0svdh6UcXAo3",
		//		fmt::format("IP: {:s} / Username: {:s} -> Client Pic Missmatch (disconnected)", connection->getIP(), accountName));
			//disconnectClient("Usage of custom client detected!!", version);
			//return;
		}
		std::cout << "CheckFailed for SEC_picSig (" << signature_pic << " != " << SEC_picSig << ") [" << connection->getIP() << "] - " << accountName << std::endl;
	}
  
	std::string authToken = msg.getString();

	auto thisPtr = std::static_pointer_cast<ProtocolLogin>(shared_from_this());
	g_dispatcher.addTask(createTask(std::bind(&ProtocolLogin::getCharacterList, thisPtr, accountName, password, authToken, version)));
}

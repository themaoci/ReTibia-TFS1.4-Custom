
#include "discord.h";
#include "../include/dpp/dpp.h";

Discord::Discord() {}
Discord::~Discord() {}

int Discord::post(const std::string& url, const std::string& data) {

	return -1;
}
int Discord::webhook(const std::string& wh_url, const std::string& text) {
	dpp::cluster m_bot_cluster("");
	dpp::webhook wh(wh_url);
	m_bot_cluster.execute_webhook_sync(wh, dpp::message(text));
	return 0;
}

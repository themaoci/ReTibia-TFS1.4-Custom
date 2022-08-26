local god_server_close = TalkAction("/serverclose", "/server-")

function god_server_close.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  Helpers.logCommand(player, words, param)

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	if param == "shutdown" then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	else
		Game.setGameState(GAME_STATE_CLOSED)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now closed.")
	end
	return false
end

god_server_close:separator(" ")
god_server_close:register()
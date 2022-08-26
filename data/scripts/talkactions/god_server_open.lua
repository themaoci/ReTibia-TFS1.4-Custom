local god_server_open = TalkAction("/serveropen", "/server+")

function god_server_open.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  Helpers.logCommand(player, words, param)

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	Game.setGameState(GAME_STATE_NORMAL)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now open.")
	return false
end

god_server_open:register()
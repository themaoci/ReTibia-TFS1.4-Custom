local god_server_open = TalkAction("/shutdown")

function god_server_open.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
  	Helpers.logCommand(player, words, param)

	Game.setGameState(GAME_STATE_SHUTDOWN)
	--player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now open.")
	return false
end

god_server_open:register()
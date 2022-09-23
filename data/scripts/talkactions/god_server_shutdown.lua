local god_server_shutdown = TalkAction("/shutdown")

function god_server_shutdown.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
  	Helpers.logCommand(player, words, param)

	Game.setGameState(GAME_STATE_SHUTDOWN)
	Discord.webhook(
		"https://discord.com/api/webhooks/1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_", 
		"**Server got restarted by Administrator. Should be up and ready for login in few seconds.**")

	--player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now open.")
	return false
end

god_server_shutdown:register()
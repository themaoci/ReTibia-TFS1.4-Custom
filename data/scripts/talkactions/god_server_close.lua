local god_server_close = TalkAction("/serverclose", "/server-")

function god_server_close.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
  	Helpers.logCommand(player, words, param)

	if param == "shutdown" then
		Game.setGameState(GAME_STATE_SHUTDOWN)
		Discord.webhook(
			"https://discord.com/api/webhooks/1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_", 
			"**Server got restarted by Administrator. Should be up and ready for login in few seconds.**")	
	else
		Game.setGameState(GAME_STATE_CLOSED)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now closed.")
		Discord.webhook(
			"https://discord.com/api/webhooks/1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_", 
			"**Server has been closed now. We will notify you immidietly when server will be open again.**")
		end
	return false
end

god_server_close:separator(" ")
god_server_close:register()
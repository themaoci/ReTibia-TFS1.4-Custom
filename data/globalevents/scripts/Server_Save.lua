local function ServerSave()
	if configManager.getBoolean(configKeys.SERVER_SAVE_SHUTDOWN) then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	else
		local closeAtServerSave = configManager.getBoolean(configKeys.SERVER_SAVE_CLOSE)
		if closeAtServerSave then
			Game.setGameState(GAME_STATE_CLOSED)
		end

		saveServer()

		if configManager.getBoolean(configKeys.SERVER_SAVE_CLEAN_MAP) then
			cleanMap()
		end

		if closeAtServerSave then
			Game.setGameState(GAME_STATE_NORMAL)
		end
	end
end

local function ServerSaveWarning(time)
	local remaningTime = tonumber(time) - 60000

	if configManager.getBoolean(configKeys.SERVER_SAVE_NOTIFY_MESSAGE) then
		Game.broadcastMessage("Server is saving game in " .. (remaningTime/60000) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
		Discord.webhook("https://discord.com/api/webhooks/1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_", "**Server is saving game in " .. (remaningTime/60000) .."  minute(s). Please logout.**")
	end

	if remaningTime > 60000 then
		addEvent(ServerSaveWarning, 60000, remaningTime)
	else
		addEvent(ServerSave, 60000)
	end
end

function onThink(interval)
	local remaningTime = configManager.getNumber(configKeys.SERVER_SAVE_NOTIFY_DURATION) * 60000
	if configManager.getBoolean(configKeys.SERVER_SAVE_NOTIFY_MESSAGE) then
		Game.broadcastMessage("Server is saving game in " .. (remaningTime/60000) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
		Discord.webhook("https://discord.com/api/webhooks/1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_", "**Server is saving game in " .. (remaningTime/60000) .."  minute(s). Please logout.**")
	end

	addEvent(ServerSaveWarning, 60000, remaningTime)
	return not configManager.getBoolean(configKeys.SERVER_SAVE_SHUTDOWN)
end

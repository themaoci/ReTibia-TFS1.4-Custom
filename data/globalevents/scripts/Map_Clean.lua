
function ServerCleanup()
    cleanMap()
end

function onTime(interval)
	local remaningTime = 1 * 60000
    Game.broadcastMessage("Map will be cleaned " .. (remaningTime/60000) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
	addEvent(ServerCleanup, 60000, remaningTime)
	return false
end
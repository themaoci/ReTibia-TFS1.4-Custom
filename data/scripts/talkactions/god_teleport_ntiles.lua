local god_teleport_ntiles = TalkAction("/a")

function god_teleport_ntiles.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  Helpers.logCommand(player, words, param)

	local steps = tonumber(param)
	if not steps then
		return false
	end

	local position = player:getPosition()
	position:getNextPosition(player:getDirection(), steps)

	position = player:getClosestFreePosition(position, false)
	if position.x == 0 then
		player:sendCancelMessage("You cannot teleport there.")
		return false
	end

	player:teleportTo(position)
	return false
end

god_teleport_ntiles:separator(" ")
god_teleport_ntiles:register()
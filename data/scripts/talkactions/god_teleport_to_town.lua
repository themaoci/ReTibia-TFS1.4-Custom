local god_teleport_to_town = TalkAction("/town")

function god_teleport_to_town.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  Helpers.logCommand(player, words, param)

	local town = Town(param)
	if town == nil then
		town = Town(tonumber(param))
	end

	if town == nil then
		player:sendCancelMessage("Town not found.")
		return false
	end

	player:teleportTo(town:getTemplePosition())
	return false
end

god_teleport_to_town:separator(" ")
god_teleport_to_town:register()
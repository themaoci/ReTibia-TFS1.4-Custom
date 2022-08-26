local god_teleport_to_creature = TalkAction("/goto")

function god_teleport_to_creature.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  Helpers.logCommand(player, words, param)

	local target = Creature(param)
	if target == nil then
		player:sendCancelMessage("Creature not found.")
		return false
	end

	player:teleportTo(target:getPosition())
	return false
end

god_teleport_to_creature:separator(" ")
god_teleport_to_creature:register()
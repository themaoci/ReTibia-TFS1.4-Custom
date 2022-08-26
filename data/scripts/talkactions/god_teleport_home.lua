local god_teleport_home = TalkAction("/t")

function god_teleport_home.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  Helpers.logCommand(player, words, param)

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end

god_teleport_home:register()
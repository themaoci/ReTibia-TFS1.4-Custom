local god_down = TalkAction("/down")

function god_down.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local position = player:getPosition()
	position.z = position.z + 1
	player:teleportTo(position)
	return false
end

god_down:register()
local god_position = TalkAction("/pos")

function god_position.onSay(player, words, param)
	if player:getGroup():getAccess() and param ~= "" then
    Helpers.logCommand(player, words, param)

		local split = param:split(",")
		player:teleportTo(Position(split[1], split[2], split[3]))
	end
	return false
end

god_position:separator(" ")
god_position:register()

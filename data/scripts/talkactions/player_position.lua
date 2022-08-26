local player_position = TalkAction("!pos")

function player_position.onSay(player, words, param)
		local position = player:getPosition()
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your current position is: " .. position.x .. ", " .. position.y .. ", " .. position.z .. ".")
	return false
end

player_position:separator(" ")
player_position:register()

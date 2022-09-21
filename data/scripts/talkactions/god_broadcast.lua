local god_broadcast = TalkAction("/B", "/broadcast")

function god_broadcast.onSay(player, words, param)
	if not getPlayerFlagValue(player, PlayerFlag_CanBroadcast) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
	end
	return false
end

god_broadcast:separator(" ")
god_broadcast:register()
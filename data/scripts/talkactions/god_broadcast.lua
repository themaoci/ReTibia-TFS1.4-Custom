local god_broadcast = TalkAction("/B", "/broadcast")

function god_broadcast.onSay(player, words, param)
	if not getPlayerFlagValue(player, PlayerFlag_CanBroadcast) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
	Discord.webhook("https://discord.com/api/webhooks/1022938910361387120/SADLVfZd2NWT_H1YEQGUcT_ucrz-g9_DV4ya3Abv2EWkwxrgTZH0zN6oHx7KSbYSw_cW", "BROADCAST: " .. param)
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
	end
	return false
end

god_broadcast:separator(" ")
god_broadcast:register()
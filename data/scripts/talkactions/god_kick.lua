local god_kick = TalkAction("/kick")

function god_kick.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local target = Player(param)
	if target == nil then
		player:sendCancelMessage("Player not found.")
		return false
	end

	if target:getGroup():getAccess() then
		player:sendCancelMessage("You cannot kick this player.")
		return false
	end

	target:remove()
	return false
end

god_kick:separator(" ")
god_kick:register()
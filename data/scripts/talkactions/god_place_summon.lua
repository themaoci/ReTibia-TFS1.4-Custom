local god_place_summon = TalkAction("/ps", "/summon")

function god_place_summon.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
  	Helpers.logCommand(player, words, param)

	local position = player:getPosition()
	local monster = Game.createMonster(param, position)
	if monster ~= nil then
		monster:setMaster(player)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

god_place_summon:separator(" ")
god_place_summon:register()
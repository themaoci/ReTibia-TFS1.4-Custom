function onLogout(player)
	local playerId = player:getId()
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end
  db.query("UPDATE `players` SET `isonline` = '0' WHERE `id` = " .. player:getGuid())
	return true
end

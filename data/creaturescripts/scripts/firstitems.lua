function onLogin(player)
	if player:getLastLoginSaved() == 0 then
		for i = 1, #GameConfig.StartItems.items do
			player:addItem(GameConfig.StartItems.items[i][1], GameConfig.StartItems.items[i][2])
		end
	
		local backpack = player:getVocation():getId() == 0 and player:addItem(1987) or player:addItem(1988)
		if not backpack then
			return true
		end
	
		for i = 1, #GameConfig.StartItems.container do
			backpack:addItem(GameConfig.StartItems.container[i][1], GameConfig.StartItems.container[i][2])
		end
		-- for i = 1, #firstItems do
		-- 	player:addItem(firstItems[i], 1)
		-- end
		-- player:addItem(player:getSex() == 0 and 2651 or 2650, 1)
		-- player:addItem(ITEM_BAG, 1):addItem(2674, 1)
	end
	return true
end

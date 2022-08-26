function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == LOCATION_ROOKGARD["BearRoom"].LeverId.Left then
		local stoneItem = Tile(LOCATION_ROOKGARD["BearRoom"].position):getItemById(LOCATION_ROOKGARD["BearRoom"].StoneId)
		if stoneItem then
			stoneItem:remove()
			item:transform(LOCATION_ROOKGARD["BearRoom"].LeverId.Right)
		end
	else
		Tile(LOCATION_ROOKGARD["BearRoom"].position):relocateTo(LOCATION_ROOKGARD["BearRoom"].newPosition)
		Game.createItem(LOCATION_ROOKGARD["BearRoom"].StoneId, 1, LOCATION_ROOKGARD["BearRoom"].position)
		item:transform(LOCATION_ROOKGARD["BearRoom"].LeverId.Left)
	end
	return true
end

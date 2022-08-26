-- NOT USED
function moveToPosition(self, toPosition, pushMove, monsterPosition)
	if self:getPosition() == toPosition then
		return false
	end

	if not Tile(toPosition) then
		return false
	end

	for i = self:getThingCount() - 1, 0, -1 do
		local thing = self:getThing(i)
		if thing then
			if thing:isItem() then
				if thing:getId() ~= LOCATION_ROOKGARD["CaveBridge"].bridgeId then
					thing:moveTo(toPosition)
				end
			elseif thing:isCreature() then
				if monsterPosition and thing:isMonster() then
					thing:teleportTo(monsterPosition, pushMove)
				else
					thing:teleportTo(toPosition, pushMove)
				end
			end
		end
	end
	return true
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local leverLeft, lever = item.itemid == 1945
	for i = 1, #LOCATION_ROOKGARD["CaveBridge"].leverPositions do
		lever = Tile(LOCATION_ROOKGARD["CaveBridge"].leverPositions[i]):getItemById(leverLeft and 1945 or 1946)
		if lever then
			lever:transform(leverLeft and 1946 or 1945)
		end
	end

	local tile, tmpItem, bridge
	if leverLeft then
		for i = 1, #LOCATION_ROOKGARD["CaveBridge"].bridgePositions do
			bridge = LOCATION_ROOKGARD["CaveBridge"].bridgePositions[i]
			tile = Tile(bridge.position)

			tmpItem = tile:getGround()
			if tmpItem then
				tmpItem:transform(LOCATION_ROOKGARD["CaveBridge"].bridgeId)
			end

			if bridge.itemId then
				tmpItem = tile:getItemById(bridge.itemId)
				if tmpItem then
					tmpItem:remove()
				end
			end
		end
	else
		for i = 1, #LOCATION_ROOKGARD["CaveBridge"].bridgePositions do
			bridge = LOCATION_ROOKGARD["CaveBridge"].bridgePositions[i]
			tile = Tile(bridge.position)

			moveToPosition(tile, LOCATION_ROOKGARD["CaveBridge"].relocatePosition, true, LOCATION_ROOKGARD["CaveBridge"].relocateMonsterPosition)
			tile:getGround():transform(bridge.groundId)
			Game.createItem(bridge.itemId, 1, bridge.position)
		end

	end
	return true
end

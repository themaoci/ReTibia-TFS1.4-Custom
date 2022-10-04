local ec = EventCallback

-- for ease of using it multiple times and just changing it once...
function sendChannelMessageToPlayer(player, message) 
	player:sendChannelMessage(nil, message, TALKTYPE_CHANNEL_Y, 9)
end

ec.onDropLoot = function(self, corpse)
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local player = Player(corpse:getCorpseOwner())
	local mType = self:getType()
	if not player or player:getStamina() > 840 then
		local monsterLoot = mType:getLoot()
		for i = 1, #monsterLoot do
			local item = corpse:createLootItem(monsterLoot[i])
			if not item then
				print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
			end
		end

		if player then
			local text = ("Loot of %s:\n%s"):format(mType:getNameDescription(), corpse:getContentDescription())
			local party = player:getParty()
			if party then
				for member in pairs(party:getMembers()) do 
					sendChannelMessageToPlayer(player, "[" .. player:getName() .. "]" .. text)
				end
			else
				sendChannelMessageToPlayer(player, text)
			end
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			for member in pairs(party:getMembers()) do 
				sendChannelMessageToPlayer(player, "[" .. player:getName() .. "]" .. text)
			end
		else
			sendChannelMessageToPlayer(player, text)
		end
	end
end

ec:register()

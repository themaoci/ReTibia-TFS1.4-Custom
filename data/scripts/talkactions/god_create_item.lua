local god_create_item = TalkAction("/i", "/additem", "/addItem", "/itemAdd", "/itemadd", "/item+")


function god_create_item.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
  	Helpers.logCommand(player, words, param)

	if(param == "help") then
		local helpMessage = "Command usage:\n/i ItemId,Amount\nExample: {/i 2160,100}"
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, helpMessage)
		return false
	end

	local split = param:split(",")

	local itemType = ItemType(split[1])
	if itemType:getId() == 0 then
		itemType = ItemType(tonumber(split[1]))
		if tonumber(split[1]) == nil or itemType:getId() == 0 then
			player:sendCancelMessage("There is no item with that id or name.")
			return false
		end
	end

	local count = tonumber(split[2])
	if count ~= nil then
		if itemType:isStackable() then
			count = math.min(10000, math.max(1, count))
		elseif not itemType:isFluidContainer() then
			count = math.min(100, math.max(1, count))
		else
			count = math.max(0, count)
		end
	else
		if not itemType:isFluidContainer() then
			count = 1
		else
			count = 0
		end
	end

	local result = player:addItem(itemType:getId(), count)


	if result ~= nil then
		if not itemType:isStackable() then
			if type(result) == "table" then
				for _, item in ipairs(result) do
					item:decay()
				end
			else
				result:decay()
			end
		end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
	local itemName = itemType:getName() or "undefined"
	local playerName = player:getName() or "undefined"
	Discord.webhook(
		"https://discord.com/api/webhooks/1022949135449608274/PzK5sXneCWIfjaDQd7-yusVdcD5wC_nbOVD0Vti94tQ-46FcUSpqcyJ-uEF7kbzOUaMo",
		"Item [" .. itemName .. "] x" .. count .. " by '" .. playerName .. "'")


	return false
end

god_create_item:separator(" ")
god_create_item:register()
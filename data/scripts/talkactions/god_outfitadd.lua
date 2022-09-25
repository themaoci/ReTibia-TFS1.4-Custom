local god_outfit = TalkAction("/outfit")

function god_outfit.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local params = param.split(',')
	local playerSex = player:getSex()
	local player = Player(param[2])
	if(player == nil) then 
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Wrong player specified, unable to find " .. param[2])
		return
	end
	if params[1] == "help" then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage:\n/outfit add{del,showall},PnayerName,OutfitName")
		return
	end
	if params[1] == "add" then
		local outfitName = param[3]
		local foundOutfit = nil
		for i = 1, #GameConfig.Outfits do
			if GameConfig.Outfits[i].name == outfitName then
				if GameConfig.Outfits[i].sex == playerSex then
					foundOutfit = GameConfig.Outfits[i]
				end
			end
		end
		if foundOutfit == nil then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit not found, unable to find " .. outfitName)
			return 
		end
		player:addOutfitAddon(foundOutfit.id, 3)
		return 
	end
	if params[1] == "del" or params[1] == "remove" then
		local outfitName = param[3]
		local foundOutfit = nil
		for i = 1, #GameConfig.Outfits do
			if GameConfig.Outfits[i].name == outfitName then
				if GameConfig.Outfits[i].sex == playerSex then
					foundOutfit = GameConfig.Outfits[i]
				end
			end
		end
		if foundOutfit == nil then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit not found, unable to find " .. outfitName)
			return 
		end
		player:removeOutfit(foundOutfit.id)
		return 
	end
	if params[1] == "showall" then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit List:")
		for i = 1, #GameConfig.Outfits do
			if GameConfig.Outfits[i].sex == playerSex then
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, GameConfig.Outfits[i].name)
				foundOutfit = GameConfig.Outfits[i]
			end
		end
		return
	end
end

god_outfit:separator(" ")
god_outfit:register()

function onStartup()

	db.query("TRUNCATE TABLE `players_online`")
	db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")
	db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
	db.asyncQuery("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	db.asyncQuery("DELETE FROM `market_history` WHERE `inserted` <= " .. (os.time() - configManager.getNumber(configKeys.MARKET_OFFER_DURATION)))

	-- Move expired bans to ban history
	local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	if resultId ~= false then
		repeat
			local accountId = result.getNumber(resultId, "account_id")
			db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getString(resultId, "reason")) .. ", " .. result.getNumber(resultId, "banned_at") .. ", " .. result.getNumber(resultId, "expires_at") .. ", " .. result.getNumber(resultId, "banned_by") .. ")")
			db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Check house auctions
	local resultId = db.storeQuery("SELECT `id`, `highest_bidder`, `last_bid`, (SELECT `balance` FROM `players` WHERE `players`.`id` = `highest_bidder`) AS `balance` FROM `houses` WHERE `owner` = 0 AND `bid_end` != 0 AND `bid_end` < " .. os.time())
	if resultId ~= false then
		repeat
			local house = House(result.getNumber(resultId, "id"))
			if house then
				local highestBidder = result.getNumber(resultId, "highest_bidder")
				local balance = result.getNumber(resultId, "balance")
				local lastBid = result.getNumber(resultId, "last_bid")
				if balance >= lastBid then
					db.query("UPDATE `players` SET `balance` = " .. (balance - lastBid) .. " WHERE `id` = " .. highestBidder)
					house:setOwnerGuid(highestBidder)
				end
				db.asyncQuery("UPDATE `houses` SET `last_bid` = 0, `bid_end` = 0, `highest_bidder` = 0, `bid` = 0 WHERE `id` = " .. house:getId())
			end
		until not result.next(resultId)
		result.free(resultId)
	end

	-- store towns in database
	db.query("TRUNCATE TABLE `towns`")
	for i, town in ipairs(Game.getTowns()) do
		local position = town:getTemplePosition()
		db.query("INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES (" .. town:getId() .. ", " .. db.escapeString(town:getName()) .. ", " .. position.x .. ", " .. position.y .. ", " .. position.z .. ")")
	end


	GameConfig.Spells.Instant = Game.getAllInstants()
	GameConfig.Spells.Rune = Game.getAllRunes()
	GameConfig.Outfits = Game.getAllOutfits()
	GameConfig.Mounts = Game.getAllMounts()

	-- print("------------- Instanty")
	-- for i in pairs(GameConfig.Spells.Instant) do
	-- 	print(" [\"".. GameConfig.Spells.Instant[i].words .."\"] = { name=\"".. GameConfig.Spells.Instant[i].name .."\", isPremium=\"".. GameConfig.Spells.Instant[i].isPremium .."\" }, ")
	-- end

	-- print("------------- Runy")
	-- for i in pairs(GameConfig.Spells.Rune) do 
	-- 	print("{ [\"".. GameConfig.Spells.Rune[i].id .."\"] = { name=\"".. GameConfig.Spells.Rune[i].name .."\", isPremium=\"".. GameConfig.Spells.Rune[i].isPremium .."\" },")
	-- end

	-- print("GameConfig.Spells.Instant: " .. #GameConfig.Spells.Instant)
	-- print("GameConfig.Spells.Rune: " .. #GameConfig.Spells.Rune)
	-- print("GameConfig.Outfits: " .. #GameConfig.Outfits)
	-- print("GameConfig.Mounts: " .. #GameConfig.Mounts)

	Discord.webhook("https://discord.com/api/webhooks/1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_", "**Server is Online!!**")
end

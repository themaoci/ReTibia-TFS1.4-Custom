local map_clean = TalkAction("/clean")

function map_clean.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

  	Helpers.logCommand(player, words, param)

	local itemCount = cleanMap()
	if itemCount > 0 then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Cleaned " .. itemCount .. " item" .. (itemCount > 1 and "s" or "") .. " from the map.")
	end
	return false
end

map_clean:register()
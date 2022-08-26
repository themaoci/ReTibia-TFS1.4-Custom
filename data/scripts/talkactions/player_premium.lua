local config = {
	days = 7,
	maxDays = 365,
	price = 10000
}
local player_premium = TalkAction("!premium")
function player_premium.onSay(player, words, param)
	if configManager.getBoolean(configKeys.FREE_PREMIUM) then
		return true
	end

  if (param == "") then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have " .. player:getPremiumDays() .." days of premium left.")
      return false
  elseif (param == "buy") then
    if player:getPremiumDays() <= config.maxDays then
      if player:removeMoney(config.price) then
        player:addPremiumDays(config.days)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have bought " .. config.days .." days of premium account.")
      else
        player:sendCancelMessage("You don't have enough money, " .. config.maxDays .. " days premium account costs " .. config.price .. " gold coins.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
      end
    else
      player:sendCancelMessage("You can not buy more than " .. config.maxDays .. " days of premium account.")
      player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
  end
	return false
end
player_premium:separator(" ")
player_premium:register()
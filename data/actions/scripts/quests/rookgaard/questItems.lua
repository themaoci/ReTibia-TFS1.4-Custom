--999--Storage is taken (used to free wand/rod in magic shop)

--7000 - 7999 is reserved storage ids for Rook quests only--

--7001 = Semour Exchange quest, Present and gain legion helmet.
--7002 = Willie Exchange quest, Banana and gain studded shield.
--7003 = Billy Exchange quest, Pan and gain antidote rune.
--7004 = Lee'Delle Exchange quest, Honey Flower and Studded legs.
--7005 = Al Dee Exchange quest, Small axe and gain pick.
--7007 = Amber Exchange quest, Ambers Notebook and gain short sword.
--7027 = Benny Carter quest, help him deal with few missions.
--7028 = Benny Carter quest, Kill rats storage.
--7029 = Benny Carter quest, Kill spiders storage.
--7030 = Benny Carter quest, Kill Aaron.
--7032 = Benny Carter quest, Vocation quest.
--7033 = Benny Carter quest, Minotaur mage switch quest.
--7034 = Golden Key Quest.
--7035 Movement tile for Spike sword (Poison spider cave)
--7036 Movement tile for Spike sword (Rotworm cave)
--7037 Access to the door above Tom's shop
--7041 Spike sword storage for web (given in last door)
function onUse(cid, item, frompos, item2, topos)
  -- use quick ItemActionSettings
  local uId_settings = LOCATION_ROOKGARD["ItemAction"][item.uid]
  if(uId_settings ~= nil) then
    -- found staff to do
    if getPlayerStorageValue(cid,item.uid) <= 0 then
      if getPlayerFreeCap(cid) <= uId_settings.reqCap then
        doPlayerSendTextMessage(cid,22,"You need " .. uId_settings.reqCap .. " cap or more to loot this!")
        return TRUE
      end
      doPlayerSendTextMessage(cid,22,uId_settings.sendTextMessage)
      local container = nil
      if(uId_settings.containerId ~= nil) then
        container = doPlayerAddItem(cid, uId_settings.containerId, 1)
      end
      for itemData in pairs(uId_settings.itemsToAdd) do
        if(container ~= nil) then
          doAddContainerItem(container, itemData.id, itemData.amount)
        else
          local Item = doPlayerAddItem(cid,itemData.id,itemData.amount)
          if(itemData.specialDescription ~= "") then
            doSetItemText(Item, itemData.specialDescription)
          end
          if(itemData.actionId ~= "") then
            doSetItemActionId(Item, itemData.actionId)
          end
        end
      end
      setPlayerStorageValue(cid,item.uid,1)
    else
      doPlayerSendTextMessage(cid,22,uId_settings.alreadyPickedUp)
    end
    return 1
  end

  -- Spike Sword Quest --
  -- Key 0013 (Open's the mino mage door)
  if item.uid == 7038 then
    if getPlayerStorageValue(cid,7038) <= 0 then
      if getPlayerStorageValue(cid,7037) ~= 1 then
      doPlayerSendTextMessage(cid,22,"Something is weird about this stone.")
      return TRUE
      end
      if getPlayerFreeCap(cid) <= 1 then
      doPlayerSendTextMessage(cid,22,"You need 1 cap or more to loot this!")
      return TRUE
      end
    doPlayerSendTextMessage(cid,22,"You have found a golden key.")
    SPIKESWORDKEY = doPlayerAddItem(cid, Cfgoldenkey, 1)
    doSetItemActionId(SPIKESWORDKEY, 2043)
    doSetItemSpecialDescription(SPIKESWORDKEY, "(Key: 0013)")	
    setPlayerStorageValue(cid,7038,1)
    else
    doPlayerSendTextMessage(cid,22,"it's empty.")
    end
  -- Key 0015 (Opens Toms bedroom)
  elseif item.uid == 7039 then
    if getPlayerStorageValue(cid,7039) <= 0 then
      if getPlayerStorageValue(cid,7037) ~= 1 then
      doPlayerSendTextMessage(cid,22,"Something is weird about this corpse.")
      return TRUE
      end
      if getPlayerFreeCap(cid) <= 1 then
      doPlayerSendTextMessage(cid,22,"You need 1 cap or more to loot this!")
      return TRUE
      end
    doPlayerSendTextMessage(cid,22,"You have found a copper key.")
    KEY = doPlayerAddItem(cid, Cfcopperkey, 1)
    doSetItemActionId(KEY, 2045)
    doSetItemSpecialDescription(KEY, "(Key: 0015)")	
    setPlayerStorageValue(cid,7039,1)
    else
    doPlayerSendTextMessage(cid,22,"it's empty.")
    end
  -- Key 0011 (Opens Gobblin switch rooms)
  elseif item.uid == 7040 then
    if getPlayerStorageValue(cid,7040) <= 0 then
      if getPlayerStorageValue(cid,7040) ~= 1 then
      doPlayerSendTextMessage(cid,22,"Something is weird about this chest.")
      return TRUE
      end
      if getPlayerFreeCap(cid) <= 1 then
      doPlayerSendTextMessage(cid,22,"You need 1 cap or more to loot this!")
      return TRUE
      end
    doPlayerSendTextMessage(cid,22,"You have found a copper key.")
    KEY = doPlayerAddItem(cid, Cfcopperkey, 1)
    doSetItemActionId(KEY, 2046)
    doSetItemSpecialDescription(KEY, "(Key: 0011)")	
    setPlayerStorageValue(cid,7040,1)
    else
    doPlayerSendTextMessage(cid,22,"it's empty.")
    end
  -----
  -----
  else	
    return 0
  end
  return 1
end

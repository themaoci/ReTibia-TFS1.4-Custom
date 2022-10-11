--999-- Storage is taken (used to free wand/rod in magic shop)

--7000 - 7999 is reserved storage ids for Rook quests only--

RookGaardQuestItems_Config = {
  scriptStartUID = 7000,
	reward = {
    -- 1 -- Semour Exchange quest, Present and gain legion helmet.
    -- 2 -- Willie Exchange quest, Banana and gain studded shield.
    -- 3 -- Billy Exchange quest, Pan and gain antidote rune.
    -- 4 -- Lee'Delle Exchange quest, Honey Flower and Studded legs.
    -- 5 -- Al Dee Exchange quest, Small axe and gain pick.
		[6] = { --ambers notebook--
			name = "ambers notebook", 
			items = {
				[1] = { id = 1955, count = 1, capReq = 10, text = "Hardek *\nBozo *\nSam ****\nOswald\nPartos ***\nQuentin *\nTark ***\nHarsky ***\nStutch *\nFerumbras *\nFrodo **\nNoodles ****"}
			}
		},
    -- 7 -- Amber Exchange quest, Ambers Notebook and gain short sword.
		[8] = { -- Letter + Salmon --
			name = "letter and some salmon", 
			items = {
				[1] = { id = 2597, count = 1, text = "", capReq = 1},
				[2] = { id = 2668, count = 2, capReq = 3}
			}
		},
		[9] = { -- Bear Room Key -- 
			name = "bear room key", 
			items = {
				[1] = { id = 2089, count = 1, actionId = 2004, description = "(Key: 4601)"}
			}
		},
		[10] = { -- Bear Room Chain Armor -- 
			name = "Chain Armor", 
			items = {
				[1] = { id = 2464, count = 1, capReq = 100 }
			}
		},
		[11] = { -- Bear Room Brass Helmet -- 
			name = "Brass Helmet",
			items = {
				[1] = { id = 2460, count = 1, capReq = 27 }
			}
		},
		[12] = { -- Bear Room Bag -- 
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2668, count = 12, capReq = 4 },
				[2] = { id = 2148, count = 40, capReq = 1 }
			}
		},
		[13] = { -- Combat Knife -- 
			name = "combat knife", 
			items = {
				[1] = { id = 2404, count = 1, capReq = 9 }
			}
		},
		[14] = { -- Doublet -- 
			name = "doublet", 
			items = {
				[1] = { id = 2485, count = 1, capReq = 25 }
			}
		},
		[15] = { -- Dragon corpse -- 
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2480, count = 1, capReq = 31 },
				[2] = { id = 2530, count = 1, capReq = 63 }
			}
		},
		[16] = { -- Goblin Temple #1 --
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2563, count = 1, capReq = 18 },
				[2] = { id = 1294, count = 5, capReq = 3.6 },
				[3] = { id = 2148, count = 50, capReq = 0.1 }
			}
		},
		[17] = {  -- Goblin Temple #2 --
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2006, count = 6, capReq = 18 },
				[2] = { id = 2111, count = 4, capReq = 3.6 },
				[3] = { id = 2642, count = 1, capReq = 0.1 }
			}
		},
		[18] = {  -- Katana key --
			name = "key", 
			items = {
				[1] = { id = 2088, count = 1, capReq = 1, actionId = 2007, description = "(Key: 4603)" }
			}
		},
		[19] = {  -- Katana --
			name = "katana", 
			items = {
				[1] = { id = 2412, count = 1, capReq = 31 }
			}
		},
		[20] = {  -- carlin sword --
			name = "carlin sword", 
			items = {
				[1] = { id = 2395, count = 1, capReq = 40 }
			}
		},
		[21] = {  -- carlin sword - fishing rod --
			name = "fishing rod", 
			items = {
				[1] = { id = 2580, count = 1, capReq = 9 }
			}
		},
		[22] = {  -- carlin sword - bag or arrows --
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2545, count = 40, capReq = 0.8 },
				[2] = { id = 2544, count = 40, capReq = 0.7 }
			}
		},
		[23] = {  -- Rapier --
			name = "rapier", 
			items = {
				[1] = { id = 2384, count = 1, capReq = 15 }
			}
		},
		[24] = {  -- Torch -- use it later for starting gear for players quest
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2050, count = 1, capReq = 5 } -- torch
			}
		},
		[25] = {  -- Present --
			name = "bag", 
			wrapInBag = 1988,
			items = {
				[1] = { id = 2013, count = 1, capReq = 2 }
				[2] = { id = 2035, count = 1, capReq = 1.5 }
				[3] = { id = 2014, count = 1, capReq = 7.5 }
				[4] = { id = 1990, count = 1, capReq = 6 } -- present
			}
		},
		[26] = {  -- Small Axe --
			name = "small axe", 
			items = {
				[1] = { id = 2559, count = 1, capReq = 15 }
			}
		},
    -- 27 -- Benny Carter quest, help him deal with few missions.
    -- 28 -- Benny Carter quest, Kill rats storage.
    -- 29 -- Benny Carter quest, Kill spiders storage.
    -- 30 -- Benny Carter quest, Kill Aaron.
		[31] = {  -- Banana Palm --
			name = "banana", 
			items = {
				[1] = { id = 2676, count = 1, capReq = 2 }
			}
		},
    -- 32 -- Benny Carter quest, Vocation quest.
    -- 33 -- Benny Carter quest, Minotaur mage switch quest.
    -- 34 -- Golden Key Quest.
    -- 35 -- Movement tile for Spike sword (Poison spider cave)
    -- 36 -- Movement tile for Spike sword (Rotworm cave)
    -- 37 -- Access to the door above Tom's shop
		[38] = {  -- Viking Helmet --
			name = "viking helmet", 
			items = {
				[1] = { id = 2473, count = 1, capReq = 39 }
			}
		},
    -- 41 -- Spike sword storage for web (given in last door)
  }
}
-- RETARDED ITEM ID's...
	Cfletter = 2597
	Cfsalmon = 2668
	Cfchainarmor = 2464
	Cfbrasshelmet = 2460
	Cfarrow = 2544
	Cfcombatknife = 2404
	Cfdoublet = 2485
	Cflegionhelmet = 2480
	Cfcoppershield = 2530
	Cfpan = 2563
	Cfsmallstone = 1294
	Cfsnowball = 2111
	Cfsandals = 2642
	Cfkatana = 2412
	Cfcarlinsword = 2395
	Cffishingrod = 2580
	Cfpoisonarrow = 2545
	Cfrapier = 2384
	Cftorch = 2050
	Cfbackpack = 1988
	Cfcup = 2013
	Cfplate = 2035
	Cfjug = 2014
	Cfsmallaxe = 2559
	Cfbanana = 2676
	Cfpurplekey = 2086
	Cfwoodenkey = 2087
	Cfsilverkey = 2088
	Cfcopperkey = 2089
	Cfcrystalkey = 2090
	Cfgoldenkey = 2091
	Cfbonekey = 2092


function onUse(cid, item, frompos, item2, topos)
	local reward = RookGaardQuestItems_Config.reward[item.uid - RookGaardQuestItems_Config.scriptStartUID]
	if reward ~= nil then
		if getPlayerStorageValue(cid,item.uid) <= 0 then
      local backpack = nil
      if reward.wrapInBag ~= nil then
        backpack = doPlayerAddItem(cid, reward.wrapInBag, 1)  
      end
      for _, item in pairs(reward.items) do
        -- check if item can be picked up
        if getPlayerFreeCap(cid) <= item.capReq then
          -- display information that it cannot pickup and you are missing cap
          doPlayerSendTextMessage(cid,22,"You need " .. item.capReq .. " cap or more to loot this!")
          return 1
        end
        local createdItem = nil
        if backpack ~= nil then
          -- option wrapinbag is present and backpack was created so we gonna add item with count to the backpack
          createdItem = doAddContainerItem(backpack, item.id, item.count)
        else
          -- add item to player with amount from config
          createdItem = doPlayerAddItem(cid, item.id, item.count) 
        end
        if createdItem ~= nil then
          -- set custom text of item if present in config (should work only for items that are writable)
          if item.text ~= nil then
            doSetItemText(createdItem, item.text)
          end
          -- set actionid of the item if present in config
          if item.actionId ~= nil then
            doSetItemActionId(createdItem, tonumber(item.actionId))
          end
          -- set description of the item if present in config
          if item.description ~= nil then
            doSetItemSpecialDescription(createdItem, item.description)
          end           
        end
      end
      -- display information to the player
      doPlayerSendTextMessage(cid,22,"You have found a " .. reward.name .. ".")
      -- lock second pickup now
			setPlayerStorageValue(cid,item.uid,1)
		else
		  doPlayerSendTextMessage(cid,22,"It's empty.")
		end
    return 1
	end

-- CHAIN QUESTS NEED TO BE DONE AS BELOW

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

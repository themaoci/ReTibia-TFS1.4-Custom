
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
local talkState = {}
local rtnt = {}
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. I need your help and I'll reward you with nice addons if you help me! Just say {addons} or {help} if you don't know what to do.")

local outfits = {
    {
        showedAsItem = 0,
        name = "",
        female_version = 0,
        male_version = 0,
        maxAddon = 3,
        isPremium = true,
        requirements = {
            {2160, 10} -- crystal coin x10
        }
    }
}
local mounts = {
    {
        showedAsItem = 0,
        name = "",
        mountId = 0,
        requirements = {
            {2160, 10} -- crystal coin x10
        }
    }
}
    
function creatureSayCallback(cid, type, msg)
local talkUser = cid

    if(not npcHandler:isFocused(cid)) then
        return false
    end

    if addoninfo[msg] ~= nil then
        if (getPlayerStorageValue(cid, addoninfo[msg].storageID) ~= -1) then
                npcHandler:say('You already have this addon!', cid)
                npcHandler:resetNpc()
        else
        local itemsTable = addoninfo[msg].items
        local items_list = ''
            if table.maxn(itemsTable) > 0 then
                for i = 1, table.maxn(itemsTable) do
                    local item = itemsTable[i]
                    items_list = items_list .. item[2] .. ' ' .. ItemType(item[1]):getName()
                    if i ~= table.maxn(itemsTable) then
                        items_list = items_list .. ', '
                    end
                end
            end
        local text = ''
            if (addoninfo[msg].cost > 0) then
                text = addoninfo[msg].cost .. ' gp'
            elseif table.maxn(addoninfo[msg].items) then
                text = items_list
            elseif (addoninfo[msg].cost > 0) and table.maxn(addoninfo[msg].items) then
                text = items_list .. ' and ' .. addoninfo[msg].cost .. ' gp'
            end
            npcHandler:say('For ' .. msg .. ' you will need ' .. text .. '. Do you have it all with you?', cid)
            rtnt[talkUser] = msg
            talkState[talkUser] = addoninfo[msg].storageID
            return true
        end
    elseif msgcontains(msg, "yes") then
        if (talkState[talkUser] > 10010 and talkState[talkUser] < 10100) then
            local items_number = 0
            if table.maxn(addoninfo[rtnt[talkUser]].items) > 0 then
                for i = 1, table.maxn(addoninfo[rtnt[talkUser]].items) do
                    local item = addoninfo[rtnt[talkUser]].items[i]
                    if (getPlayerItemCount(cid,item[1]) >= item[2]) then
                        items_number = items_number + 1
                    end
                end
            end
            if(getPlayerMoney(cid) >= addoninfo[rtnt[talkUser]].cost) and (items_number == table.maxn(addoninfo[rtnt[talkUser]].items)) then
                doPlayerRemoveMoney(cid, addoninfo[rtnt[talkUser]].cost)
                if table.maxn(addoninfo[rtnt[talkUser]].items) > 0 then
                    for i = 1, table.maxn(addoninfo[rtnt[talkUser]].items) do
                        local item = addoninfo[rtnt[talkUser]].items[i]
                        doPlayerRemoveItem(cid,item[1],item[2])
                    end
                end
                doPlayerAddOutfit(cid, addoninfo[rtnt[talkUser]].outfit_male, addoninfo[rtnt[talkUser]].addon)
                doPlayerAddOutfit(cid, addoninfo[rtnt[talkUser]].outfit_female, addoninfo[rtnt[talkUser]].addon)
                setPlayerStorageValue(cid,addoninfo[rtnt[talkUser]].storageID,1)
                npcHandler:say('Here you are.', cid)
            else
                npcHandler:say('You do not have needed items!', cid)
            end
            rtnt[talkUser] = nil
            talkState[talkUser] = 0
            npcHandler:resetNpc()
            return true
        end
    elseif msgcontains(msg, "addon") then
        local player = Player(cid)
          
        local window = ModalWindow(6001, "Outfits", "Here is the 'Book of Outfits' content:")
        window:addButton(100, "Next")
        window:addButton(101, "Cancel")
        local id_number = 1
        for key, value in pairs(addoninfo) do
            window:addChoice(id_number, key)
            id_number = id_number + 1
        end
      
        window:setDefaultEnterButton(100)
        window:setDefaultEscapeButton(101)
        
        window:sendToPlayer(player)
      

        --npcHandler:say('I can give you addons for {' .. table.concat(o, "}, {") .. '} outfits.', cid)
        rtnt[talkUser] = nil
        talkState[talkUser] = 0
        npcHandler:resetNpc()
        return true
    elseif msgcontains(msg, "help") then
        npcHandler:say('To buy the first addon say \'first NAME addon\', for the second addon say \'second NAME addon\'.', cid)
        rtnt[talkUser] = nil
        talkState[talkUser] = 0
        npcHandler:resetNpc()
        return true
    else
        if talkState[talkUser] ~= nil then
            if talkState[talkUser] > 0 then
            npcHandler:say('Come back when you get these items.', cid)
            rtnt[talkUser] = nil
            talkState[talkUser] = 0
            npcHandler:resetNpc()
            return true
            end
        end
    end
    return true
end

local shopItems = {}
function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    --local showAll = msgcontains(msg, 'spellsall')
    if msgcontains(msg, 'outfits') then
        shopItems = {}
        for i, outfit in pairs(outfits) do

            shopItems[#shopItems + 1] = {
                id = outfit.showedAsItem, 
                buy = 10000 * outfit.requirements[1][2], 
                sell = 0, 
                subType = 0, 
                specialId = #shopItems + 1,
                name = outfit.name,
                funcShop = 1
            }
        end
        local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks, specialId)
            if canPlayerWearOutfit() then
                npcHandler:say('You already have this addon!', cid)
                npcHandler:resetNpc()
                return true
            end
            -- check if guy can get the outfit ??
            local outfitId = 0
            local player = Player(cid)
            if player:Sex() == 0 then
                outfitId = outfits[specialId].female_version
            else
                outfitId = outfits[specialId].male_version
            end
            
            player.removeTotalMoney(shopItems[specialId].buy)
            doPlayerAddOutfit(cid, outfitId, 3)
            npcHandler:say('You have bought ' .. shopItems[specialId].name .. " outfit!", cid)
            return true
        end
        openShopWindow(cid, spells, onBuy)
        return true
    end
    if msgcontains(msg, 'mounts') then
        shopItems = {}
        local player = Player(cid)
        for i, mount in pairs(mounts) do
            if not player:hasMount(mount.id) then
                shopItems[#shopItems + 1] = {
                    id = mount.showedAsItem, 
                    buy = 10000 * mount.requirements[1][2], 
                    sell = 0, 
                    subType = 0, 
                    specialId = #shopItems + 1,
                    name = mount.name,
                    funcShop = 1
                }
            end
        end
        local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks, specialId)
            if player:hasMount(mounts[specialId].mountId) then
                npcHandler:say('You already have this mount!', cid)
                npcHandler:resetNpc()
                return true
            end
            -- check if guy can get the mount ??

            player.removeTotalMoney(shopItems[specialId].buy)
            player:addMount(mounts[specialId].mountId)
            --doPlayerAddOutfit(cid, outfitId, 3)
            npcHandler:say('You have bought ' .. shopItems[specialId].name .. " mount!", cid)
            return true
        end
        openShopWindow(cid, spells, onBuy)
        return true
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
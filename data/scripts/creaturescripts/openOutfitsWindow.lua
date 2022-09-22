Romero_DesignSeller_keywordHandler = KeywordHandler:new()
Romero_DesignSeller_npcHandler = NpcHandler:new(keywordHandler)

function onModalWindow(cid, modalWindowId, buttonId, choiceId)
    print(modalWindowId .. " " .. buttonId .. " " .. choiceId)
    if modalWindowId ~= 6001 or buttonId == 101 then
        return false
    end
    
    local id_number = 1
    local outfitData = nil
    for key, value in pairs(NPC_GLOBAL_WINDOW_OPTIONS) do
        print("from modal: " .. key)
        if id_number == choiceId then
            outfitData = value
            goto EndOutfitSearch
        end
        id_number = id_number + 1
    end
    ::EndOutfitSearch::
    print(outfitData.storageID)
    if outfitData == nil then return true end

    if (getPlayerStorageValue(cid, outfitData.storageID) ~= -1) then
        Romero_DesignSeller_npcHandler:say('You already have this addon!', cid)
        Romero_DesignSeller_npcHandler:resetNpc()
    else
    local itemsTable = outfitData.items
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
        if (outfitData.cost > 0) then
            text = outfitData.cost .. ' gp'
        elseif table.maxn(outfitData.items) then
            text = items_list
        elseif (outfitData.cost > 0) and table.maxn(outfitData.items) then
            text = items_list .. ' and ' .. outfitData.cost .. ' gp'
        end
        Romero_DesignSeller_npcHandler:say('For ' .. msg .. ' you will need ' .. text .. '. Do you have it all with you?', cid)
        rtnt[talkUser] = msg
        talkState[talkUser] = outfitData.storageID
        return true
    end

    return true
end

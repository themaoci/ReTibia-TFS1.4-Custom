local config = {
    [1] = Position({x =1000, y = 1000, z = 7}), -- Venore
    [2] = Position({x = 1000, y = 1000, z = 7}) -- Thais
}

NPC_GLOBAL_WINDOW_OPTIONS = {}
NPC_OUTFITSWINDOW_npcHandler = nil
function onModalWindow(cid, modalWindowId, buttonId, choiceId)
    if modalWindowId ~= 6001 or buttonId == 101 then
        return false
    end

    local id_number = 1
    local outfitData = nil
    for key, value in pairs(NPC_GLOBAL_WINDOW_OPTIONS) do
        print(key)
        if id_number == choiceId then
            outfitData = value
            goto EndOutfitSearch
        end
        id_number = id_number + 1
    end
    ::EndOutfitSearch::
    if outfitData == nil then return true end

    if (getPlayerStorageValue(cid, outfitData.storageID) ~= -1) then
        NPC_OUTFITSWINDOW_npcHandler:say('You already have this addon!', cid)
        NPC_OUTFITSWINDOW_npcHandler:resetNpc()
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
        NPC_OUTFITSWINDOW_npcHandler:say('For ' .. msg .. ' you will need ' .. text .. '. Do you have it all with you?', cid)
        rtnt[talkUser] = msg
        talkState[talkUser] = outfitData.storageID
        return true
    end

    return true
end


local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
local talkState = {}
local rtnt = {}
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. I'm selling clothing, and tamed wild animals. If you want to see my cloth shop type {outfits}, and if it's a tamed animal that you are looking for then say {mounts}")

    -- OUTFIT MAP GENERATOR
local outfits = {}
for i, outfit in pairs(GameConfig.Outfits) do
    if not outfit.defaultUnlocked and outfit.sex == 0 then
        outfits[#outfits + 1] = {
            showedAsItem = 2595,
            name = outfit.name,
            looktype = { outfit.id, GameConfig.Outfits[i + 55].id },
            maxAddon = 3,
            isPremium = outfit.premium,
            requirements = {
                {2160, 10} -- crystal coin x10
            }    
        }    
    end
end
    -- MOUNT MAP GENERATOR
local mounts = {}
for i, mount in pairs(GameConfig.Mounts) do
    if not mount.defaultUnlocked and outfit.sex == 0 then
        mounts[#mounts + 1] = {
            showedAsItem = 2595,
            name = mount.name,
            mountId = mount.id,
            isPremium = mount.premium,
            speedBonus = mount.speed,
            requirements = {
                {2160, 10} -- crystal coin x10
            }
        }
    end
end

    -- ACTUAL SCRIPTS
local shopItems = {}
function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local isPlayerPremium = isPremium(cid)

    -- [ OUTFITS ] 
    if msgcontains(msg, 'outfits') msgcontains(msg, 'outfit') then
        shopItems = {}
        for i, outfit in pairs(outfits) do
            if outfit.premium == 1 and isPlayerPremium or outfit.premium == 0 then
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
        end
        local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks, specialId)

            local player = Player(cid)
            local outfitId = outfits[specialId].looktype[player:Sex()]

            if canPlayerWearOutfit(cid, outfitId, 3) then
                npcHandler:say('You already have this addon!', cid)
                npcHandler:resetNpc()
                return true
            end
            -- check if guy can get the outfit ??

            player.removeTotalMoney(shopItems[specialId].buy)
            doPlayerAddOutfit(cid, outfitId, 3)
            npcHandler:say('You have bought ' .. shopItems[specialId].name .. " outfit!", cid)
            return true
        end
        openShopWindow(cid, spells, onBuy)
        return true
    end
    -- [ MOUNTS ] 
    if msgcontains(msg, 'mounts') msgcontains(msg, 'mount') then
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
                    name = mount.name .. "\n+" .. mount.speed .. " speed",
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
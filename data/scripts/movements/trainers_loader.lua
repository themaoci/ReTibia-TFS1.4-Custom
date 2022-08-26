-- Infinity Room Config
local IRConfig = {
    startPos = Position(50, 50, 15), -- upper left corner
    tpInAid = 65000, -- actionid for enter teleport
    tpOutAid = 65001, -- actionid for exit teleport
    foodAid = 65002, -- actionid for infinity food (only work with EventCallback)
    maxRoomsPer = { -- 10 x 10 = 100 rooms max
        row = 10,
        col = 10
    },
    items = {
        {1050}, -- 1 - horizontal wall
        {598, 1049}, -- 2 - vertical wall
        {598, 1057}, -- 3 - corner wall
        {1051}, -- 4 - pole wall
        {426}, -- 5 - tile train
        {407}, -- 6 - tile base
        {407, 1484}, -- 7 - coal basin
        {407, 1387, "teleport"}, -- 8 - teleport
        {407, 1642, 7159, "foodhuge"}, -- 9 - food panel
        {407, "Training Device"}, -- 10 - training monster name
        { 598 } -- 11 - 
    },
    map = { -- room drawing mask
        { 11, 11, 11, 11, 11, 11, 11},
        { 11, 4,  1,  1,  1,  1,  11},
        { 11, 2,  10, 7,  10, 2,  11},
        { 11, 2,  7,  5,  7,  2,  11},
        { 11, 2,  8,  6,  9,  2,  11},
        { 11, 2,  1,  1,  1,  3,  11},
        { 11, 11, 11, 11, 11, 11, 11}
    }
}

local IRoom, mapDistX, mapDistY = {}, #IRConfig.map[1], #IRConfig.map
IRoom.__index = IRoom
if not IRoomList then
    IRoomList = {}
end

function IRoom.new(pos, fromPos, index)
    local iroom = {}
    setmetatable(iroom, IRoom)
    iroom.pos = pos
    iroom.fromPos = fromPos
    for x = 1, mapDistX do
        for y = 1, mapDistY do
            local tilePos = Position(pos.x+x, pos.y+y, pos.z)
            local tileIndex = IRConfig.map[y][x]
            if tileIndex == 5 then iroom.center = tilePos end
            local lastItem
            for _, it in pairs(IRConfig.items[tileIndex]) do
                local thingType = type(it)
                if thingType == "number" then
                    lastItem = Game.createItem(it, 1, tilePos)
                    if not lastItem then
                        iroom:destroy()
                        debugPrint("[Warning - IRoom::new] the room could not be created correctly.")
                        return
                    end
                elseif thingType == "string" then
                    if it == "teleport" then
                        lastItem:setCustomAttribute("roomIndex", index)
                        lastItem:setAttribute(ITEM_ATTRIBUTE_ACTIONID, IRConfig.tpOutAid)
                    elseif it == "foodhuge" then
                        if EventCallback then
                            lastItem:setAttribute(ITEM_ATTRIBUTE_ACTIONID, IRConfig.foodAid)
                        end
                    else        
                        Game.createMonster(it, tilePos)
                    end
                end
            end
        end
    end
    IRoomList[index] = iroom
    return iroom
end

function IRoom:destroy()
    for x = 1, mapDistX do
        for y = 1, mapDistY do
            local pos = Position(self.pos.x+x, self.pos.y+y, self.pos.z)
            local tile = Tile(pos)
            if tile then
                local thingCount = tile:getThingCount()
                for index = thingCount, 0, -1 do
                    local thing = tile:getThing(index)
                    if thing then
                        if thing:isPlayer() then
                            thing:teleportTo(self.fromPos)
                        else
                            thing:remove()
                        end
                    end
                end
            end
        end
    end
    IRoomList[self.index] = nil
end

local function getNextPosition()
    local x, y, z = IRConfig.startPos.x, IRConfig.startPos.y, IRConfig.startPos.z
    local index, indey, pos = 1, 0, Position(x, y, z)
    for _, iroom in pairs(IRoomList) do
        if iroom.pos ~= pos then
            break
        else
            pos = Position(x + (mapDistX * index), y + (mapDistY * indey), z)
            index = index +1
            if index % IRConfig.maxRoomsPer.row == 0 then
                index, indey = 0, indey + 1
                if indey > IRConfig.maxRoomsPer.col then
                    return
                end
            end
        end
    end
    return pos, index
end

local moveOutTp = MoveEvent()
function moveOutTp.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if player then
        local roomIndex = item:getCustomAttribute("roomIndex")
        if roomIndex then
            local iroom = IRoomList[roomIndex]
            if iroom then
                player:teleportTo(iroom.fromPos)
                iroom.fromPos:sendMagicEffect(CONST_ME_TELEPORT)
                iroom:destroy()
                return true
            end
        end
    end
    return true
end
moveOutTp:aid(IRConfig.tpOutAid)
moveOutTp:register()

local moveInTp = MoveEvent()
function moveInTp.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if player then
        local pos, index = getNextPosition()
        if not pos then
            player:teleportTo(fromPosition, false)
            player:sendCancelMessage("There are no free training rooms, try later.")
            return true
        end
        local iroom = IRoom.new(pos, player:getTown():getTemplePosition(), index)
        if iroom then
            iroom.index = index
            player:teleportTo(iroom.center)
            iroom.center:sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
    return true
end
moveInTp:aid(IRConfig.tpInAid)
moveInTp:register()

local foodAction = Action()
function foodAction.onUse(player, item, toPosition, target, fromPosition, isHotkey)
    local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
    if condition and math.floor(condition:getTicks() / 1000 + (10 * 12)) >= 1200 then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are full.")
        player:say("You are full.", TALKTYPE_MONSTER_SAY)
    else
        player:feed(120)
        player:say("Mmmm.", TALKTYPE_MONSTER_SAY)
    end
    return true
end
foodAction:aid(IRConfig.foodAid)
foodAction:register()

if EventCallback then
    local ec = EventCallback
    function ec.onMoveItem(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
        if item:getActionId() == IRConfig.foodAid then
            return false
        end
        return true
    end
    ec:register(1)
end
function onUse(cid, item, frompos, item2, topos)
gatepos = {x=32177, y=32148, z=11, stackpos=1}
getgate = getThingfromPos(gatepos)
teleportpos = {x=32171, y=32149, z=11, stackpos=1}
getteleport = getThingfromPos(gatepos)
dooropen = {x=32173, y=32148, z=11}
wallclosed = {x=32178, y=32148, z=11}
dumppos = {x=32178, y=32148, z=11}

if item.itemid == 1945 then
doRemoveItem(getgate.uid,1)
doRemoveItem(getteleport.uid,1)
doCreateTeleport(1387, dooropen, teleportpos)
doCreateItem(1210,1,gatepos)
doTransformItem(item.uid,item.itemid+1)

elseif item.itemid == 1946 then
doRemoveItem(getgate.uid,1)
doRemoveItem(getteleport.uid,1)
doCreateTeleport(1387, wallclosed, teleportpos)
doCreateItem(1025,1,gatepos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end

-- 462, 323, 11 -- door position


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  if item.itemid == LOCATION_ROOKGARD["KatanaQuest"].LeverId.Right then
    local doorItem = Tile(LOCATION_ROOKGARD["KatanaQuest"].position):getItemById(LOCATION_ROOKGARD["KatanaQuest"].DoorId.Close)
    if doorItem then
      doorItem:transform(LOCATION_ROOKGARD["KatanaQuest"].DoorId.Open)
      doorItem:setActionId(1002)
      item:transform(LOCATION_ROOKGARD["KatanaQuest"].LeverId.Left)
    end
  else
    local tile = Tile(LOCATION_ROOKGARD["KatanaQuest"].position)
    local doorItem = tile:getItemById(LOCATION_ROOKGARD["KatanaQuest"].DoorId.Open)
    if doorItem == nil then
      doorItem = tile:getItemById(LOCATION_ROOKGARD["KatanaQuest"].DoorId.Close)
    end
    if doorItem then
      tile:relocateTo(LOCATION_ROOKGARD["KatanaQuest"].newPosition, true)

      doorItem:transform(LOCATION_ROOKGARD["KatanaQuest"].DoorId.Close)
      doorItem:setActionId(1001)
      item:transform(LOCATION_ROOKGARD["KatanaQuest"].LeverId.Right)
    else 
      
    end
  end
  return true
end
  
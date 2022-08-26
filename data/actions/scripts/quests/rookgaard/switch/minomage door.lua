function onUse(cid, item, frompos, item2, topos)
  local data = LOCATION_ROOKGARD['MinoMage']
  if item.itemid == data.LeverLeft then
    local WallThing = getThingfromPos(data.WallPosition)
    doRemoveItem(WallThing.uid, 1)
    local ACTIONDOOR = doCreateItem(data.ReplacementDoor, 1, WallThing)
    doSetItemActionId(ACTIONDOOR, data.ReplacementDoorActionId)
    doTransformItem(data.LeverRight)
  elseif item.itemid == data.LeverRight then
    doPlayerSendCancel(cid,"The switch seems to be stuck.")
  end
  return 1
end
  
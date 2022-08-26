function onUse(cid, item, frompos, item2, topos)
  local data = LOCATION_ROOKGARD["AcademyQuest"]
  if item.itemid == data.LeverLeft then
    local GateThing = getThingfromPos(data.GatePosition)
    doRemoveItem(GateThing.uid, 1)
    doTransformItem(item.uid, data.LeverRight)
  elseif item.itemid == data.LeverRight then
    doCreateItem(data.StoneWall, 1, data.GatePosition)
    doTransformItem(item.uid, data.LeverLeft)
  else
    doPlayerSendCancel(cid,"Sorry not possible.")
  end
  return 1
end
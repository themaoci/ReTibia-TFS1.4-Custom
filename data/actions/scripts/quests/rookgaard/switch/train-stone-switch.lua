function onUse(cid, item, frompos, item2, topos)
  gatepos = {x=394, y=347, z=8, stackpos=1}
  local GateThing = getThingfromPos(data.GatePosition)
  local data = LOCATION_ROOKGARD['TrainWithMonster']
  if item.uid == data.uID and item.itemid == data.LeverLeft and GateThing.itemid == 1354 then
    doRemoveItem(GateThing.uid,1)
    doTransformItem(item.uid,item.itemid+1)
  elseif item.uid == data.uID and item.itemid == data.LeverRight and GateThing.itemid == 0 then
    doCreateItem(1354,1,gatepos)
    doTransformItem(item.uid,item.itemid-1)
  else
    doPlayerSendCancel(cid,"Sorry not possible.")
  end
  return 1
end
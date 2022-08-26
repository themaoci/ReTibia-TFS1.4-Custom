function onUse(cid, item, frompos, item2, topos)
  gatepos1 = {x=385, y=380, z=8, stackpos=1}
  --getgate1 = getThingfromPos(gatepos1)
  gatepos2 = {x=386, y=380, z=8, stackpos=1}
  --getgate2 = getThingfromPos(gatepos2)

  switchpos1 = {x=383, y=379, z=8}
  switchpos2 = {x=389, y=379, z=8}
  --dumppos = {x=387, y=380, z=8}
    
  if item.itemid == 1945 then	
    doCreateItem(1284,1,gatepos1)
    doCreateItem(1284,1,gatepos2)
    doTransformItem(getTileItemById(switchpos1, 1945).uid,1946)
    doTransformItem(getTileItemById(switchpos2, 1945).uid,1946)		  
  elseif item.itemid == 1946 then
    doCreateItem(493,1,gatepos1)
    doCreateItem(493,1,gatepos2)
    doTransformItem(getTileItemById(switchpos1, 1946).uid,1945)
    doTransformItem(getTileItemById(switchpos2, 1946).uid,1945)
  else
    doPlayerSendCancel(cid,"Sorry not possible.")
  end
  return 1
  end

function onUse(cid, item, frompos, item2, topos)
  -- local data = LOCATION_ROOKGARD['TrainWithMonster']
  -- local ActionId = item:getActionId()
  -- local optionPos = data.Option[ActionId]
  
  -- if item.itemid == data.LeverLeft then
  --   local thingFromPos = getThingfromPos(optionPos)
  --   doRemoveItem(thingFromPos.uid, 1)
  --   doTransformItem(item.uid, data.LeverRight)

  -- elseif item.itemid == data.LeverRight then
  --   doCreateItem(data.FrameworkWall, 1, optionPos)
  --   doTransformItem(item.uid, data.LeverLeft)
  -- else
  --   doPlayerSendCancel(cid,"Sorry not possible.")
  -- end
  return 1
end
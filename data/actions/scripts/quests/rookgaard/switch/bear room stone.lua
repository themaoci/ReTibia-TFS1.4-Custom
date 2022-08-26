function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  local data = LOCATION_ROOKGARD["BearRoom"]
  if item.itemid == data.LeverId.Left then
    local stoneItem = Tile(data.position):getItemById(data.StoneId)
    if stoneItem then
      stoneItem:remove()
      item:transform(data.LeverId.Right)
    end
  else
    Tile(LOCATION_ROOKGARD["BearRoom"].position):relocateTo(data.newPosition)
    Game.createItem(data.StoneId, 1, data.position)
    item:transform(data.LeverId.Left)
  end
  return true
end
local gwp_wallpos = {x=455, y=321, z=11}
local gwp_wallRightpos = {x=456, y=321, z=11}
local gwp_wallLeftpos = {x=454, y=321, z=11}
function onUse(cid, item, frompos, item2, topos)
 
  if getPlayerStorageValue(cid, 7019) == 1 and getPlayerStorageValue(cid, 7038) == 1 then 
    local playerPos = Player(cid):getPosition()
    Discord_Debug(playerPos.x .. " == " .. gwp_wallRightpos.x .. " " ..  playerPos.y .. " == " .. gwp_wallRightpos.y)
    Discord_Debug(playerPos.x .. " == " .. gwp_wallLeftpos.x .. " " ..  playerPos.y .. " == " .. gwp_wallLeftpos.y)
    if playerPos.x == gwp_wallRightpos.x and playerPos.y == gwp_wallRightpos.y then
      playerPos.x = gwp_wallLeftpos.x
      Discord_Debug("teleport 1")
      --playerPos.y = gwp_wallLeftpos.y
      player:teleportTo(playerPos)
      return 1
    end
    if playerPos.x == gwp_wallLeftpos.x and playerPos.y == gwp_wallLeftpos.y then
      playerPos.x = gwp_wallRightpos.x
      Discord_Debug("teleport 2")
      --playerPos.y = gwp_wallRightpos.y
      player:teleportTo(playerPos)
      return 1
    end
    return 1
  end
  doPlayerSendCancel(cid, "Seems like this wall is different from the others here...")
  return 1
end
  
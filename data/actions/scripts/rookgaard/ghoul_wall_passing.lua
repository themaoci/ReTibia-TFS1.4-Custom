local gwp_wallpos = {x=455, y=321, z=11}
local gwp_wallRightpos = {x=456, y=321, z=11}
local gwp_wallLeftpos = {x=454, y=321, z=11}
function onUse(cid, item, frompos, item2, topos)
 
  if getPlayerStorageValue(cid, 7019) == 1 and getPlayerStorageValue(cid, 7038) == 1 then 
    Discord_Debug(frompos.x .. " == " .. gwp_wallRightpos.x .. " " ..  frompos.y .. " == " .. gwp_wallRightpos.y)
    Discord_Debug(frompos.x .. " == " .. gwp_wallLeftpos.x .. " " ..  frompos.y .. " == " .. gwp_wallLeftpos.y)
    if frompos.x == gwp_wallRightpos.x and frompos.y == gwp_wallRightpos.y then
      frompos.x = gwp_wallLeftpos.x
      frompos.y = gwp_wallLeftpos.y
      player:teleportTo(frompos, false)
      return 1
    end
    if frompos.x == gwp_wallLeftpos.x and frompos.y == gwp_wallLeftpos.y then
      frompos.x = gwp_wallRightpos.x
      frompos.y = gwp_wallRightpos.y
      player:teleportTo(frompos, false)
      return 1
    end
    return 1
  end
  doPlayerSendCancel(cid, "Seems like this wall is different from the others here...")
  return 1
end
  
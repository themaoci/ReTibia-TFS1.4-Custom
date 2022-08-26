local ec = EventCallback

ec.onShareExperience = function(exp, creature, rawExp)

print(exp)
print(rawExp)
print(creature:getName())
[[
 Experience will be scaled accordingly to the distance of all your party members 
 if players are too far away you wont get ay experience from them
]]
  [[local defaultExpNegStart = 20
  local defaultExpNegEnds  = 100
  local diff = defaultExpNegEnds - defaultExpNegStart
	local sharedExperienceMultiplier = GameConfig.sharedExpPercentage --20%
  
  local distances = 0
  local players = 0
  local expGainerPos = creature:getPosition()
  
  for _, member in ipairs(self:getMembers()) do
    local playerPos = member:getPosition()
    local distanceX = leaderPos.x - playerPos.x
    local distanceY = leaderPos.y - playerPos.y
    players = players + 1
    local calculatedDistance = math.floor(math.sqrt(distanceX^2 + distanceY^2)) 
    if calculatedDistance > 0 then
      distances = distances + calculatedDistance
    end
  end
  distances = distances / players
  local scaled = 1
  if distances => 100 then
    scaled = 0
  elseif distances > 20 and distances < 100 then
    scaled = (((distances - 20) * -1) / diff) + 1
  end
  local 

	return (exp * sharedExperienceMultiplier) * scaled)
  ]]
  return exp * GameConfig.sharedExpPercentage
end

ec:register()

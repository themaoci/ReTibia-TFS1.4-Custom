local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local config = {
  npcAllowedVocation = "mage",
	vocations = {
		["warrior"] = {
			text = "You have been blessed by |||||| |||||||| and now you can call yourself a Warrior!",
			vocationId = 2,
			--equipment
			{
      },
			--container jagged sword, daramian mace, rope, shovel, health potion
			{
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 50}, -- health potion
        {7620, 10}, -- mana potion
        {2152, 20}  -- platinum coins
      }
		},
		["mage"] = {
			text = "You have been blessed by |||||| |||||||| and now you can call yourself a Mage!",
			vocationId = 3,
			--equipment
			{
      },
			--container
			{
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 10}, -- health potion
        {7620, 50}, -- mana potion
        {2152, 30}  -- platinum coins
      }
		},
		["all_rounder"] = {
			text = "You have been blessed by |||||| |||||||| and now you can call yourself a All Rounder!",
			vocationId = 1,
			--equipment
			{
      },
			--container
			{
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 25}, -- health potion
        {7620, 25}, -- mana potion
        {2152, 100} -- platinum coins
      }
		}
	}
}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function greetCallback(cid)
	local player = Player(cid)
	--local level = player:getLevel()
	local mlevel = player:getMagicLevel()
  if(mlevel > 0) then
    npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", are you prepared to receive my blessing of the Mage")
	else
    npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", you are yet to grow in strength before you can receive my blessing")
		npcHandler:resetNpc(cid)
  end
  return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
  local player = Player(cid)
  local receivedBlessing = player:getVocation() ~= 0
  if receivedBlessing then
		npcHandler:resetNpc(cid)
    return true
  end
  print(msg)
  if msgcontains(msg, "yes") then
    print("we are ok now")
    player:setVocation(Vocation(config.vocation[config.npcAllowedVocation].vocationId))
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received a backpack with starting items.")
    
    local targetVocation = config.vocations[config.npcAllowedVocation]
    for i = 1, #targetVocation[1] do
      player:addItem(targetVocation[1][i][1], targetVocation[1][i][2])
    end
    local backpack = player:addItem(1988)
    for i = 1, #targetVocation[2] do
      backpack:addItem(targetVocation[2][i][1], targetVocation[2][i][2])
    end
    npcHandler:say(config.vocation[config.npcAllowedVocation].text, cid)
  end
	return true
end



npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
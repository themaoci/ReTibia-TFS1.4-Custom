local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}

local config = {
  npcAllowedVocation = "warrior",
	vocations = {
		["warrior"] = {
			text = "You have been blessed by (|_|/?|()|_|_\\~ |)[-|\\/||(_,()|) and now you can call yourself a Warrior!",
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
			text = "You have been blessed by (|_|/?|()|_|_\\~ |)[-|\\/||(_,()|) and now you can call yourself a Mage!",
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
			text = "You have been blessed by (|_|/?|()|_|_\\~ |)[-|\\/||(_,()|) and now you can call yourself a All Rounder!",
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
	local level = player:getLevel()
  
  npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", I can see that you are determined to receive my blessing of the Warrior right?")
	
  return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
  local player = Player(cid)
  if msgcontains(msg, "yes") then
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
  else
    
  end
	return true
end

local function onAddFocus(cid)
	town[cid] = 0
	vocation[cid] = 0
end

local function onReleaseFocus(cid)
	town[cid] = nil
	vocation[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
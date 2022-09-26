local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onCastSpell(creature, variant)
print(type(creature))
if creature == nil then 
	print(creature)
	print(creature:getName())
	--local min = 104.8
	--local max = 134.8
	return true 
end
local creatureLevel = creature:getLevel() or 1
local creatureMLevel = creature:getMagicLevel() or 1
  local min = (creatureLevel / 5) + (creatureMLevel * 4.6) + 100
  local max = (creatureLevel / 5) + (creatureMLevel * 9.6) + 125
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		local master = target:getMaster()
		if target:isPlayer() or master and master:isPlayer() then
			doTargetCombat(creature, target, COMBAT_HEALING, min, max)
		end
	end
	return true
end

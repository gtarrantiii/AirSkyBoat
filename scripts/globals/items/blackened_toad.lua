-----------------------------------
-- ID: 4599
-- Item: Blackened Toad
-- Food Effect: 180Min, All Races
-----------------------------------
-- Dexterity 2
-- Agility 2
-- Mind -1
-- Poison Resist 4
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4599)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.POISONRES, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.POISONRES, 4)
end

return itemObject

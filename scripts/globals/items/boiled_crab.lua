-----------------------------------
-- ID: 4456
-- Item: Boiled Crab
-- Food Effect: 30Min, All Races
-----------------------------------
-- Vitality 2
-- defense % 27
-- defense % 50
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4456)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.FOOD_DEFP, 27)
    target:addMod(xi.mod.FOOD_DEF_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.FOOD_DEFP, 27)
    target:delMod(xi.mod.FOOD_DEF_CAP, 50)
end

return itemObject

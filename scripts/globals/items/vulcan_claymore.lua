-----------------------------------
-- ID: 18379
-- Item: Vulcan Claymore
-- Item Effect: Enfire
-- Duration: 3 minutes
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENFIRE)
    if effect ~= nil and effect:getItemSourceID() == xi.items.VULCAN_CLAYMORE then
        target:delStatusEffect(xi.effect.ENFIRE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.VULCAN_CLAYMORE) then
        local effect = xi.effect.ENFIRE
        local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
        local potency = 0

        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end

        potency = utils.clamp(potency, 3, 25)

        target:addStatusEffect(effect, potency, 0, 180, 0, 0, 0, xi.items.VULCAN_CLAYMORE)
    end
end

return itemObject

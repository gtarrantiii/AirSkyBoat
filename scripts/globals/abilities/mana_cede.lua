-----------------------------------
-- Ability: Mana Cede
-- Description: Channels your MP into TP for avatars and elementals.
-- Obtained: SMN Level 87
-- Recast Time: 00:05:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    -- target:addStatusEffect(xi.effect.MANA_CEDE, 15, 1, 1) -- TODO: implement xi.effect.MANA_CEDE
end

return abilityObject

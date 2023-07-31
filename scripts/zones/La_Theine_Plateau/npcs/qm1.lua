-----------------------------------
-- Area: Latheine Plateau
-- NPC: ??? (qm1) 17195582
-- Note: Spawns Goblin Archaeologist
-- position changes every X minutes
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
local laTheineGlobal = require("scripts/zones/La_Theine_Plateau/globals")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}
local popthreshold = 4000 --gil value
local popdelay = 6000 --delay between repop of qm
local popmovetimer = 5000 --delay between moves of qm

local depths = {
    [1] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_26)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_4)
    end,
    [2] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_25)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_5)
    end,
    [3] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_24)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_5)
    end,
    [4] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_23)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_6)
    end,
    [5] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_22)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_6)
    end,
    [6] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_21)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_7)
    end,
    [7] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_20)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_7)
    end,
    [8] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_19)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_8)
    end,
    [9] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_18)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_8)
    end,
    [10] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_17)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_9)
    end,
    [11] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_16)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_9)
    end,
    [12] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_15)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_10)
    end,
    [13] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_14)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_10)
    end,
    [14] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_13)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_11)
    end,
    [15] = function(player)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_12)
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_11)
    end,
}

entity.onSpawn = function(npc)
    npc:timer(popmovetimer, function()
        laTheineGlobal.moveGoblinArchaeologistQM()
    end)
end

entity.onTrade = function(player, npc, trade)
    local tradeValue = 0
    local currentDepth = 15 --this should match depth size
    local stepValue = math.floor(popthreshold/currentDepth)
    local validContainer = true

    if (npc:getLocalVar('LPGADEPTH')) and (npc:getLocalVar('LPGADEPTH') > 0) then
        currentDepth = npc:getLocalVar('LPGADEPTH')
    end

    for i = 0, trade:getSlotCount()-1 do
        local item=trade:getItem(i)
        local itemId = trade:getItemId(i)
        local itemQty = trade:getItemQty(itemId)

        --nothing too unique
        if (item:isRareEx()) then
            validContainer = false
            break
        end

        --no pay to win.. lol
        if(itemId == 65535) then
            validContainer = false
            break
        end

        --doesnt have a base price
        if(item:getBasePrice() == 0) then
            validContainer = false
            break
        end

        --all good add to the value
        tradeValue = tradeValue + (item:getBasePrice() * itemQty)
    end

    if (validContainer) then
        --how many steps does the traded value cover?
        currentDepth = currentDepth - math.floor(tradeValue/stepValue)
    else
        --refused
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_2)
        return
    end

    --take item(s) and apply
    player:confirmTrade()

    if currentDepth > 0 then
        local d = depths[currentDepth]
        if (d) then
            d(player)
        else
            player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_2)
        end
        npc:setLocalVar('LPGADEPTH',currentDepth)
    else
        player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_3)
        npcUtil.popFromQM(player, npc, ID.mob.GOBLINARCHAEOLOGIST, { radius = 1, hide = popdelay })
        npc:setLocalVar('LPGADEPTH',0)
    end


end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.GOBLIN_ARCHAEOLOGIST_1)
end

return entity

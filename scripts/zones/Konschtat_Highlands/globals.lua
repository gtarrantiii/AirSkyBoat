-- Zone: Konschtat Highlands (108)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local konschtatGlobal =
{
     moveGoblinArchaeologistQM = function(secondsHidden)

        local gaQMPositions =
        {
            [1] =  { 198.052, 24.000,  298.607 },
            --[2] =  { 318.872, 24.122,  32.000 },
            --[3] =  { 328.155, 24.134,  -29.127 },
        }

        local goblinArchaeologistQM = GetNPCByID(ID.npc.GOBLIN_ARCHAEOLOGIST_QM)
        local newPosition = npcUtil.pickNewPosition(ID.npc.GOBLIN_ARCHAEOLOGIST_QM, gaQMPositions)

        if secondsHidden ~= nil and secondsHidden > 0 then

            --zone active check - server variable to set which crag is currently active ?
            --if this one then hide and move
            goblinArchaeologistQM:hideNPC(secondsHidden)
        end

        goblinArchaeologistQM:setPos(newPosition.x, newPosition.y, newPosition.z)

    end

}

return konschtatGlobal

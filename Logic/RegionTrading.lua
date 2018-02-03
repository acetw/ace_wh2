-- ===========================================================================
-- file: Logic/RegionTrading
-- author: Hardballer
--
-- Region trading logic
-- ===========================================================================

local Logger = require("Core/Logger").new("Logic", "RegionTrading");
local Event = require("Core/Event");
local Model = require("Model");


local RegionTrading = {};
local M = {};

M.player = nil --: ACE_Faction
M.ai = nil --: ACE_Faction




function M.init()
    M.player = Model.getPlayer();
end

Event.addListener("UICreated", M.init);



-- ===========================================================================
-- Public functions
-- ===========================================================================

--v function(name: string)
function RegionTrading.setAI(name)
    M.ai = Model.getFaction(name);
    Logger:Log("AI faction set to " .. tostring(M.ai));
end


--v function() --> boolean
function RegionTrading.canTrade()
    -- Determine whether or not the player
    -- can trade regions with the AI
    if M.player:IsHorde()
        or M.ai:IsHorde()
        or M.player:AtWarWith(M.ai)
    then
        return false;
    end

    return true;
end


return RegionTrading

-- ===========================================================================
-- file: Model/Faction
-- author: Hardballer
--
-- Faction Model Class
-- ===========================================================================

local Logger = require("Core/Logger").new("Model", "Faction");
local Model = require("Model");


local Faction = {} --# assume Faction: ACE_Faction
local M = {};


M.factions = {} --: map<string, ACE_Faction>




-- ===========================================================================
-- Faction constructor
-- ===========================================================================

--v function(name: string) --> ACE_Faction
function M.new(name)
    local self = {};
    setmetatable(self, {
        __index = Faction,
        __tostring = function() return "ACE Faction: "..name end
    }) --# assume self: ACE_Faction


    self.name = name --: const string


    M.factions[name] = self;

    Logger:Log("Create: "..tostring(self));
    return self;
end


-- ===========================================================================
-- Faction class methods
-- ===========================================================================

--v function(self: ACE_Faction) --> CA_Faction
function Faction.cai(self)
    return cm:model():world():faction_by_key(self.name);
end


--v function(self: ACE_Faction, faction: ACE_Faction) --> boolean
function Faction.AtWarWith(self, faction)
    return self:cai():at_war_with(faction:cai());
end

--v function(self:ACE_Faction) --> boolean
function Faction.IsHorde(self)
    return self:cai():is_horde();
end


-- ===========================================================================
-- Model functions
-- ===========================================================================

--v function(name: string) --> ACE_Faction
function Model.getFaction(name)
    return M.factions[name] or M.new(name);
end

--v function() --> ACE_Faction
function Model.getPlayer()
    return Model.getFaction(cm:get_local_faction());
end

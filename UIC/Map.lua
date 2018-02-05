-- ===========================================================================
-- file: UIC/Map
-- author: Hardballer
--
-- Map UIC Class
-- ===========================================================================

--# assume global class ACE_Map

local Logger = require("Core/Logger").new("UIC", "Map");

local Map = {} --# assume Map: ACE_Map
local Instance = nil --: ACE_Map


-- ===========================================================================
-- Constructor
-- ===========================================================================

--v function(parent: CA_UIC) --> ACE_Map
function Map.new(parent)
    if Instance then
        Logger:Error("trying to create a new Map but one is already opened");
        return nil;
    end


    local self = {};
    setmetatable(self, {
        __index = Map,
        __tostring = function() return "ACE Map" end
    }) --# assume self: ACE_Map


    self.layout = UIComponent( core:get_ui_root():Find("layout") ) --: const
    self.radarParent = UIComponent( self.layout:Find("radar_parent") ) --: const
    self.radar = UIComponent( self.radarParent:Find("radar") ) --: const


    self.layout:SetVisible(true);
    parent:Adopt(self.radar:Address());
    self.layout:SetVisible(false);

    Instance = self;

    Logger:Log("Create map");
    return self;
end



--v function(self: ACE_Map)
function Map.Destroy(self)
    self.layout:SetVisible(true);
    self.radarParent:Adopt(self.radar:Address());
    self.layout:SetVisible(false);

    Logger:Log("Destroy map");
    Instance = nil;
end


return Map

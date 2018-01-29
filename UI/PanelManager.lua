-- ===========================================================================
-- file: UI/PanelManager
-- author: Hardballer
--
-- Manager for custom panel class
-- ===========================================================================

--# assume global class ACE_Panel
--# type local CB_Bool = function() --> boolean
--# type local CB_UI = function(context: CA_UIContext)

--# type local PanelName = 
--# "DiplomacyDropdown"


local Logger = require("Core/Logger").new("UI", "PanelManager");
local Event = require("Core/Event");

local PanelManager = {};
local M = {};

local Panel = {} --# assume Panel: ACE_Panel    -- The panel class for internal use only
M.panels = {} --: map<string, ACE_Panel>        -- Panel collection




-- ===========================================================================
-- Register a new panel (ACE_Panel constructor)
-- ===========================================================================

--v function(name: PanelName, cbOpen: CB_Bool, cbClose: CB_Bool, cbClick: CB_UI)
function PanelManager.register(name, cbOpen, cbClose, cbClick)    
    local self = {};
    
    setmetatable(self, {
        __index = Panel,
        __tostring = function() return "ACE PANEL: "..name end
    }) --# assume self: ACE_Panel
    

    self.name = name        --: const
    self.cbOpen = cbOpen    --: const 
    self.cbClose = cbClose  --: const
    self.cbClick = cbClick  --: const
    self.clickID = nil      --: string  -- event handler id    
    self.opened = false     --: boolean -- is this panel opened ?

    M.panels[name] = self;

    Logger:Log("register " .. tostring(self));
end


-- ===========================================================================
-- Panel class method
-- ===========================================================================

--v function(self: ACE_Panel)
function Panel.Open(self)
    if self.opened then return end

    if self.cbOpen() then
        self.opened = true;
        if self.cbClick then
            self.clickID = Event.addListener("ComponentLClickUp", self.cbClick);
        end
        Logger:Log("open Panel: " .. self.name);
    end
end

--v function(self: ACE_Panel)
function Panel.Close(self)
    if not self.opened then return end

    if self.cbClose() then
        self.opened = false;
        if self.cbClick then
            Event.removeListener(self.clickID);
        end

        Logger:Log("close Panel: " .. self.name);
    end
end


-- ===========================================================================
-- Panel Manager
-- ===========================================================================

--v function(name: PanelName) --> ACE_Panel
function M.getPanel(name) 
    if not M.panels[name] then
        Logger:Error("trying to get a non-existent panel: " .. name);
    end

    return M.panels[name];
end

--v function(name: PanelName)
function PanelManager.open(name) 
    M.getPanel(name):Open();
end

--v function(name: PanelName)
function PanelManager.close(name)
    M.getPanel(name):Close();
end

--v function(name: PanelName) --> boolean
function PanelManager.isOpened(name)
    return M.getPanel(name).opened;
end


-- ===========================================================================
-- Listener to trigger the opening / closing of the panels
-- ===========================================================================

--v function(context: CA_UIContext)
function M.PanelOpenedCampaign(context)
    local name = context.string;

    if name == "diplomacy_dropdown" then
        PanelManager.open("DiplomacyDropdown");
        return;
    end
end

--v function(context: CA_UIContext)
function M.PanelClosedCampaign(context)
    local name = context.string;

    if name == "diplomacy_dropdown" then
        PanelManager.close("DiplomacyDropdown");
        return;
    end
end


Event.addListener("PanelOpenedCampaign", M.PanelOpenedCampaign);
Event.addListener("PanelClosedCampaign", M.PanelClosedCampaign);


return PanelManager

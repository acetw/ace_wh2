-- ===========================================================================
-- file: UI/RegionTrading
-- author: Hardballer
--
-- Region trading panel
-- ===========================================================================

local Logger = require("Core/Logger").new("UI", "RegionTrading");
local PanelManager = require("UI/PanelManager");
local MenuFrame = require("UIC/MenuFrame");


local M = {};

M.frame = nil --: ACE_MenuFrame

M.diploPanel = nil --: CA_UIC
M.offersPanel = nil --: CA_UIC




function M.init() 
    local root = core:get_ui_root();

    M.diploPanel = UIComponent( root:Find("diplomacy_dropdown") );    
    M.offersPanel = UIComponent( M.diploPanel:Find("offers_panel") );
end


-- ===========================================================================
-- Region trading frame
-- ===========================================================================

function M.createFrame() 
    M.frame = MenuFrame.new(M.diploPanel, "RegionTradingFrame");

    M.frame:PropagatePriority(250);
    M.frame:Resize(M.offersPanel:Dimensions());
    M.frame:SetTitle("Trade regions");
end

function M.deleteFrame() 
    M.frame:Delete();
end


-- ===========================================================================
-- Panel functions
-- ===========================================================================

--v function(context: CA_UIContext)
function M.click(context) 
    -- temp
    PanelManager.close("RegionTrading");
end

function M.open()
    M.init();
    M.createFrame();

    M.offersPanel:SetVisible(false);

    return true;
end

function M.close()
    M.deleteFrame();
    M.offersPanel:SetVisible(true);

    return true;
end


PanelManager.register(
    "RegionTrading",
    M.open,
    M.close,
    M.click
)

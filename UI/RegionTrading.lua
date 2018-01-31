-- ===========================================================================
-- file: UI/RegionTrading
-- author: Hardballer
--
-- Region trading panel
-- ===========================================================================

local Logger = require("Core/Logger").new("UI", "RegionTrading");
local PanelManager = require("UI/PanelManager");


local M = {};


M.diploPanel = nil --: CA_UIC
M.offersPanel = nil --: CA_UIC




function M.init() 
    local root = core:get_ui_root();

    M.diploPanel = UIComponent( root:Find("diplomacy_dropdown") );    
    M.offersPanel = UIComponent( M.diploPanel:Find("offers_panel") );
end


-- ===========================================================================
-- Panel functions
-- ===========================================================================

--v function(context: CA_UIContext)
function M.click(context) 

end

function M.open()
    M.init();

    M.offersPanel:SetVisible(false);

    return true;
end

function M.close()
    M.offersPanel:SetVisible(true);

    return true;
end


PanelManager.register(
    "RegionTrading",
    M.open,
    M.close,
    M.click
)

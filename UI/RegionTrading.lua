-- ===========================================================================
-- file: UI/RegionTrading
-- author: Hardballer
--
-- Region trading panel
-- ===========================================================================

local Logger = require("Core/Logger").new("UI", "RegionTrading");
local PanelManager = require("UI/PanelManager");


local M = {};


-- ===========================================================================
-- Panel functions
-- ===========================================================================

--v function(context: CA_UIContext)
function M.click(context) 

end

function M.open() 
    return true;
end

function M.close() 
    return true;
end


PanelManager.register(
    "RegionTrading",
    M.open,
    M.close,
    M.click
)

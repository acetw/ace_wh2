-- ===========================================================================
-- file: Init
-- author: Hardballer
--
-- First file called by the game in campaign mode
-- ===========================================================================

local Logger = require("Core/Logger").new("Main", "Init");

-- UI
require("UI/DiplomacyDropdown");
require("UI/RegionTrading");


Logger:Log("init done");

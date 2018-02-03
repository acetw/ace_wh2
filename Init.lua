-- ===========================================================================
-- file: Init
-- author: Hardballer
--
-- First file called by the game in campaign mode
-- ===========================================================================

local Logger = require("Core/Logger").new("Main", "Init");


-- Model
require("Model");
require("Model/Faction");


-- UI
require("UI/DiplomacyDropdown");
require("UI/RegionTrading");


Logger:Log("init done");

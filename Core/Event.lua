-- ===========================================================================
-- file: Core/Event
-- author: Hardballer
--
-- Campaign events wrapper
-- ===========================================================================

local Logger = require("Core/Logger").new("Core", "Event");
local Event = {};
local M = {};


M.id = 1;
M.prefix = "ACE_EH";


--v function(e: CA_EventName, cb: function(context: WHATEVER?)) --> string
function Event.addListener(e, cb)
    local handlerID = e..tostring(M.id);
    M.id = M.id + 1;    

    core:add_listener(M.prefix..handlerID, e, true, cb, true);
    Logger:Log("add listener "..handlerID);

    return handlerID;
end

--v function(handlerID: string)
function Event.removeListener(handlerID)
    core:remove_listener(M.prefix..handlerID);
    Logger:Log("remove listener "..handlerID);
end


return Event

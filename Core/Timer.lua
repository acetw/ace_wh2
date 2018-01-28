-- ===========================================================================
-- file: Core/Timer
-- author: Hardballer
--
-- Timer utility functions
-- ===========================================================================

local Timer = {};
local M = {};


M.id = 0;
M.callbackID = "HCE_Callback";


function M.getCallbackId()
    if(M.id > 1000) then
        M.id = 1;
    else
        M.id = M.id + 1;
    end
    
    return M.callbackID..tostring(M.id);
end

--v function(cb: function())
function Timer.nextTick(cb)
    cm:callback(cb, 0, M.getCallbackId());
end


return Timer

-- ===========================================================================
-- file: Core/Test
-- author: Hardballer
--
-- Test utility functions
-- ===========================================================================

local Event = require("Core/Event");
local Test = {};


--v function(cb: function(context: CA_UIContext?))
function Test.onClick(cb)
    Event.addListener("ComponentLClickUp", cb);
end


return Test

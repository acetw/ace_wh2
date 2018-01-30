-- ===========================================================================
-- file: UIC/Util
-- author: Hardballer
--
-- UIC utility functions
-- ===========================================================================

--# type UIC_EventName = "click" | "over" | "exit"

local Logger = require("Core/Logger").new("UIC", "Util");
local Event = require("Core/Event");

local Util = {};
local M = {};

M.callback = {
    click = {},
    over = {},
    exit = {}
} --: map<UIC_EventName, map<string, function()>>

M.lastOverID = nil  --: string  -- keep track of the last hovered uic id
M.garbage = nil     --: CA_UIC  -- dummy uic used to delete




function M.init() 
    local root = core:get_ui_root();
    
    root:CreateComponent("ACEGarbage", "UI/Campaign UI/script_dummy");
    M.garbage = UIComponent( root:Find("ACEGarbage") );

    Logger:Log("init done");
end

Event.addListener("UICreated", M.init);


-- ===========================================================================
-- UIC Listener
-- ===========================================================================

--v function(uic: CA_UIC, e: UIC_EventName, cb: function())
function Util.addListener(uic, e, cb) 
    -- use the component address as unique id
    local id = tostring(uic:Address());    
    M.callback[e][id] = cb;
end

--# assume Util.removeListener: function(uic: CA_UIC, recursive: boolean?)
--v function(uic: CA_UIC, recursive: boolean?)
function Util.removeListener(uic, recursive)
    local id = tostring(uic:Address());

    for event, val in pairs(M.callback) do
        M.callback[event][id] = nil;
    end

    if not recursive then return end
    if uic:ChildCount() == 0 then return end

    for i = 0, uic:ChildCount() - 1 do
        local child = UIComponent(uic:Find(i));        
        Util.removeListener(child, true);
    end
end

--v function(context: CA_UIContext)
function M.click(context)    
    local id = tostring(context.component);

    if M.callback.click[id] then
        M.callback.click[id]();
        Logger:Log("trigger click event for " .. id);
    end
end

--v function(context: CA_UIContext)
function M.mouseOver(context) 
    local id = tostring(context.component);
    
    -- trigger the exit callback
    local lastID = M.lastOverID;
    if lastID and M.callback.exit[lastID] then
        M.callback.exit[lastID]();
        Logger:Log("trigger exit event for " .. id);
    end

    if M.callback.over[id] then
        M.callback.over[id]();
        Logger:Log("trigger mouse over event for " .. id);
    end

    M.lastOverID = id;
end

Event.addListener("ComponentLClickUp", M.click);
Event.addListener("ComponentMouseOn", M.mouseOver);


-- ===========================================================================
-- UIC creation / suppression
-- ===========================================================================

--v function(path: string, name: string?) --> CA_UIC
function Util.createTempUIC(path, name)
    local id = name or "ACETemp";
    local root = core:get_ui_root();
    local temp = nil --: CA_UIC

    root:CreateComponent(id, path);
    temp = UIComponent(root:Find(id));

    if not temp then
        Logger:Error("failed to create temp uic " .. path);
    else
        Logger:Log("create temp " .. id);
    end    

    return temp;
end

--v function(parent: CA_UIC, name: string?) --> CA_UIC
function Util.createDummyUIC(parent, name)
    local id = name or "ACE_Dummy";
    local root = core:get_ui_root();
    root:CreateComponent(id, "UI/templates/panel_frame");

    local dummy = UIComponent(root:Find(id));
    parent:Adopt(dummy:Address());

    dummy:SetInteractive(false);
    dummy:SetOpacity(0);
    dummy:Resize(10, 10);

    Logger:Log("create dummy " .. id);

    return dummy;
end


--v function(uic: CA_UIC, removeCB: boolean?)
function Util.delete(uic, removeCB) 
    local id = uic:Id();
    
    if removeCB then
        Util.removeListener(uic, true);
    end

    M.garbage:Adopt(uic:Address());
    M.garbage:DestroyChildren();

    Logger:Log("delete uic " .. id);
end


return Util

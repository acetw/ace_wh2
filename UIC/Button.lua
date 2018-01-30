-- ===========================================================================
-- file: UIC/Button
-- author: Hardballer
--
-- Button UIC Class
-- ===========================================================================

--# assume global class ACE_Button
--# type local ButtonTypes = "button_ok" | "button_cancel"

local Logger = require("Core/Logger").new("UIC", "Button");
local Util = require("UIC/Util");

local Button = {} --# assume Button: ACE_Button
local M = {};


-- Possible states of the button uic
M.States = {
    "active", "down", "drop_down",
    "hover", "inactive", "selected"
} --: const vector<string>

-- Available button types, they look the same
-- but sound different when clicked
Button.VALID = "button_ok" --: const ButtonTypes
Button.CANCEL = "button_cancel" --: const ButtonTypes




--v function(name: string, parent: CA_UIC, btnType: ButtonTypes) --> ACE_Button
function Button.new(name, parent, btnType) 
    local temp = Util.createTempUIC("ui/bin/button/" .. name);    
    local button = find_uicomponent_from_table(temp, {
        "hud_center_docker", "ok_cancel_buttongroup", btnType
    })

    parent:Adopt(button:Address());
    Util.delete(temp);


    local self = {};
    setmetatable(self, {
        __index = Button,
        __tostring = function() return "ACE BUTTON: "..name end
    }) --# assume self: ACE_Button

    self.uic = button --: const CA_UIC


    Logger:Log("create " .. tostring(self));
    return self;
end


--v function(self: ACE_Button)
function Button.Delete(self) 
    Util.delete(self.uic, true);
end

--v function(self: ACE_Button, x: number, y :number)
function Button.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--v function(self: ACE_Button, e: UIC_EventName, cb: function())
function Button.On(self, e, cb)
    Util.addListener(self.uic, e, cb);
end

--v function(self: ACE_Button, state: string)
function Button.SetState(self, state) 
    self.uic:SetState(state);
end

--v function(self: ACE_Button, text: string) 
function Button.SetTooltipText(self, text) 
    local saved = self.uic:CurrentState();

    -- Make sure the default tooltip will be replace
    -- by the custom one for each possible state
    for index, state in ipairs(M.States) do
        self:SetState(state);
        self.uic:SetTooltipText(text);
    end

    -- Restore button state
    self:SetState(saved);
end

--v function(self: ACE_Button, visible: boolean)
function Button.SetVisible(self, visible) 
    self.uic:SetVisible(visible);
end


return Button

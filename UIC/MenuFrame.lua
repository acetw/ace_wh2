-- ===========================================================================
-- file: UIC/MenuFrame
-- author: Hardballer
--
-- Menu Frame UIC Class
-- ===========================================================================

--# assume global class ACE_MenuFrame

local Logger = require("Core/Logger").new("UIC", "MenuFrame");
local Util = require("UIC/Util");

local MenuFrame = {} --# assume MenuFrame: ACE_MenuFrame


--v function(parent: CA_UIC, name: string) --> ACE_MenuFrame
function MenuFrame.new(parent, name)
    -- UIC
    local frame = Util.createTempUIC("UI/Campaign UI/finance_screen", name);

    Util.delete( UIComponent(frame:Find("button_holder")) );
    Util.delete( UIComponent(frame:Find("TabGroup")) );

    local parchment = UIComponent(frame:Find("parchment"));
    local title = UIComponent(frame:Find("tx_finance"));

    -- Bottom bar
    local temp = Util.createTempUIC("UI/Campaign UI/unit_exchange");
    local bar = find_uicomponent_from_table(temp, {
        "hud_center_docker", "small_bar"
    })

    bar:DestroyChildren();
    frame:Adopt(bar:Address());
    Util.delete(temp);


    -- Class
    local self = {};
    setmetatable(self, {
        __index = MenuFrame,
        __tostring = function() return "ACE MenuFrame: "..name end
    }) --# assume self: ACE_MenuFrame


    self.uic = frame --: const CA_UIC
    self.title = title --: const CA_UIC
    self.parchment = parchment --: const CA_UIC
    self.bar = bar --: const CA_UIC

    self.uic:SetCanResizeWidth(true);
    self.uic:SetCanResizeHeight(true);
    self.parchment:SetCanResizeWidth(true);
    self.parchment:SetCanResizeHeight(true);
    self.bar:SetCanResizeWidth(true);

    Logger:Log("create " .. tostring(self));
    return self;
end


--v function(self: ACE_MenuFrame)
function MenuFrame.Delete(self)
    Util.delete(self.uic, true);
end

--v function(self: ACE_MenuFrame, priority: number)
function MenuFrame.PropagatePriority(self, priority)
    self.uic:PropagatePriority(priority);
end

--v function(self: ACE_MenuFrame, w: number, h: number)
function MenuFrame.Resize(self, w, h)
    self.uic:Resize(w, h);
    self.parchment:Resize(w - 25, h + 25);
    self.bar:Resize(w + 85, h);
end

--v function(self: ACE_MenuFrame, text: string)
function MenuFrame.SetTitle(self, text)
    self.title:SetStateText(text);
end


return MenuFrame

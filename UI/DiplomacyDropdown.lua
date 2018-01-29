-- ===========================================================================
-- file: UI/DiplomacyDropdown
-- author: Hardballer
--
-- Handles the diplomacy panel
-- ===========================================================================

local Logger = require("Core/Logger").new("UI", "DiplomacyDropdown");
local Timer = require("Core/Timer");
local PanelManager = require("UI/PanelManager");

local DiplomacyDropdown = {};
local M = {};


M.selectedFaction = nil --: string   -- Key of the selected faction
M.offersOpened = false --: boolean   -- Track if the offers panel is opened
M.stopLoop = false --: boolean       -- Used to stop the module loop

-- Various uic
M.diploPanel = nil --: CA_UIC
M.offersPanel = nil --: CA_UIC
M.subPanel = nil --: CA_UIC
M.factionLBox = nil --: CA_UIC




function M.init() 
    -- Reset module vars
    M.offersOpened = false;
    M.stopLoop = false;
    M.selectedFaction = nil;

    -- Set uic var
    local root = core:get_ui_root();
    
    M.diploPanel = UIComponent(root:Find("diplomacy_dropdown"));
    M.offersPanel = UIComponent(M.diploPanel:Find("offers_panel"));    
    M.subPanel = UIComponent(M.diploPanel:Find("subpanel_group"));

    M.factionLBox = find_uicomponent_from_table(M.diploPanel, {
        "faction_panel", "sortable_list_factions", "list_clip", "list_box"
    })
end


-- ===========================================================================
-- Selected faction
-- ===========================================================================

--v function(item: CA_UIC) --> string
function M.getFactionFromItem(item)
    return string.gsub(item:Id(), "faction_row_entry_", "");
end

function M.initSelectedFaction() 
    -- If the player open the offers panel wihtout selected a faction
    -- the game select the first faction of the lbox by default
    --
    -- This need to be checked on the panel opening since 
    -- the list can be sorted differently withtout selected a faction
    -- making any list check on offers panel opening useless
    
    Timer.nextTick(function()
        -- selectedFaction may already be define if the player open the offers
        -- panel by double clicking on a faction in the campaign map
        if M.selectedFaction ~= nil then return end

        -- Check the first two items in case the list is sorted by races
        local item1 = UIComponent(M.factionLBox:Find(0));
        local item2 = UIComponent(M.factionLBox:Find(1));

        if UIComponent(item1:Find(0)):Id() == "name" then
            M.selectedFaction = M.getFactionFromItem(item1);
        else
            M.selectedFaction = M.getFactionFromItem(item2);
        end

        Logger:Log("selected faction set to " .. M.selectedFaction);
    end)
end

function M.updateSelectedFaction() 
    -- Cycle through the faction lbox to find the selected faction 
    for i = 0, M.factionLBox:ChildCount() - 1 do
        local item = UIComponent(M.factionLBox:Find(i));
        local child = UIComponent(item:Find(0));

        -- When the list is sorted by races, a race item is created
        -- This item doesn't point to any faction and should be ignore
        -- Actual faction item have a child with an ID of "name"
        if child:Id() == "name" then
            local state = item:CurrentState();
            if state == "selected" or state == "selected_hover" then
                M.selectedFaction = M.getFactionFromItem(item);
                Logger:Log("selected faction updated to " .. M.selectedFaction);
                break;
            end
        end
    end    
end


-- ===========================================================================
-- Offers panel
-- ===========================================================================

function M.openOffersPanel()
    M.updateSelectedFaction();
    
    M.offersOpened = true;
    Logger:Log("open offers panel");
end

function M.closeOffersPanel()
    M.offersOpened = false;
    Logger:Log("close offers panel");
end


function M.watchOffersPanel()
    -- When making an offer, a subpanel will pop up hiding the panel
    -- This need to be ignore since the panel is still opened
    
    local open = M.offersOpened;
    local visible = M.offersPanel:Visible();
    local subPanel = M.subPanel:Visible();

    if not open and visible then
        M.openOffersPanel();
    elseif open and not visible and not subPanel then
        M.closeOffersPanel();
    end
end


-- ===========================================================================
-- Panel functions
-- ===========================================================================

function M.loop()
    if M.stopLoop then return end

    -- Catch the opening/closing of the offers panel
    M.watchOffersPanel();
    
    Timer.nextTick(M.loop);
end

--v function(context: CA_UIContext)
function M.click(context)

end

function M.open()
    M.init();
    M.initSelectedFaction();    
    M.loop();

    return true;
end

function M.close()
    M.stopLoop = true;

    return true;
end


PanelManager.register(
    "DiplomacyDropdown",
    M.open,
    M.close,
    M.click
)


return DiplomacyDropdown

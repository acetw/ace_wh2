-- ===========================================================================
-- file: .vscode/typing
-- author: Hardballer
--
-- Creative Assembly type declaration
-- ===========================================================================


-- CLASS DECLARATION
--# assume global class CA_UIC
--# assume global class CORE


-- TYPES
--# type global CA_EventName = 
--# "PanelOpenedCampaign"   |   "PanelClosedCampaign"   |
--# "ComponentLClickUp"     |   "ComponentMouseOn"      |
--# "UICreated"


-- CORE
--# assume CORE.add_listener: method(
--#     handler: string,
--#     event: CA_EventName,
--#     condition: boolean,
--#     callback: function(context: WHATEVER?),
--#     shouldRepeat: boolean
--# )
--# assume CORE.remove_listener: method(handler: string)


-- GLOBAL FUNCTIONS
--# assume global is_uicomponent: function(arg: any) --> boolean
--# assume global uicomponent_to_str: function(uic: CA_UIC) --> string

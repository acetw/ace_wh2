-- ===========================================================================
-- file: .vscode/typing
-- author: Hardballer
--
-- Creative Assembly type declaration
-- ===========================================================================


-- CLASS DECLARATION
--# assume global class CA_Component
--# assume global class CA_UIC
--# assume global class CORE
--# assume global class CM
--# assume global class CA_UIContext


-- TYPES
--# type global CA_EventName = 
--# "PanelOpenedCampaign"   |   "PanelClosedCampaign"   |
--# "ComponentLClickUp"     |   "ComponentMouseOn"      |
--# "UICreated"


-- CONTEXT
--# assume CA_UIContext.component: CA_Component
--# assume CA_UIContext.string: string


-- CA_UIC
--# assume CA_UIC.Address: method() --> CA_Component
--# assume CA_UIC.Adopt: method(component: CA_Component)
--# assume CA_UIC.ChildCount: method() --> number
--# assume CA_UIC.CreateComponent: method(name: string, path: string)
--# assume CA_UIC.CurrentState: method() --> string
--# assume CA_UIC.DestroyChildren: method()
--# assume CA_UIC.Find: method(arg: number | string) --> CA_Component
--# assume CA_UIC.Id: method() --> string
--# assume CA_UIC.MoveTo: method(x: number, y: number)
--# assume CA_UIC.Position: method() --> (number, number)
--# assume CA_UIC.PropagatePriority: method(priority: number)
--# assume CA_UIC.Resize: method(w: number, h: number)
--# assume CA_UIC.SetCanResizeHeight: method(canResize: boolean)
--# assume CA_UIC.SetCanResizeWidth: method(canResize: boolean)
--# assume CA_UIC.SetInteractive: method(interactive: boolean)
--# assume CA_UIC.SetOpacity: method(opacity: number)
--# assume CA_UIC.SetState: method(state: string)
--# assume CA_UIC.SetStateText: method(text: string)
--# assume CA_UIC.SetTooltipText: method(text: string)
--# assume CA_UIC.SetVisible: method(visible: boolean)
--# assume CA_UIC.Visible: method() --> boolean


-- CAMPAIGN MANAGER
--# assume CM.callback: method(cb: function(), time: number, id: string)


-- CORE
--# assume CORE.add_listener: method(
--#     handler: string,
--#     event: CA_EventName,
--#     condition: boolean,
--#     callback: function(context: WHATEVER?),
--#     shouldRepeat: boolean
--# )
--# assume CORE.get_ui_root: method() --> CA_UIC
--# assume CORE.remove_listener: method(handler: string)


-- GLOBAL FUNCTIONS
--# assume global is_uicomponent: function(arg: any) --> boolean
--# assume global find_uicomponent_from_table: function(uic: CA_UIC, path: vector<string>) --> CA_UIC
--# assume global UIComponent: function(pointer: CA_Component) --> CA_UIC
--# assume global uicomponent_to_str: function(uic: CA_UIC) --> string

 
-- GLOBAL VARIABLES
--# assume global cm: CM
--# assume global core: CORE

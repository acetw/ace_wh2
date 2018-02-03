-- ===========================================================================
-- file: Model
-- author: Hardballer
--
-- Declare the Model namespace and class type
-- The Model table is used as a mediator between all the model classes
-- ===========================================================================

--# assume global class ACE_Model
--# assume global class ACE_Faction


-- Model/Faction
--# assume ACE_Faction.getFaction: function(name: string) --> ACE_Faction
--# assume ACE_Faction.getPlayer: function() --> ACE_Faction


local Model = {} --# assume Model: ACE_Model


return Model

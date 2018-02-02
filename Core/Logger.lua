-- ===========================================================================
-- file: Core/Logger
-- author: Hardballer
--
-- Logger Class
-- ===========================================================================

--# assume global class ACE_Logger

local Logger = {} --# assume Logger: ACE_Logger
local M = {};


M.enableLog = true --: boolean
M.consoleMode = true --: boolean
M.maxLines = 100 --: number
M.lines = {} --: vector<string>
M.filePath = "data/ace_log.txt" --: string


--v function(str: string)
function M.write(str)
    if M.consoleMode then
        if #M.lines > M.maxLines then
            table.remove(M.lines, 1);
        end

        table.insert(M.lines, str);

        local file = io.open(M.filePath,"w+");
        local c = #M.lines;
        for i = 0, c - 1 do
            file:write(M.lines[c - i].."\n");
        end

        file:close();
    else
        local file = io.open(M.filePath,"a+");
        file:write(str.."\n");
        file:close();
    end
end


--v function(package: string, file: string) --> ACE_Logger
function Logger.new(package, file)
    local self = {};

    setmetatable(self, {
        __index = Logger,
        __tostring = function() return "Logger: "..package.."/"..file end
    }) --# assume self: ACE_Logger

    self.package = package --: const
    self.id = package.."/"..file.." => " --: const

    return self;
end


--v function(arg: any)
function Logger.print(arg)
    local str --: string

    if is_uicomponent(arg) then
        --# assume arg: CA_UIC
        str = uicomponent_to_str(arg);
    else
        str = tostring(arg);
    end

    M.write(str);
end

--v function(t: any)
function Logger.printTable(t)
    if type(t) ~= "table" then return Logger.print(t) end
    --# assume t: map<number | string, any>

    M.write("\n###### "..tostring(t).." ######");

    for k, v in pairs(t) do
        M.write("\t"..k.." => "..tostring(v));
    end

    M.write("###### "..tostring(t).." ######\n");
end


--v function(self: ACE_Logger, arg: any)
function Logger.Log(self, arg)
    if not M.enableLog then return end

    local time = os.date("%H:%M.%S");
    --# assume time: string

    local str = "["..time.."] "..self.id..tostring(arg);

    M.write(str);
end

--v function(self: ACE_Logger, arg: any)
function Logger.Error(self, arg)
    local str = "##### ERROR ##### "..self.id..tostring(arg);
    M.write(str);
end


return Logger

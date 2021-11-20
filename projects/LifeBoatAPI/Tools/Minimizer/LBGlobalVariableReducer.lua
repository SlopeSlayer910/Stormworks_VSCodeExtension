-- developed by nameouschangey (Gordon Mckendrick) for use with LifeBoat Modding framework
-- please see: https://github.com/nameouschangey/STORMWORKS for updates

require("LifeBoatAPI.Missions.Utils.LBBase")
require("LifeBoatAPI.Missions.Utils.LBTable")
require("LifeBoatAPI.Missions.Utils.LBString")
require("LifeBoatAPI.Missions.Utils.LBStringBuilder")
require("LifeBoatAPI.Tools.Minimizer.LBVariableRenamer")
require("LifeBoatAPI.Tools.Minimizer.LBParsingConstantsLoader")

--------------------------------------------------------------------------------------------------------------------
-- NB: 
-- the issue is a lot of people will do something like S=screen
-- but not SD=screen.draw
-- meaning we'll then have a ton of S.drawRect that could still be reduced down
--  to something like SD=S.drawRect
-- but tbh that's maybe not my problem
-- if you write code that's designed to be read - these aren't really problems, and
--  if you've already shortened things, maybe we just assume you knew what you were doing entirely

-- so we only shorten things like table.remove, table.insert etc.
-- and then we pass over that table, to reduce table. to things like t. to save even more space
---------------------------------------------------------------------------------------

---@class LBGlobalVariableReducer : LBBaseClass
---@field constants LBParsingConstantsLoader
---@field renamer LBVariableRenamer shared instance of the renamer, to ensure variables are renamed safely
LBGlobalVariableReducer = {

    ---@param renamer LBVariableRenamer must be the same one as used before
    ---@param constants LBParsingConstantsLoader
    ---@return LBGlobalVariableReducer
    new = function(cls, renamer, constants)
        local this = LBBaseClass.new(cls)
        this.renamer = renamer
        this.constants = constants
        return this
    end;

    ---@param this LBGlobalVariableReducer
    shortenGlobals = function(this, text)
        text = this:_shorten(text, "[^%w_]([%a_][%w_%.]-)[^%w_%.]", this.constants.fullNames)
        text = "\n" .. text -- ensure newly added variables work
        text = this:_shorten(text, "[^%w_]([%a_][%w_]-)[^%w_]", this.constants.baseNames)
        return text
    end;

    ---@param this LBGlobalVariableReducer
    _shorten = function(this, text, pattern, acceptableList)
        -- variables shortened are not keywords, and not global names (because those are a pita)
        local variables = LBString_find(text, pattern)

        -- filter down to ONLY the externalGlobals list
        variables = LBTable_iwhere(variables, function(v) return v.captures[1]
                                                                and not v.captures[1]:find("STRING%d%d%d%d%d%d%dREPLACEMENT")
                                                                and acceptableList[v.captures[1]]
                                                                and not this.constants.restrictedKeywords[v.captures[1]] end)  -- only change globals where they're used at least twice, or it's a cost

        -- count times we've go this same variable in the list
        local count = {}
        for k,v in ipairs(variables) do
            if(not count[v.captures[1]]) then
                count[v.captures[1]] = 1
            else
                count[v.captures[1]] = count[v.captures[1]] + 1
            end
        end
        
        -- filter out variables not seen enough times
        variables = LBTable_iwhere(variables, function(v) return count[v.captures[1]] >= 2 end)
        
        -- due to the pattern, we need to alter each variable, so it's start and end position exclude the non-variable character
        variables = LBTable_iselect(variables, function(v) v.startIndex = v.startIndex + 1; v.endIndex = v.endIndex - 1; return v end)
        return this:_replaceVariables(text, variables)
    end;

    ---@param this LBGlobalVariableReducer
    ---@param variables LBStringMatch[]
    ---@param text string file data to parse
    ---@return string text with variables replaced with shorter versions
    _replaceVariables = function(this, text, variables)
        local variablesSeenBefore = {}
        local output = LBStringBuilder:new()

        local lastEnd = 1

        -- sub each variable with the shortened name
        for i,variable in ipairs(variables) do
           
            local name = variablesSeenBefore[variable.captures[1]] or this.renamer:getShortName()

            -- if this is the first instance, we also add the conversion to the top of the file
            if(not variablesSeenBefore[variable.captures[1]]) then
                output:addFront(name .. "=" .. variable.captures[1] .. "\n")
                variablesSeenBefore[variable.captures[1]] = name
            end

            output:add(text:sub(lastEnd, variable.startIndex-1), name)
            lastEnd = variable.endIndex + 1
        end
        
        -- add the final file chunk on
        output:add(text:sub(lastEnd, #text))

        -- add output after global definitions
        return output:getString()
    end;

    
};
LBClass(LBGlobalVariableReducer);

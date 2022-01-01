-- developed by nameouschangey (Gordon Mckendrick) for use with LifeBoat Modding framework
-- please see: https://github.com/nameouschangey/STORMWORKS for updates

require("LifeBoatAPI.Utils.LBCopy")

---@class LBTableUtils
---@section LBTableUtils 1 LBTABLECLASS
LifeBoatAPI.LBTableUtils = {

    --- Returns whether this collection contains the given value or not
    ---@param tbl table
    ---@param value any value to check for
    ---@return boolean exists whether this value exists in the collection or not
    ---@section lbtable_containsValue
    lbtable_containsValue = function(tbl, value)
        for _,v in pairs(tbl) do
            if(v == value) then return true end
        end
        return false
    end;
    ---@endsection

    --- Counts the number of elements in the table
    --- Differs from length, which counts numberical keys; ending at first nil
    ---@param tbl table table to act on
    ---@return number
    ---@section lbtable_countKeys
    lbtable_countKeys = function(tbl)
        local i = 0
        for _, v in pairs(tbl) do
            i = i + 1
        end
        return i
    end;
    ---@endsection

    --- safely removes the specified index from the table, ensuring that if it's a numerical key - we keep the values contiguous
    --- just using this.lb_data[key] = nil, for all keys, would mean we end up with arrays like {a,b,c,nil,nil,f,g,h} which ipairs and #length will only read up to c
    ---@param tbl table table to act on
    ---@param key any index to remove, or key to delete
    ---@section lbtable_remove
    lbtable_remove = function(tbl, key)
        if(type(key) == "number") then
            table.remove(tbl, key)
        else
            tbl[key] = nil
        end
    end;
    ---@endsection

    --- simple addRange, used far too commonly not to include
    --- @param tbl table table to act on
    --- @param from table list of values to append to lhs table
    ---@section lbtable_addRange
    lbtable_addRange = function(tbl, from)
        LifeBoatAPI.lb_copy(from, tbl)
    end;
    ---@endsection


    --- simple addRange, used far too commonly not to include
    --- @param tbl table table to act on
    --- @param from table list of values to append to lhs table
    ---@section lbtable_iaddRange
    lbtable_iaddRange = function(tbl, from)
        for i,v in ipairs(from) do
            table.insert(tbl, v)
        end
    end;
    ---@endsection

    --- Flattens a key:value pair table into a list of values
    --- @generic K,V
    --- @param tbl table<K,V> table to act on
    --- @return K[],V[] transformed keys table, values table
    ---@section lbtable_keys_and_values
    lbtable_keys_and_values = function(tbl, _keys, _values)
        _keys, _values = {}, {}
        for k,v in pairs(tbl) do
            table.insert(_keys, k)
            table.insert(_values, v)
        end
        return _keys, _values
    end;
    ---@endsection

    --- Fills a holey array into an array starting at 1, contiguous upto #length
    --- Preserves non-numerical keys
    --- @generic T
    --- @param tbl T table to act on
    --- @return T transformed table
    ---@section lbtable_ifillHoles
    lbtable_ifillHoles = function(tbl)
        local result = {}
        for k,v in pairs(tbl) do
            if(type(k) == "number") then
                table.insert(result, v)
            else
                result[k] = v
            end
        end
        return result
    end;
    ---@endsection

    --- Slices the given list, returning the sub-list tbl[startIndex ... endIndex]
    --- Indices can be negative to count from the end of the table, e.g. -1 is the last element, and -2 is the second last element
    --- @generic T
    --- @param tbl T table to act on
    --- @param startIndex number
    --- @param endIndex number
    --- @return T slice
    ---@section lbtable_islice
    lbtable_islice = function(tbl, startIndex, endIndex)
        local result  = {}
        for i=(startIndex and startIndex < 0 and #tbl-startIndex+1) or startIndex or 1,
            (endIndex and endIndex < 0 and #tbl-endIndex+1) or endIndex or #tbl,
            1 do
            table.insert(result, tbl[i])
        end
        return result
    end;
    ---@endsection

    --- Filters out values by the callable function
    --- @generic T
    --- @param tbl T table to act on
    --- @param callable fun(value:any, key:any):boolean
    --- @return T filtered table
    ---@section lbtable_where
    lbtable_where = function(tbl, callable)
        local result = {}
        for k,v in pairs(tbl) do
            result[k] = callable(v,k) and v or nil
        end
        return result
    end;
    ---@endsection

    --- Filters out values by the callable function
    --- @generic T
    --- @param tbl T table to act on
    --- @param callable fun(value:any, key:number):boolean
    --- @return T filtered table
    ---@section lbtable_iwhere
    lbtable_iwhere = function(tbl, callable)
        local result = {}
        for k,v in ipairs(tbl) do
            table.insert(result, callable(v,k) and v or nil)
        end
        return result
    end;
    ---@endsection

    --- Transforms values from one format to another
    --- Note, returned value from callable is VALUE, KEY
    ---    This allows for shorter functions where the key is unchanged; and re-use with lb_iselect
    --- Select and Where functionality can be combined by returning nil as the value
    --- If the key is returned as nil, the original key is used
    --- @generic T
    --- @param tbl T table to act on
    --- @param callable fun(value:any, key:any):any,any func(value, key) => value',key' - an altered key and value to go into the result
    --- @return T transformed table
    ---@section lbtable_select
    lbtable_select = function(tbl, callable)
        local result = {}
        for k,v in pairs(tbl) do
            local dv, dk = callable(v,k)
            result[dk or k] = dv
        end
        return result
    end;
    ---@endsection

    --- Transforms values from one format to another
    --- Note, returned value from callable is VALUE
    --- Select and Where functionality can be combined by returning nil as the value
    --- @generic T
    --- @param tbl T table to act on
    --- @param callable fun(value:any, i:number):any func(value,index) => v' - an altered value to go into the result
    --- @return T transformed table
    ---@section lbtable_iselect
    lbtable_iselect = function(tbl, callable)
        local result = {}
        for k,v in ipairs(tbl) do
            table.insert(result, callable(v,k))
        end
        return result
    end;
    ---@endsection

    --- Groups values by a common key, selected by the callable, into a dictionary of lists
    --- @generic T,G
    --- @param tbl T table to act on
    --- @param callable fun(value:any, key:any):G func(k,v) => groupingValue - a value on which to group the results
    --- @return table<G,T> groups with lists of values, grouped by a commmon key
    ---@section lbtable_groupBy
    lbtable_groupBy = function(tbl, callable)
        local result = {}
        for k,v in pairs(tbl) do
            local groupableValue = callable(v,k)
            result[groupableValue] = result[groupableValue] or {}
            result[groupableValue][k] = v
        end
        return result
    end;
    ---@endsection

    --- Groups values by a common function, into a list of lists
    --- @generic T,G
    --- @param tbl T table to act on
    --- @param callable fun(v:any, k:number):any func(k,v) => groupingValue - a value on which to group the results
    --- @return table<G,T> table with lists of values, grouped by a commmon key
    ---@section lbtable_igroupBy
    lbtable_igroupBy = function(tbl, callable)
        local result = {}
        for k,v in ipairs(tbl) do
            local groupableValue = callable(v, k)
            result[groupableValue] = result[groupableValue] or {}
            table.insert(result[groupableValue], v)
        end
        return result
    end;
    ---@endsection

    --- Orders the table using the given comparison into a new table
    --- Assumes numerical keys, otherwise it does nothing useful
    --- Does not change existing table, returns a new table that is ordered
    --- @generic T
    --- @param tbl T table to act on
    --- @param comparison fun(a:any,b:any):boolean function returning strictly true, if a is before b
    --- @return T ordered table
    ---@section lbtable_iorderBy
    lbtable_iorderBy = function(tbl, comparison)
        local result = LifeBoatAPI.lb_copy(tbl, {}, true)
        table.sort(result, comparison)
        return result
    end;
    ---@endsection

    ---Recursively runs through every value in a table
    ---Defends against circular references; so safe to use even with self-linking tables
    --- @overload fun(callable:function)
    --- @overload fun(callable:function, maxDepth:number)
    --- @param tbl table self instance
    --- @param callable fun(k:any,v:any,tbl:table,path:string[]) function to call per value found, callable(key, value, parentTable, pathToThisElement)
    --- @param maxDepth number max depth to recurse into, 0 or 1 are equal; neither go into any tables. -1 infinite recurse
    --- @param depth number
    --- @param path string[]
    --- @param seen table<any,boolean>
    ---@section lbtable_recurse
    lbtable_recurse = function(tbl, callable, maxDepth, depth, path, seen)
        path = path or {}
        depth = depth or 1
        seen = seen or {[tbl] = 1} -- track tables we've seen, avoid recursing into them
        for k,v in pairs(tbl) do
            -- track the current path
            local newPath = LifeBoatAPI.lb_copy(path)
            table.insert(newPath, k)

            -- function to be called on every value
            callable(k, v, tbl, newPath)

            -- recurse into any other tables
            if(type(v) == "table" and not seen[v]) then
                seen[v] = 1
                if(not maxDepth or depth < maxDepth) then
                    LifeBoatAPI.LBTable.lbtable_recurse(v, callable, maxDepth, depth+1, newPath, seen)
                end
            end
        end
    end;
    ---@endsection
}
---@endsection LBTABLECLASS
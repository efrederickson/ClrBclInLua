System.StringHelper = {
    ClassName = "StringHelper",
    Namespace = "System",
    
    new = function(...)
        System.ThrowHelper.Throw(System.Exception:new"Cannot create an instance of StringHelper")
    end,
    
    Trim = function(s)
        return System.StringHelper.TrimStart(System.StringHelper.TrimEnd(s))
    end,
    
    TrimEnd = function(s)
        local s2 = s -- don't modify original
        while s2:sub(-1, -1) == " " or s2:sub(-1, -1) == "\t" or s2:sub(-1, -1) == "\r" or s2:sub(-1, -1) == "\n" do
            s2 = s2:sub(1, -2)
        end
        return s2
    end,
    
    TrimStart = function(s)
        local s2 = s -- don't modify original
        while s2:sub(1, 1) == " " or s2:sub(1, 1) == "\t" or s2:sub(1, 1) == "\r" or s2:sub(1, 1) == "\n" do
            s2 = s2:sub(2)
        end
        return s2
    end,
    
    TrimChars = function(s, ...)
        local s2 = s
        local chars = { ... }
        if #chars > 0 and type(chars[1]) == "table" then
            chars = chars[1]
        end
        while true do
            local has = false
            for k, char in pairs(chars) do
                if s2:sub(1, 1) == char then
                    has = true
                    break
                end
            end
            if has then
                s2 = s2:sub(2)
            else
                break
            end
        end
    end,
    
    Capitalize = function(s)
        return s:sub(1, 1):upper() .. s:sub(2)
    end,
    
    IndexOf = function(s, find, pos)
        pos = pos or 1
        for i = pos, s:len() do
            if s:sub(i, i + find:len() - 1) == find then
                return i
            end
        end
        return -1
    end,
    
    CountOf = function(str, find)
        if not str or not find then
            return 0
        end
        local count, pos, length = 0, 1, find:len()
        while true do
            local p2 = _.string.indexOf(str, find, pos)
            if p2 == -1 then
                break
            end
            count = count + 1
            pos = pos + length
        end
    
        return count
    end,
    
    ToCharArray = function(s)
        local t = { }
        for i = 1, s:len() do
            table.insert(t, s:sub(i, i))
        end
        return t
    end,
    
    SwapCase = function(s)
        local s2 = ""
        for i = 1, s:len() do
            local char = s:sub(i, i)
            s2 = s2 .. (char:upper() == char and char:lower() or char:upper())
        end
        return s2
    end,
    
    Join = function(...)
        return table.concat({ ... }, "")
    end,
    
    SplitLines = function(s)
        local t = System.StringHelper.Split(s, System.Environment.NewLine)
        for i = 1, #t do
            t[i] = System.StringHelper.TrimChars(t[i], "\r")
        end
        return t
    end,
    
    Split = function(s, ...)
        --local splitters = { ... }
        local _tmp = ...
        local splitters = { _tmp }
        if #splitters > 0 and type(splitters[1]) == "table" then
            splitters = splitters[1]
        end
        local t = { }
        local pos = 1
        local leading = ""
        local first = true
        while pos <= s:len() do
            local flag = false
            for k, splitter in pairs(splitters) do
                --if s:sub(pos, pos + splitter:len() - 1) == splitter then
                local found = System.StringHelper.IndexOf(s, splitter, pos)
                if found ~= -1 and found == pos then
                    local nextIndex = System.StringHelper.IndexOf(s, splitter, pos + splitter:len())
                    if nextIndex == -1 then nextIndex = s:len() + 1 end
                    --if nextIndex == 1 then nextIndex = 2 end
                    table.insert(t, s:sub(pos, nextIndex - 1))
                    if first then
                        t[#t] = leading .. t[#t]
                        first = false
                    end
                    pos = pos + splitter:len()
                    flag = true
                    break
                end
            end
            if not flag then
                if first then
                    leading = leading .. s:sub(pos, pos)
                end
                pos = pos + 1
            end
        end
        return t
    end,
    
    StartsWith = function(s, sw)
        return System.StringHelper.IndexOf(s, sw) == 1
    end,
    
    EndsWith = function(s, ew)
        --print(System.StringHelper.IndexOf(s, ew), s:len(), ew:len(), s:len() - ew:len() + 1)
        -- Adding one because 4 - 2 == 2, but IndexOf('asdf', 'df') == 3
        return System.StringHelper.IndexOf(s, ew) == s:len() - ew:len() + 1
    end,
    
    Substring = function(s, start, len)
        return s:sub(start, start + len - 1)
    end,
    
    IndexOfAny = function(str, chars)
        local index = -1
        for k, v in pairs(chars) do
            local i = System.String.IndexOf(str, v)
            if i < index or index == -1 then
                index = i
            end
        end
        return index
    end,
    
    LastIndexOf = function(s, find, pos)
        pos = pos or 1
        for i = s:len(), pos, -1 do
            if s:sub(i, i + find:len() - 1) == find then
                return i
            end
        end
        return -1
    end,
    
    LastIndexOfAny = function(str, chars)
        local index = -1
        for k, v in pairs(chars) do
            local i = System.String.LastIndexOf(str, v)
            if i > index or index == -1 then
                index = i
            end
        end
        return index
    end,
    
    Replace = function(s, old, new)
        local s2 = s
        while System.StringHelper.IndexOf(s2, old) ~= -1 do
            s2 = s2:sub(1, System.StringHelper.IndexOf(s2, old) - 1) .. new .. s2:sub(System.StringHelper.IndexOf(s2, old) + old:len())
        end
        return s2
    end,
}

setmetatable(System.StringHelper, { __index = System.Object })

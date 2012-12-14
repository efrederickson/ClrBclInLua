System.String = {
    ClassName = "String",
    Namespace = "System",
    Empty = "",
    Implements = { System.IComparable, System.ICloneable, System.IConvertible,
        System.IEnumerable, System.IEquatable },

    new = function(self, ...)
        local arg = { ... }
        local mt = System.GetStandardMetatable()
        mt.__index = function(t, k)
            if k == "Length" then
                return t.string:len()
            end
            if type(k) == "number" then
                return t:Substring(k, 1)
            end
			local r = self[k]
            if r then return r end
            if not r and rawget(System.StringHelper, k) then
                return function(str, ...)
                    local args = { ... }
                    for k, v in pairs(args) do if System.String.IsString(v) then args[k] = v:ToString() end end
                    
                    local ret = { System.StringHelper[k](str.string, unpack(args)) }
                    local patched = { }
                    for k, v in pairs(ret) do
                        if type(v) == "string" then
                            patched[k] = System.String:new(v)
                        else
                            patched[k] = v
                        end
                    end
                    return unpack(patched)
                end
            end
            if not r and rawget(string, k) then
                return function(str, ...)
                    local args = { ... }
                    for k, v in pairs(args) do if System.String.IsString(v) then args[k] = v:ToString() end end
                    
                    local ret = { string[k](str.string, unpack(args)) }
                    local patched = { }
                    for k, v in pairs(ret) do
                        if type(v) == "string" then
                            patched[k] = System.String:new(v)
                        else
                            patched[k] = v
                        end
                    end
                    return unpack(patched)
                end
            end
            --return r or System.__index(self, k)
			return r
        end
        local ret = setmetatable({
            --Length = 0,
            string = "",
        }, mt)
        if arg[1] and System.String.IsString(arg[1]) then
            return System.String:new(arg[1].string)
        elseif arg[1] and type(arg[1]) == "string" then
            ret.string = arg[1]
        elseif arg[1] and type(arg[1]) == "table" then
            ret.string = table.concat(arg[1], "")
        elseif arg[1] then
            ret.string = tostring(arg[1])
            --System.ThrowHelper.Throw(System.ArgumentException:new"Unable to process argument 1")
        end
        --ret.Length = ret.string:len()
        return ret
    end,

    Join = function(sep, ...)
        return System.String:new(table.concat({ ... }, sep))
    end,

    Concat = function(...)
        return System.String.Join("", ...)
    end,

    IsString = function(a)
        return type(a) == "table" and a.GetType and a:GetType().FullName == "System.String"
    end,

    Equals = function(a, b)
        return
            (System.String.IsString(a) and System.String.IsString(b) and a.string == b.string) or
            (System.String.IsString(a) and type(b) == "string" and a.string == b) or
            (System.String.IsString(b) and type(a) == "string" and b.string == a)
    end,

    ToCharArray = function(self)
        return System.StringHelper.ToCharArray(self.string)
    end,

    Substring = function(self, start, len)
        return System.String:new(System.StringHelper.Substring(self.string, start, len or self.string:len()))
    end,

    ToString = function(self)
        return self.string
    end,

    Compare = function(a, b)
        local a = System.String.IsString(a) and a.string or a
        local b = System.String.IsString(b) and b.string or b
        return System.Globalization.CultureInfo.CurrentCulture.CompareInfo.Compare(a, b, System.Globalization.CompareInfo.None)
    end,

    CompareTo = function(a, b)
        return a:Compare(b)
    end,

    IndexOf = function(self, str, pos)
        return System.StringHelper.IndexOf(self, str, pos)
    end,

    Trim = function(self)
        return System.String:new(System.StringHelper.Trim(self.string))
    end,

    Clone = function(self)
        return System.String:new(self.string)
    end,

    Copy = function(self)
        return self:Clone()
    end,

    EndsWith = function(self, ends)
        return System.StringHelper.EndsWith(self.string, tostring(ends))
    end,

    StartsWith = function(self, starts)
        return System.StringHelper.StartsWith(self.string, tostring(starts))
    end,

    Format = function(str, ...)
        -- Note: Not .NET style format - C/printf style
        return System.String:new(string.format(str, ...))
    end,

    GetEnumerator = function(self)
        local function iterator(t, i)
            i = i + 1
            local c = t.string:sub(i, i)
            if not c or c == "" then
                return nil
            else
                return i, c
            end
        end

        return iterator, self, 0
    end,

    GetTypeCode = function(self)
        return System.TypeCode.String
    end,

    Insert = function(self, index, str)
        if index < 0 then
            index = self.string:len() - index
        end
        return System.String:new(self.string:sub(1, index) .. str .. self.string:sub(index + 1))
    end,

    IsNullOrEmpty = function(str)
        return str == nil or str.string == nil or str.string == ""
    end,

    IsNullOrWhitespace = function(str)
        local function isWs(s)
            local flag = s:len() > 0 and true or false
            for i = 1, s:len() do
                if System.Char.IsWhitespace(s:sub(i, i)) == false then
                    flag = false
                end
            end
            return flag
        end

        return str == nil or str.string == nil or isWs(str.string)
    end,

    LastIndexOf = function(self, str, pos)
        return System.StringHelper.LastIndexOf(self.string, str, pos)
    end,

    LastIndexOfAny = function(self, ...)
        local chars = { ... }
        if chars[1] and type(chars[1]) == "table" then
            chars = chars[1]
        end
        return System.StringHelper.LastIndexOfAny(self.string, chars)
    end,

    PadLeft = function(self, num, char)
        char = char or ' '
        local new = self.string
        while new:len() < num do
            new = char .. new
        end
        return System.String:new(new)
    end,

    PadRight = function(self, num, char)
        char = char or ' '
        local new = self.string
        while new:len() < num do
            new = new .. char
        end
        return System.String:new(new)
    end,

    Remove = function(self, start, count)
        if start - 1 < 0 then
            System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString("String_Remove_StartIsInvalid")))
        end
        if not count then
            return System.String:new(self.string:sub(1, start - 1))
        end
        return System.String:new(self.string:sub(1, start - 1) .. self.string:sub(count + 1))
    end,

    Replace = function(self, old, new)
        return System.String:new(System.StringHelper.Replace(self.string, old, new))
    end,

    Split = function(self, ...)
        return System.String:new(System.StringHelper.Split(self.string, ...))
    end,

    -- IConvertible section
    --ToBoolean = function(self)
    --    return System.Convert.ToBoolean(self.string)
    --end,

    ToByte = function(self)
        return System.Convert.ToByte(self.string)
    end,

    ToChar = function(self)
        return System.Convert.ToChar(self.string)
    end,

    ToDateTime = function(self)
        return System.Convert.ToDateTime(self.string)
    end,

    ToDecimal = function(self)
        return System.Convert.ToDecimal(self.string)
    end,

    ToDouble = function(self)
        return System.Convert.ToDouble(self.string)
    end,

    ToInt16 = function(self)
        return System.Convert.ToInt16(self.string)
    end,

    ToInt32 = function(self)
        return System.Convert.ToInt32(self.string)
    end,

    ToInt64 = function(self)
        return System.Convert.ToInt64(self.string)
    end,

    ToSByte = function(self)
        return System.Convert.ToSByte(self.string)
    end,

    ToSingle = function(self)
        return System.Convert.ToSingle(self.string)
    end,

    ToType = function(self, type)
        return System.Convert.DefaultToType(self.string, type)
    end,

    ToUInt16 = function(self)
        return System.Convert.ToUInt16(self.string)
    end,

    ToUInt32 = function(self)
        return System.Convert.ToUInt32(self.string)
    end,

    ToUInt64 = function(self)
        return System.Convert.ToUInt64(self.string)
    end,
    -- End IConvertible section

    ToLower = function(self)
        return System.String:new(self.string:lower())
    end,

    ToUpper = function(self)
        return System.String:new(self.string:upper())
    end,

    Trim = function(self, ...)
        local t = { ... }
        if #t > 1 then
            return System.String:new(System.StringHelper.TrimChars(self.string, ...))
        else
            return System.String:new(System.StringHelper.Trim(self.string))
        end
    end,

    TrimStart = function(self)
        return System.String:new(System.StringHelper.TrimStart(self.string))
    end,

    TrimEnd = function(self)
        return System.String:new(System.StringHelper.TrimEnd(self.string))
    end,

    TrimChars = function(self, ...)
        return System.String:new(System.StringHelper.TrimChars(self.string, ...))
    end,
    
    ToNativeString = function(obj)
        if System.String.IsString(obj) then return obj.string end
        if type(obj) == "string" then return obj end
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString("Argument_NotString2")))
    end,
    
    GetHashCode = function(self)
        local ret = 0
        for k, v in self:GetEnumerator() do
            ret = System.Bit.Xor(ret, string.byte(v))
        end
        return ret
    end,
    
    Repeat = function(s, n)
        local sb = System.Text.StringBuilder:new()
        for i = 1, n do
            sb:Append(s)
        end
        return System.String:new(sb:ToString())
    end,
}
System.String.Empty = System.String:new("")

setmetatable(System.String, {
	--__obj=System.Object,
    --__index = function(...) print(...) return System.__index(...) end,
	--__index = System.Object,
	__index = System.__index,
})

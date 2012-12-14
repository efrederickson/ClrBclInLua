System.Object = {
    ClassName = "Object",
    Namespace = "System",
    Inherits = System.Object,
    Implements = { },
    IsInterface = false,
    IsClass = true,

    new = function(self, ...)
        local x = System.GetStandardMetatable(self)
        x.__obj = nil
        return setmetatable({ }, x)
    end,

    Dispose = function(self)
        for k, v in pairs(self) do
            self[k] = nil
            if Object.IsObject(v) then
                v:Dispose()
            end
        end
        setmetatable(self, { })
    end,

    ToString = function(self, ...)
        return self:GetType():ToString()
    end,

    GetHashCode = function(self)
        -- This is... horrible. To say the least.
        local ret = 0
        for k, v in pairs(self) do
            if System.Object.IsObject(v) then
                ret = System.Bit.Xor(ret, v:GetHashCode())
            else
                local x = tonumber(v) or (type(v) == "number" and v)
                if x then
                    ret = System.Bit.Xor((ret == 0 and 1 or ret), x)
                else
                    ret = ret + 1
                end
            end
        end
        return ret
    end,

    GetType = function(self)
        return System.Type:new(self)
    end,

    Equals = function(a, b)
        return a == b or (a ~= nil and b ~= nil and false)
    end,

    ReferenceEquals = function(a, b)
        return a == b
    end,

    IsObject = function(o)
        return o and type(o) == "table" and o.ToString and o.GetType and o.GetType():InheritsClass(System.Object)
    end,

    IsA = function(self, name)
        local type = self:GetType()
        return type.FullName == name or type:InheritsClass(name)
    end,

    Is = function(self, name)
        return self:IsA(name)
    end,

    IndexOfAny = function(self, ...)
        local chars = { ... }
        if chars[1] and type(chars[1]) == "table" then
            chars = chars[1]
        end
        return System.StringHelper.IndexOfAny(self.string, chars)
    end
}

setmetatable(System.Object, {
    __tostring = function(o) return o:ToString() end,
    __eq = function(a, b) return (System.Object.IsObject(a) and a:Equals(b)) or (System.Object.IsObject(b) and b:Equals(a)) end,
    --__index = function(t, k) print(t, k) return nil end,
	__index = nil, --System.__index,
    __obj = nil,
})

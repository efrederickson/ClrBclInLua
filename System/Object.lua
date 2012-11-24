System.Object = { 
    ClassName = "Object",
    Namespace = "System",
    Inherits = nil,
    Implements = { },
    IsInterface = false,
    IsClass = true,
    
    new = function(self, ...)
        return setmetatable({ }, System.GetStandardMetatable(self))
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
        return 0
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
        return o and type(o) == "table" and o.ToString and o.GetType
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
    __eq = function(a, b) return (System.Object.IsObject(a) and a:Equals(b)) or (System.Object.IsObject(b) and b:Equals(a)) or Object.Equals(a, b) end
})

System.Object = { 
    ClassName = "Object",
    Namespace = "System",
    Inherits = nil,
    Implements = { },
    IsInterface = false,
    IsClass = true,
    
    new = function(self, ...)
        return setmetatable({ }, { __index = self })
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
    
    end,
    
    GetType = function(self)
        return System.Type:new(self)
    end,
    
    Equals = function(self, other)
        if self.ClassName ~= other.ClassName then return false end
    end,
    
    Equals = function(a, b)
        return a == b or (a ~= nil and b ~= nil and a:Equals(b))
    end,
    
    ReferenceEquals = function(a, b)
        return a == b
    end,
    
    IsObject = function(o)
        return o and type(o) == "table" and o.ToString and o.GetType
    end,
    
    IsA = function(self, name)
        local type = self:GetType()
        --System.ThrowHelper.Throw(Exception:new("Not implemented"))
        return type.FullName == name or type:InheritsClass(name)
    end,
    
    Is = function(self, name)
        return self:IsA(name)
    end,
}

setmetatable(System.Object, { __tostring = function(o) return o:ToString() end })

System.Interface = {
    ClassName = "Interface",
    Namespace = "System",
    Inherits = nil,
    Implements = nil,
    IsInterface = true,
    IsClass = false,
    
    new = function(self, ...)
        throw(Exception:new("Cannot create an instance of an Interface"))
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
    
    GetType = function(self)
        throw(Exception:new("Not implemented"))
    end,
    
    Equals = function(self, other)
        
    end,
    
    Equals = function(a, b)
        return a == b or (a ~= nil and b ~= nil and a:Equals(b))
    end,
    
    ReferenceEquals = function(a, b)
        return a == b
    end,
    
    IsA = function(self, name)
        local type = o:GetType()
        throw(Exception:new("Not implemented"))
        --return type.FullName == name or type:Inher
    end,
    
    Is = function(self, name)
        return self:IsA(name)
    end,
}

setmetatable(System.Interface, { __tostring = function(o) return o:Tostring() end })

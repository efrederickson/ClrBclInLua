require"System.Reflection"
System.Type = {
    ClassName = "Type",
    Namespace = "System",
    --Inherits = System.Reflection.MemberInfo,
    --Implements = { System.Runtime.InteropServices._Type, System.Reflection.IReflect },
    
    new = function(self, object)
        local mt = System.GetStandardMetatable()
        mt.__index = self
        return setmetatable({ 
            object = object,
            FullName = object.Namespace .. "." .. object.ClassName,
            Name = object.ClassName,
        }, mt)
    end,
    
    ToString = function(self)
        return self.FullName
    end,
    
    InheritsClass = function(self, name, scanned)
        scanned = scanned or { }
        local o = self.object
        if self.FullName == name then
            return true
        end
        scanned[#scanned + 1] = o
        if o.Inherits and scanned[o.Inherits] == false then
            return o.Inherits:GetType().FullName == name or Type.InheritsClass(o.Inherits:GetType(), name, scanned)
        end
        return false
    end,
    
    ImplementsClass = function(self, name)
        local o = self.object
        local flag = false
        if o.Implements then
            for k, v in pairs(o.Implements) do
                if v:GetType().FullName == name then
                    flag = true
                else
                    flag = Type.ImplementsClass(v:GetType(), name)
                end
            end
        end
        return flag
    end,
}

setmetatable(System.Type, { __index = System.Object })

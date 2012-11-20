require"System.Reflection"
System.Type = {
    ClassName = "Type",
    Namespace = "System",
    --Inherits = System.Reflection.MemberInfo,
    --Implements = { System.Runtime.InteropServices._Type, System.Reflection.IReflect },
    
    new = function(self, object)
        return setmetatable({ 
            object = object,
            FullName = object.Namespace .. "." .. object.ClassName,
            Name = object.ClassName,
        }, { 
            __index = self 
        })
    end,
    
    ToString = function(self)
        return self.FullName
    end,
    
    InheritsClass = function(self, name)
        local o = self.object
        if o.Inherits then
            return o.Inherits.ClassName == name or Type.InheritsClass(o.Inherits, name)
        end
        return false
    end,
}

setmetatable(System.Type, { __index = System.Object })

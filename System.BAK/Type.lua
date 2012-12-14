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
        name = type(name) == "string" and name or name:GetType().FullName
        scanned = scanned or { }
        local o = self.object
        if self.FullName == name then
            return true
        end
        scanned[o] = true
        if o.Inherits and scanned[o.Inherits] == false then
            return o.Inherits:GetType().FullName == name or Type.InheritsClass(o.Inherits:GetType(), name, scanned)
        end
        return false
    end,

    ImplementsInterface = function(self, name)
        name = type(name) == "string" and name or name:GetType().FullName
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

    IsType = function(o)
        return o and type(o) == "table" and o.ImplementsClass and o.GetType and o:GetType().FullName == "System.Type"
    end,
}

setmetatable(System.Type, { __index = System.__index })

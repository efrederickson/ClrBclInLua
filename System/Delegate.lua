System.Delegate = {
    ClassName = "Delegate",
    Namespace = "System",
    
    new = function(self, func, ...)
        local mt = { }
        mt.__eq = function(a, b) return a and b and System.IsDelegate(a) and System.IsDelegate(b) and a.func == b.func end
        mt.__index = self
        mt.__call = function(self, ...)
            return self.func(...)
        end

        return setmetatable({
            func = func,
            argTypes = { ... },
        }, mt)
    end,
    
    IsDelegate = function(obj)
        return obj and type(obj) == "table" and obj.func and obj.IsDelegate
    end,
    
    GetType = function(self)
        return System.Type:new(self)
    end,
}

setmetatable(System.Delegate, {
    __call = function(t, ...)
        return t:new(...)
    end,
})

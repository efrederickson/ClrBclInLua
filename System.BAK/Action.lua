System.Action = {
    new = function(self, func, ...)
        local mt = { }
        mt.__eq = function(a, b) return a and b and System.IsDelegate(a) and System.IsDelegate(b) and a.func == b.func end
        mt.__index = self
        mt.__call = function(self, ...)
            self.func(...)
        end

        return setmetatable({
            func = func,
            argTypes = { ... },
        }, mt)
    end,
}

local mt = System.GetStandardMetatable(System.Delegate)
setmetatable(System.Action, mt)

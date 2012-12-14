System.Globalization.CultureNotFoundException = {
    ClassName = "CultureNotFoundException",
    Namespace = "System.Globalization",
    Inherits = System.ArgumentException,
    
    new = function(self, ...)
        local arg = { ... }
        local mt = System.GetStandardMetatable()
        mt.__index = self
        local msg = (arg[2] or "") .. (arg[1] or "")
        if msg:len() > 0 then
            msg = (arg[2] or "") .. ". Culture Name: " .. (arg[1] or "")
        end
        return setmetatable({ 
            Message = msg,
            InnerException = arg[3] or nil,
            StackTrace = debug and System.FixTraceback(debug.traceback()) or ""
        }, mt)
    end,
}

setmetatable(System.Globalization.CultureNotFoundException, { __index = System.ArgumentException })

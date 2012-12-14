System.ArgumentException = {
    ClassName = "ArgumentException",
    Inherits = System.Exception,
    
    new = function(self, msg)
        msg = msg or ""
        local mt = System.GetStandardMetatable()
        mt.__index = self
        return setmetatable({ 
            Message = msg,
            StackTrace = debug and System.FixTraceback(debug.traceback()) or ""
        }, mt)
    end,
}

setmetatable(System.ArgumentException, { __index = System.Exception })

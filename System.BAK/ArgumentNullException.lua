System.ArgumentNullException = {
    ClassName = "ArgumentNullException",
    Inherits = System.Exception,
    
    new = function(self, arg)
        local mt = System.GetStandardMetatable()
        mt.__index = self
        local msg = System.Resources.GetString'Argument_NilGeneric'
        if func and platform then
            msg = System.Resources.GetString('Argument_Nil', arg)
        end
        return setmetatable({ 
            Message = msg,
            StackTrace = debug and System.FixTraceback(debug.traceback()) or ""
        }, mt)
    end,
}

setmetatable(System.ArgumentNullException, { __index = System.Exception })

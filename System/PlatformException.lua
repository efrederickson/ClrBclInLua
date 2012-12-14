System.PlatformException = {
    ClassName = "PlatformException",
    Inherits = System.Exception,
    
    new = function(self, func, platform)
        local mt = System.GetStandardMetatable()
        mt.__index = self
        local msg = System.Resources.GetString'PlatformNotSupported'
        if func and platform then
            msg = System.Resources.GetString('PlatformNotSupported3', func, platform)
        elseif func and not platform then
            msg = System.Resources.GetString('PlatformNotSupported4', func)
        end
        return setmetatable({ 
            Message = msg,
            StackTrace = debug and System.FixTraceback(debug.traceback()) or ""
        }, mt)
    end,
}

setmetatable(System.PlatformException, { __index = System.Exception })

require"System.Runtime.InteropServices"

System.Exception = {
    ClassName = "Exception",
    Namespace = "System",
    Implements = { System.Runtime.InteropServices._Exception },
    
    new = function(self, ...)
        local arg = { ... }
        return setmetatable({
            Message = arg[1] or "",
            InnerException = arg[2] or nil,
            StackTrace = debug and debug.traceback() or "" -- TODO: remove the first line (with the Exception:new call)
        }, { __index = self })
    end,
    
    GetBaseException = function(self)
        local ex = self
        while ex.InnerException and ex:IsA"System.Exception" do
            ex = ex.InnerException
        end
        return ex
    end,
    
    ToString = function(self, full)
        full = full or true
        if full then
            local text = self:GetType():ToString()
            if self.Message:len() > 1 then
                text = text .. ": " .. self.Message
            end
            if self.InnerException then
                text = text .. 
                        System.Environment.NewLine .. 
                        System.Environment.NewLine ..
                        self.InnerException:ToString(full) .. 
                        System.Environment.NewLine ..
                        System.Resources:GetString("Exception_EndOfInnerExceptionStack") ..
                        System.Environment.NewLine
            end
            if self.StackTrace then
                text = text .. System.Environment.NewLine .. self.StackTrace
            end
            return text
        else
            return self.Message
        end
    end,
}

setmetatable(System.Exception, { __index = System.Object })

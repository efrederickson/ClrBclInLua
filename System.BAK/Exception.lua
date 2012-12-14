require"System.Runtime.InteropServices"

function System.FixTraceback(s)
    -- Removes the \System\Exception.lua:XXX: in function 'new'

    -- Should use System.Environment.NewLine instead, but debug.traceback
    -- returns \n's
    local line1 = s:sub(1, System.StringHelper.IndexOf(s, "\n"))
    local line2index = line1:len() + 1
    local line2 = s:sub(line2index, System.StringHelper.IndexOf(s, "\n", line2index))
    --print(line1, line2)
    local line3index = line2index + line2:len() + 1
    local patched = line1 .. s:sub(line3index - 1)
    --print(patched)
    --return s
    return patched
end

System.Exception = {
    ClassName = "Exception",
    Namespace = "System",
    Implements = { System.Runtime.InteropServices._Exception },

    new = function(self, ...)
        local arg = { ... }
        local mt = System.GetStandardMetatable()
        mt.__index = self
        return setmetatable({
            Message = arg[1] or "",
            InnerException = arg[2] or nil,
            StackTrace = debug and System.FixTraceback(debug.traceback()) or ""
        }, mt)
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
            if self.Message and self.Message:len() > 1 then
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

setmetatable(System.Exception, { __index = System.__index })

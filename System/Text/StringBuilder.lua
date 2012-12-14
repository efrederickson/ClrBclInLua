System.Text.StringBuilder = {
    ClassName = "StringBuilder",
    Namespace = "System.Text",
    
    new = function(self, length)
        length = length or -1
        local mt = System.GetStandardMetatable()
        mt.__index = self
        mt.__tostring = function(s) return s:ToString() end 
        return setmetatable({ 
            MaxLength = length,
            Length = 0,
            parts = { },
            }, mt)
    end,
    
    Append = function(self, obj)
        local s = System.Object.IsObject(obj) and obj:ToString() or tostring(obj)
        if self.Length + s:len() > self.MaxLength and self.MaxLength >= 0 then
            System.ThrowHelper.Throw(System.Exception:new"Maximum length reached")
        else
            table.insert(self.parts, s)
            self.Length = self.Length + s:len()
        end
    end,
    
    AppendLine = function(self, obj)
        local s = System.Object.IsObject(obj) and obj:ToString() or tostring(obj)
        s = s .. System.Environment.NewLine
        if self.Length + s:len() > self.MaxLength and self.MaxLength >= 0 then
            System.ThrowHelper.Throw(System.Exception:new"Maximum length reached")
        else
            table.insert(self.parts, s)
            self.Length = self.Length + s:len()
        end
    end,
    
    ToString = function(self)
        return table.concat(self.parts)
    end,
}

setmetatable(System.Text.StringBuilder, { __index = System.Object })

--[[
local sb = StringBuilder:new()
sb:AppendLine("hi")
sb:Append"hello world"
print(sb.Length)
print("Length matches ToString length: ", assert(sb.Length == sb:ToString():len()))
print(sb)
print(sb:ToString())

sb:Dispose()
print(sb.Append)
]]

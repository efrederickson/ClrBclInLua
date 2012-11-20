StringBuilder = {
    new = function(self, length)
        length = length or -1
        return setmetatable({ 
            MaxLength = length,
            Length = 0,
            parts = { },
            EndOfLineChar = "\n",
            }, { 
                __index = self, 
                __tostring = function(s) return s:ToString() end 
            })
    end,
    
    Append = function(self, obj)
        local s = tostring(obj)
        if self.Length + s:len() > self.MaxLength and self.MaxLength >= 0 then
            error("Maximum length reached")
        else
            table.insert(self.parts, s)
            self.Length = self.Length + s:len()
        end
    end,
    
    AppendLine = function(self, obj)
        local s = tostring(obj)
        s = s .. self.EndOfLineChar
        if self.Length + s:len() > self.MaxLength and self.MaxLength >= 0 then
            error("Maximum length reached")
        else
            table.insert(self.parts, s)
            self.Length = self.Length + s:len()
        end
    end,
    
    ToString = function(self)
        return table.concat(self.parts)
    end,
    
    Dispose = function(self)
        -- remove all aspects of the StringBuilder
        for k, _ in pairs(self) do
            self[k] = nil
        end
        setmetatable(self, { })
    end,
}


local sb = StringBuilder:new()
sb:AppendLine("hi")
sb:Append"hello world"
print(sb.Length)
print("Length matches ToString length: ", assert(sb.Length == sb:ToString():len()))
print(sb)
print(sb:ToString())

sb:Dispose()
print(sb.Append)

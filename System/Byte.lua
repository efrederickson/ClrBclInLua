System.Byte = {
    ClassName = "Byte",
    Namespace = "System",
    Implements = { System.IComparable, System.IFormattable, System.IConvertible },
    MaxValue = 255,
    MinValue = 0,
    
    new = function(self, obj)
        obj = obj or '0'
        if System.String.IsString(obj) then
            obj = System.String.ToNativeString(obj)
        elseif System.Char.IsChar(obj) then
            obj = System.Char.ToNativeChar(obj)
        end
        if tonumber(obj) and tonumber(obj) <= 255 and tonumber(obj) >= 0 then
            obj = string.char(obj)
        elseif tonumber(obj) then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString'Argument_ByteOverflow'))
        end
        if obj:len() ~= 1 then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString'Argument_StringLengthNotOne'))
        end
        local x = string.byte(obj)
        if x < 0 or x > 255 then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString'Argument_ByteOverflow'))
        end
        local mt = System.GetStandardMetatable()
        mt.__index = self
        return setmetatable({
            num = string.byte(obj)
        }, mt)
    end,
    
    ToString = function(self)
        return self.num
    end,
    
    CompareTo = function(a, b)
        if System.Byte.IsByte(a) == false or System.Byte.IsByte(b) == false then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString'Argument_MustBeByte'))
        end
        return a.num - b.num
    end,
    
    Equals = function(a, b)
        return a and b and System.Byte.IsByte(a) and System.Byte.IsByte(b) and a.num == b.num
    end,
    
    IsByte = function(obj)
        return obj and type(obj) == "table" and obj.num and obj.GetType and obj:GetType().FullName == "System.Byte"
    end,
    
    GetTypeCode = function()
        return System.TypeCode.Byte
    end,
    
    Parse = function(str)
        return System.Byte:new(str)
    end,
    
    -- TODO: IConvertible, TryParse
}

setmetatable(System.Byte, { __index = System.Object })

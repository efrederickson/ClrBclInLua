System.Double = {
    ClassName = "Double",
    MinValue = -1.7976931348623157E+308,
    MaxValue = 1.7976931348623157E+308,
    Epsilon = 4.94065645841247E-324,
    NaN = 0 / 0,
    NegativeInfinity = -1 / 0,
    PositiveInfinity = 1 / 0,
    --NegativeZero = BitConverter.Int64BitsToDouble(-9223372036854775808),
    NegativeZero = -9223372036854775808,

    new = function(self, num)
        local mt = System.GetStandardMetatable()
        mt.__index = self
        return setmetatable({
            num or 0
        }, mt)
    end,

    IsDouble = function(obj)
        if obj == nil then return false end
        if type(obj) == "table" then
            if obj.num then
                if obj.GetType then
                    if obj:GetType().FullName == "System.Double" then
                        return true
                    end
                end
            end
        end
        return false
    end,

    ToNativeDouble = function(obj)
        if System.Double.IsDouble(obj) then
            return obj.num
        elseif type(obj) == "number" then
            return obj
        else
error'Not a number'
            return nil
        end
    end,

    IsInfinity = function(num)
        num = System.Double.ToNativeDouble(num)
        return num == System.Double.NegativeInfinity or num == System.Double.PositiveInfinity
    end,

    IsPositiveInfinity = function(n)
        n = System.Double.ToNativeDouble(n)
        return n == System.Double.PositiveInfinity
    end,

    IsNegativeInfinity = function(n)
        n = System.Double.ToNativeDouble(n)
        return n == System.Double.NegativeInfinity
    end,

    IsNaN = function(n)
        n = System.Double.ToNativeDouble(n)
        return n == System.Double.NaN
    end,

    -- TODO: The rest of double
}

setmetatable(System.Double, { __index = System.__index })

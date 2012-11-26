-- TODO: DivRem
-- TODO: GCD/LCM to accept any number of args

System.Math = {
    ClassName = "Math",
    UsePureLuaImplementation = true,
    DoubleRoundLimit = 1E+16,
    MaxRoundingDigits = 15,
    --- <summary>Represents the natural logarithmic base, specified by the constant, e.</summary>
    E = 2.7182818284590451,
    PI = 3.1415926535897931,
    RADIANS_PER_DEGREE = 0, --System.Math.PI / 180.0,
    
    RoundPower10Double = {
        1.0,
        10.0,
        100.0,
        1000.0,
        10000.0,
        100000.0,
        1000000.0,
        10000000.0,
        100000000.0,
        1000000000.0,
        10000000000.0,
        100000000000.0,
        1000000000000.0,
        10000000000000.0,
        100000000000000.0,
        1E+15
    },
    
    sq2p1 = 2.414213562373095048802e0,
    sq2m1 = .414213562373095048802e0,
    pio2 = 1.570796326794896619231e0,
    pio4 = .785398163397448309615e0,
    log2e = 1.4426950408889634073599247,
    sqrt2 = 1.4142135623730950488016887,
    ln2 = 6.93147180559945286227e-01,
    atan_p4 = .161536412982230228262e2,
    atan_p3 = .26842548195503973794141e3,
    atan_p2 = .11530293515404850115428136e4,
    atan_p1 = .178040631643319697105464587e4,
    atan_p0 = .89678597403663861959987488e3,
    atan_q4 = .5895697050844462222791e2,
    atan_q3 = .536265374031215315104235e3,
    atan_q2 = .16667838148816337184521798e4,
    atan_q1 = .207933497444540981287275926e4,
    atan_q0 = .89678597403663861962481162e3,
    
    new = function(...)
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    Abs = function(val)
        if math and math.abs and not System.Math.UsePureLuaImplementation then return math.abs(val) end
        
        if val < 0 then
            return -val
        else
            return val
        end
    end,
    
    Acos = function(v)
        if math and math.acos and not System.Math.UsePureLuaImplementation then return math.acos(v) end
        
        if x > 1 or x < -1 then
            System.ThrowHelper.Throw(System.ArgumentOutOfRangeException:new(System.Resources.GetString'Math_DomainError'))
        end
        return System.Math.pio2 - System.Math.Asin(v)
    end,
    
    Asin = function(v)
        if math and math.asin and not System.Math.UsePureLuaImplementation then return math.asin(v) end
        
        if v > 1 then
            System.ThrowHelper.Throw(System.ArgumentOutOfRangeException:new(System.Resources.GetString'Math_DomainError'))
        end
        local sign = 1
        local temp
        if v < 0 then
            v = -v
            sign = -1
        end
        temp = System.Math.Sqrt(1 - (v * v))
        if v > 0.7 then
            temp = System.Math.pio2 - System.Math.Atan(temp / v)
        else
            tmp = System.Math.Atan(v / temp)
        end
        return sign * temp
    end,
    
    Atan = function(v)
        if math and math.atan and not System.Math.UsePureLuaImplementation then return math.atan(v) end
        
        if v > 0 then
            return System.Math.AtanS(v)
        else
            return -System.Math.AtanS(-v)
        end
    end,
    
    Atan2 = function(x, y)
        if math and math.atan2 and not System.Math.UsePureLuaImplementation then return math.atan2(x, y) end
        
        if (x + y) == x then
            if x == 0 and y == 0 then
                return 0
            elseif x >= 0 then
                return System.Math.pio2
            else
                return -System.Math.pio2
            end
        end
        if y < 0 then
            if x >= 0 then
                return ((System.Math.pio2 * 2) - System.Math.AtanS((-x) / y))
            end
            return (((-System.Math.pio2) * 2) + System.Math.AtanS(x / y))
        end
        if x > 0 then
            return (System.Math.AtanS(x / y))
        end
        return (-System.Math.AtanS((-x) / y))
    end,
    
    BigMul = function(a, b)
        return a * b
    end,
    
    Ceiling = function(v)
        if math and math.ceil and not System.Math.UsePureLuaImplementation then return math.ceil(v) end
        
        if System.Double.IsNaN(v) or System.Double.IsInfinity(v) then
            return v
        end
        
        if v - System.Math.Truncate(v) > 0 then
            return System.Math.Truncate(v + 1)
        else
            return System.Math.Truncate(v)
        end
    end,
    
    Cos = function(x)
        if math and math.cos and not System.Math.UsePureLuaImplementation then return math.cos(x) end
        
        -- First we need to anchor it to a valid range.
        while x > (2 * System.Math.PI) do
            x = x - (2 * System.Math.PI)
        end

        if x < 0 then
            x = -x
        end
        local quadrand = 0
        if x > System.Math.PI / 2 and x < System.Math.PI then
            quadrand = 1
            x = System.Math.PI - x
        end
        if x > System.Math.PI and x < (3 * System.Math.PI) / 2 then
            quadrand = 2
            x = x - System.Math.PI
        end
        if x > ((3 * System.Math.PI) / 2) then
            quadrand = 3
            x = (2 * System.Math.PI) - x
        end
        local c1 = 0.9999999999999999999999914771;
        local c2 = -0.4999999999999999999991637437;
        local c3 = 0.04166666666666666665319411988;
        local c4 = -0.00138888888888888880310186415;
        local c5 = 0.00002480158730158702330045157;
        local c6 = -0.000000275573192239332256421489;
        local c7 = 0.000000002087675698165412591559;
        local c8 = -0.0000000000114707451267755432394;
        local c9 = 0.0000000000000477945439406649917;
        local c10 = -0.00000000000000015612263428827781;
        local  c11 = 0.00000000000000000039912654507924;
        local x2 = x * x
        if quadrand == 0 or quadrand == 3 then
            return (c1 + (x2 * (c2 + (x2 * (c3 + (x2 * (c4 + (x2 * (c5 + (x2 * (c6 + (x2 * (c7 + (x2 * (c8 + (x2 * (c9 + (x2 * (c10 + (x2 * c11))))))))))))))))))))
        else
            return -(c1 + (x2 * (c2 + (x2 * (c3 + (x2 * (c4 + (x2 * (c5 + (x2 * (c6 + (x2 * (c7 + (x2 * (c8 + (x2 * (c9 + (x2 * (c10 + (x2 * c11))))))))))))))))))))
        end
    end,
    
    Cosh = function(v)
        if math and math.cosh and not System.Math.UsePureLuaImplementation then return math.cosh(v) end
        
        if x < 0 then
            x = -x
        end
        return ((x == 0) and 1 or ((x <= (System.Math.ln2 / 2)) and (1 + (((System.Math.Exp(x) - 1) ^ 2) / (2 * System.Math.Exp(x)))) or ((x <= 22) and ((System.Math.Exp(x) + (1 / System.Math.Exp(x))) / 2) or (0.5 * (System.Math.Exp(x) + System.Math.Exp(-x))))));
    end,
    
    Deg = function(rad)
        return rad / System.Math.RADIANS_PER_DEGREE
    end,
    
    Exp = function(v)
        return System.Math.E ^ v
    end,
    
    Floor = function(v)
        if math and math.floor and not System.Math.UsePureLuaImplementation then return math.floor(v) end
        
        if System.Double.IsNaN(v) or System.Double.IsInfinity(v) then
            return v
        end
        
        return System.Math.Truncate(v)
    end,
    
    Fmod = function(x, y)
        return x - System.Math.Floor(x / y) * y
    end,
    
    Frexp = function(x)
        local y = System.Math.Log(x, 2) + 1
        return x / system.Math.Pow(2, y), y
    end,
    
    IEEERemainder = function(a, b)
        if System.Double.IsNaN(a) then
            return a
        end
        if System.Double.IsNaN(b) then
            return b
        end
        local num = a % b
        if System.Double.IsNaN(num) then
            return System.Double.NaN
        end
        if num == 0.0 and System.Double.IsNegative(x) then
            return System.Double.NegativeZero
        end
        local num2 = num - System.Math.Abs(y) * System.Math.Sign(x)
        if System.Math.Abs(num2) == System.Math.Abs(num) then
            local num3 = x / y
            local value = System.Math.Round(num3)
            if Math.Abs(value) > Math.Abs(num3) then
                return num2
            end
            return num
        else
            if System.Math.Abs(num2) < System.Math.Abs(num) then
                return num2
            end
            return num
        end
    end,
    
    InternalRound = function(val, digits, rounding)
        local function round(x, y)
            if not y then
                return System.Math.Floor(x + 0.5)
            end
            local mult = 10 ^ y
            return System.Math.Floor(x * mult + 0.5) / mult
        end
        
        if math and math.round then return math.round(val, digits) end
        if rounding == System.MidpointRounding.ToEven then
            return round(val, digits)
        elseif rounding == System.MidpointRounding.AwayFromZero then
            -- Not sure if this is correct...
            local r = round(val, digits)
            if r < 1 then
                r = round(val + 1, digits)
            end
            return r
        end
    end,
    
    InternalTruncate = function(double, truncate)
        -- TODO: FIX ME
        local str = tostring(double)
        local dot = System.StringHelper.IndexOf(str, '.')
        if dot ~= -1 then
            local len = dot + truncate
            local ret = str:sub(1, len)
            return tonumber(ret)
        else
            return double
        end
        -- Causes StackOverflow with a cyclic reference...
        --return System.Math.Floor(double * (10 ^ truncate)) / (10 ^ truncate)
    end,
    
    Log = function(a, b)
        if not b then
            if math and math.log and not System.Math.UsePureLuaImplementation then return math.log(a) end
            return System.Math.Log(a, System.Math.E)
        else
            if System.Double.IsNaN(a) then
                return a
            end
            if System.Double.IsNaN(b) then
                return b
            end
            if b == 1.0 then
                return System.Double.NaN
            end
            if a ~= 1.0 and (b == 0.0 or System.Double.IsPositiveInfinity(b)) then
                return System.Double.NaN
            end
            
            if math and math.log and not System.Math.UsePureLuaImplementation then
                return math.log(a) / math.log(b)
            end
            
            if a == 0 then
                return System.Double.NegativeInfinity
            end
            if a < 1.0 and b < 1 then
                System.ThrowHelper.Throw(System.ArgumentOutOfRangeException:new(System.Resources.GetString'Math_CantComputeLog'))
            end

            local partial = 0.5
            local integer = 0
            local fractional = 0

            while a < 1 do
                integer  = integer - 1
                a = a * b
            end

            while a >= b do
                integer = integer + 1
                a = a / b
            end

            a = a * a

            while partial >= 2.22045e-016 do
                if a >= b then
                    fractional = fractional + partial
                    a = a / b
                end
                partial = partial * 0.5
                a = a * a
            end

            return integer + fractional
        end
    end,
    
    Ldexp = function(x, y)
        return x * System.Math.Pow(2, y)
    end,
    
    Log10 = function(v)
        if math and math.log10 and not System.Math.UsePureLuaImplementation then return math.log10(v) end
        
        return System.Math.Log(v, 10)
    end,
    
    Max = function(...)
        if math and math.max and not System.Math.UsePureLuaImplementation then return math.max(...) end
        
        local t = { ... }
        local max = nil
        for k, v in pairs(t) do
            if not max or max < v then
                max = v
            end
        end
        return max
    end,
    
    Min = function(...)
        if math and math.min and not System.Math.UsePureLuaImplementation then return math.min(...) end
        
        local t = { ... }
        local max = nil
        for k, v in pairs(t) do
            if not max or max > v then
                max = v
            end
        end
        return max
    end,
    
    Modf = function(x)
        return x - System.Math.Floor(x), System.Math.Floor(x)
    end,
    
    Pow = function(a, b)
        if true then
            return a ^ b
        else
            if b == 0 then return 1 end
            
            if a <= 0 then
                local temp = 0
                local l
                 
                l = System.Math.Floor(b)
                if l ~= b then
                    temp = System.Math.Exp(b * System.Math.Log(-a))
                end
                if l % 2 == 1 then
                    temp = -temp
                end
                return temp
            end
            return (System.Math.Exp(b * System.Math.Log(a)))
        end
    end,
    
    Rad = function(deg)
        return deg * System.Math.RADIANS_PER_DEGREE
    end,
    
    Round = function(num, decimals, mode)
        mode = mode or System.MidpointRounding.ToEven
        decimals = decimals or 0
        return System.Math.InternalRound(num, decimals, mode)
    end,
    
    Sign = function(v)
        if v < 0 then
            return -1
        elseif v > 0 then
            return 1
        else
            return 0
        end
    end,
    
    Sin = function(v)
        if math and math.sin and not System.Math.UsePureLuaImplementation then return math.sin(v) end
        
        while v > 2 * System.Math.PI do
            v = v - (2 * System.Math.PI)
        end
        
        return System.Math.Cos((System.Math.PI / 2) - v)
    end,
    
    Sinh = function(v)
        if math and math.sing and not System.Math.UsePureLuaImplementation then return math.sinh(v) end
        
        if v < 0 then
            v = -v
        end
        
        if v <= 22 then
            local Ex_1 = System.Math.Tanh(v / 2) * (System.Math.Exp(v) + 1)
            return ((Ex_1 + (Ex_1 / (Ex_1 - 1))) / 2)
        else
            return (System.Math.Exp(v) / 2)
        end
    end,
    
    Sqrt = function(v)
        if math and math.sqrt and not System.Math.UsePureLuaImplementation then
            math.sqrt(v)
        end
        return v ^ 0.5
    end,
    
    Tan = function(x)
        if math and math.tan and not System.UsePureLuaImplementation then return math.tan(x) end
        
        -- First we need to anchor it to a valid range.
        while x > 2 * System.Math.PI do
            x = x - (2 * PI)
        end
        
        local octant = System.Math.Floor(x * (1 / (System.Math.PI / 4)))
        if octant == 0 then
            x = x * (4 / System.Math.PI)
        elseif octant == 1 then
            x = ((System.Math.PI / 2) - x) * (4 / System.Math.PI)
        elseif octant == 2 then
            x = (x - (System.Math.PI / 2)) * (4 / System.Math.PI)
        elseif octant == 3 then
            x = (System.Math.PI - x) * (4 / System.Math.PI)
        elseif octant == 4 then
            x = (x - System.Math.PI) * (4 / System.Math.PI)
        elseif octant == 5 then
            x = ((3.5 * System.Math.PI) - x) * (4 / System.Math.PI)
        elseif octant == 6 then
            x = (x - (3.5 * System.Math.PI)) * (4 / System.Math.PI)
        elseif octant == 7 then
            x = ((2 * System.Math.PI) - x) * (4 / System.Math.PI)
        end

        local c1 = 4130240.588996024013440146267
        local c2 = -349781.8562517381616631012487
        local c3 = 6170.317758142494245331944348
        local c4 = -27.94920941380194872760036319
        local c5 = 0.0175143807040383602666563058
        local c6 = 5258785.647179987798541780825
        local c7 = -1526650.549072940686776259893
        local c8 = 54962.51616062905361152230566
        local c9 = -497.495460280917265024506937
        local x2 = x * x
        if octant == 0 or octant == 4 then
            return ((x * (c1 + (x2 * (c2 + (x2 * (c3 + (x2 * (c4 + (x2 * c5))))))))) / (c6 + (x2 * (c7 + (x2 * (c8 + (x2 * (c9 + x2))))))))
        elseif octant == 1 or octant == 5 then
            return (1 / ((x * (c1 + (x2 * (c2 + (x2 * (c3 + (x2 * (c4 + (x2 * c5))))))))) / (c6 + (x2 * (c7 + (x2 * (c8 + (x2 * (c9 + x2)))))))))
        elseif octant == 2 or octant == 6 then
            return (-1 / ((x * (c1 + (x2 * (c2 + (x2 * (c3 + (x2 * (c4 + (x2 * c5))))))))) / (c6 + (x2 * (c7 + (x2 * (c8 + (x2 * (c9 + x2)))))))))
        else -- octant == 3 or octant == 7
            return -((x * (c1 + (x2 * (c2 + (x2 * (c3 + (x2 * (c4 + (x2 * c5))))))))) / (c6 + (x2 * (c7 + (x2 * (c8 + (x2 * (c9 + x2))))))))
        end
    end,
    
    Tanh = function(v)
        if math and math.tanh and not System.Math.UsePureLuaImplementation then return math.tanh(v) end
        
        return (System.Math.Expm1(2 * v) / (System.Math.Expm1(2 * v) + 2))
    end,
    
    Truncate = function(v, amount)
        amount = amount or 0
        return System.Math.InternalTruncate(v, amount)
    end,
    
    AtanS = function(x)
        if x < System.Math.sq2m1 then
            return System.Math.AtanX(x)
        elseif x < System.Math.sq2p1 then
            return System.Math.pio2 - System.Math.AtanX(1 / x)
        else
            return System.Math.pio4 + System.Math.AtanX((x - 1) / (x + 1))
        end
    end,
    
    AtanX = function(x)
        local sq, v
        
        if x > -0.01 and x < 0.01 then
            v = System.Math.atan_p0 / System.Math.atan_q0
        else
            sq = x * x
            v = ((((System.Math.atan_p4 * sq + System.Math.atan_p3) * sq + System.Math.atan_p2) * sq + System.Math.atan_p1) * sq + System.Math.atan_p0) / (((((sq + System.Math.atan_q4) * sq + System.Math.atan_q3) * sq + System.Math.atan_q2) * sq + System.Math.atan_q1) * sq + System.Math.atan_q0)
        end
        return v * x
    end,
    
    Expm1 = function(x)
        local u = System.Math.Exp(x)
        return ((u == 1) and x or ((u - 1 == -1) and -1 or ((u - 1) * x / System.Math.Log(u))))
    end,
    
    -- In #Lua, its simpler:
    -- Factorial = |n| -> n < 2 and 1 or n * System.Math.Factorial(n - 1),
    Factorial = function(n)
        return n < 2 and 1 or n * System.Math.Factorial(n - 1)
    end,
    
    --- <summary>
    --- Gets the greatest common divisor between two integers <br />
    --- 
    --- This uses Stein's Algorithm <br />
    --- </summary>
    --- <param name="a">The first integer</param>
    --- <param name="b">The second integer</param>
    --- <returns>The greatest common multiple</returns>
    GCD = function(a, b)
        if a == b then return a end
        if a == 0 then return 0 end
        if b == 0 then return a end
        
        --[[
        NOTE: [number] % 2 == 0 is what is used to check if a 
        number is even or odd
        
        If the expression equals 0, then the number is even, if the expression does
        not equal 0, then the number is odd.
        ]]
        
        -- If both even
        if a % 2 == 0 and b % 2 == 0 then
            return System.Math.GCD(a / 2, (b / 2) * 2)
        end
        
        -- If a is even and b is odd
        if a % 2 == 0 and b % 2 ~= 0 then
            return System.Math.GCD(a / 2, b)
        end
        
        -- If a is odd and b is even
        if a % 2 ~= 0 and b % 2 == 0 then
            return System.Math.GCD(a, b / 2)
        end
        
        -- If both odd
        if a % 2 ~= 0 and b % 2 ~= 0 then
            if a >= b then
                return System.Math.GCD((a - b) / 2, b)
            else
                return System.Math.GCD((b - a) / 2, a)
            end
        end
        return 0
    end,
    
    --- <summary>
    --- Gets the least common multiple between two integers
    --- </summary>
    --- <param name="a">The first integer</param>
    --- <param name="b">The second integer</param>
    --- <returns>The least common multiple</returns>
    LCM = function(a, b)
        if a == 0 and b == 0 then return 0 end
        if a == 0 then return b end
        if b == 0 then return a end
        
        return (a * b) / System.Math.GCD(a, b)
    end,
}
System.Math.RADIANS_PER_DEGREE = System.Math.PI / 180.0

setmetatable(System.Math, { __index = System.Object })

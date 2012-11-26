System.Complex = {
    ClassName = "Complex",
    
    new = function(self, real, imaginary)
        real = real or 0
        imaginary = imaginary or 0
        local mt = System.GetStandardMetatable()
        mt.__unm = function(a) return System.Complex:new(-a.real, a.imaginary) end
        mt.__add = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return System.Complex:new(a.real + b.real, a.imaginary + b.imaginary)
            else
                return System.Complex:new(a.real + b, a.imaginary)
            end
        end
        mt.__sub = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return System.Complex:new(a.real - b.real, a.imaginary - b.imaginary)
            else
                return System.Complex:new(a.real - b, a.imaginary)
            end
        end
        mt.__mul = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return System.Complex:new(a.real * b.real, a.imaginary * b.imaginary)
            else
                return System.Complex:new(a.real * b, a.imaginary)
            end
        end
        mt.__div = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return System.Complex:new(a.real / b.real, a.imaginary / b.imaginary)
            else
                return System.Complex:new(a.real / b, a.imaginary)
            end
        end
        mt.__pow = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return System.Complex:new(a.real ^ b.real, a.imaginary ^ b.imaginary)
            else
                return System.Complex:new(a.real ^ b, a.imaginary)
            end
        end
        mt.__lt = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return a.real < b.real and a.imaginary < b.imaginary
            else
                return a.real < b
            end
        end
        mt.__le = function(a, b)
            a, b = System.Complex.FixArgs(a, b)
            if System.Complex.IsComplex(a) and System.Complex.IsComplex(b) then
                return a.real <= b.real and a.imaginary <= b.imaginary
            else
                return a.real <= b
            end
        end
        
        return setmetatable({
            real = real,
            imaginary = imaginary,
        }, mt)
    end,
    
    FixArgs = function(a, b)
        if System.Complex.IsComplex(a) then
            return a, b
        else
            return b, a
        end
    end,
    
    IsComplex = function(o)
        return o and type(o) ==  "table" and o.real and o.imaginary and o.GetType and o:GetType().FullName == "System.Complex"
    end,
    
    Equals = function(a, b)
        return a and b
            and ((System.Complex.IsComplex(a) and System.Complex.IsComplex(b) and a.real == b.real and a.imaginary == b.imaginary)
            or (System.Complex.IsComplex(a) and not System.Complex.IsComplex(b) and a.real == b)
            or (System.Complex.IsComplex(b) and not System.Complex.IsComplex(a) and b.real == a))
    end,
    
    ToString = function(self)
        return
            tostring(self.real)
            .. " + " ..
            tostring(self.imaginary)
            .. "i"
    end,
}

setmetatable(System.Complex, { __index = System.Object })

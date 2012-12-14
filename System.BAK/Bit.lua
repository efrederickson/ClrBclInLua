
-- System.Binary?
-- convert to/from binary

local bit = bit or bit32
if not bit then
    pcall(function() if not bit then bit = require"bit" end end)
    --System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString("BitLibraryNotFound")))
end
if not bit then
    bit = System.InternalBit -- pure lua implementation
end

local bit2 = { }
for k, v in pairs(bit) do bit2[k] = v end
for k, v in pairs(System.InternalBit) do if not bit2[k] then bit2[k] = v end end
bit = bit2
setmetatable(bit, { __index = function(t, k) System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString("BitLibraryFunctionNotFound", k))) end })

System.Bit = {
    ClassName = "Bit",

    new = function()
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,

    ToBit = function(...) return bit.tobit(...) end,

    ToHex = function(...) return bit.tohex(...) end,

    BAnd = function(...) return bit.band(...) end,

    BOr = function(...) return bit.bor(...) end,

    BXor = function(...) return bit.bxor(...) end,
    
    Xor = function(...) return System.Bit.BXor(...) end,

    BNot = function(...) return bit.bnot(...) end,

    LShift = function(...) return bit.lshift(...) end,

    RShift = function(...) return bit.rshift(...) end,

    Extract = function(...) return bit.extract(...) end,

    Replace = function(...) return bit.replace(...) end,

    BSwap = function(...) return bit.bswap(...) end,

    Swap = function(...) return System.Bit.BSwap(...) end,

    RRotate = function(...) return bit.rrotate(...) end,

    ROr = function(...) return bit.ror(...) end,

    LRotate = function(...) return bit.lrotate(...) end,

    ROl = function(...) return bit.rol(...) end,

    ARShift = function(...) return bit.arshift(...) end,

    BTest = function(...) return bit.btest(...) end,

}

setmetatable(System.Bit, { __index = System.__index })

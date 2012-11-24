require"System.Globalization"

local bit = bit or bit32 -- test for already existing bit libraries
pcall(function() if not bit then bit = require'bit' end end)

local categoryForLatin1 = {
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	11,
	24,
	24,
	24,
	26,
	24,
	24,
	24,
	20,
	21,
	24,
	25,
	24,
	19,
	24,
	24,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	24,
	24,
	25,
	25,
	25,
	24,
	24,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	20,
	24,
	21,
	27,
	18,
	27,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	20,
	25,
	21,
	25,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	14,
	11,
	24,
	26,
	26,
	26,
	26,
	28,
	28,
	27,
	28,
	1,
	22,
	25,
	19,
	28,
	27,
	28,
	25,
	10,
	10,
	27,
	1,
	28,
	24,
	27,
	10,
	1,
	23,
	10,
	10,
	10,
	24,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	25,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	25,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1
}

System.Char = {
    ClassName = "Char",
    Namespace = "System",
    Implements = { System.IComparable, System.IConvertable, System.IEquatable },
    HIGH_SURROGATE_START = 55296,
    LOW_SURROGATE_END = 57343,
    MaxValue = '\255',
    MinValue = '\0',
    
    CheckLetter = function(uc)
        local u = System.Globalization.UnicodeCategory
        return uc == u.UppercaseLetter or
            uc == u.LowercaseLetter or
            uc == u.TitlecaseLetter or
            uc == u.ModifierLetter or 
            uc == u.OtherLetter or 
            false
    end,
    
    CheckLetterOrDigit = function(uc)
        local u = System.Globalization.UnicodeCategory
        return uc == u.UppercaseLetter or
            uc == u.LowercaseLetter or
            uc == u.TitlecaseLetter or
            uc == u.ModifierLetter or 
            uc == u.OtherLetter or 
            uc == u.DecimalDigitNumber or 
            false
    end,
    
    CheckNumber = function(uc)
        local u = System.Globalization.UnicodeCategory
        return uc == u.DecimalDigitNumber or
            uc == u.LetterNumber or
            uc == u.OtherNumer or
            false
    end,
    
    CheckPunctuation = function(uc)
        local u = System.Globalization.UnicodeCategory
        return uc == u.ConnectorPunctuation or
            uc == u.DashPunctuation or
            uc == u.OpenPunctuation or
            uc == u.ClosePunctuation or
            uc == u.InitialQuotePunctuation or
            uc == u.FinalQuotePunctuation or
            uc == u.OtherPunctuation or
            false
    end,
    
    CheckSeparator = function(uc)
        local u = System.Globalization.UnicodeCategory
        return uc == u.SpaceSeparator or
            uc == u.LineSeparator or
            uc == u.ParagraphSeparator or
            false
    end,
    
    CheckSymbol = function(uc)
        local u = System.Globalization.UnicodeCategory
        return uc == u.ModifierSymbol or
            uc == u.CurrencySymbol or
            uc == u.MathSymbol or
            uc == u.OtherSymbol or
            false
    end,
    
    CompareTo = function(a, b)
        if not a then return -1 end
        if not b then return 1 end
        return (System.Char.IsChar(a) and System.Char.IsChar(b) and a - b) or false
    end,
    
    IsChar = function(obj)
        if not obj then return false end
        if type(obj) ~= "table" then return false end
        return obj.char and obj.IsChar and obj.GetType and obj.GetType().FullName == "System.Char"
    end,
    
    new = function(self, ch)
        if type(ch) == "number" then
            ch = string.char(ch)
        end
        local mt = System.GetStandardMetatable()
        -- TODO: Maybe add other binary operators
        mt.__sub = function(self, other)
            if System.Char.IsChar(self) and System.Char.IsChar(other) then
                return string.byte(self.char) - string.byte(other.char)
            end
            return nil
        end
        mt.__index = self
        return setmetatable({
            char = ch,
        }, mt)
    end,
    
    ToString = function(self)
        return self.char
    end,
    
    ToUnicodeInt = function(s)
        -- According to C#, \u is the escape sequence for unicode chars
        -- http://msdn.microsoft.com/en-us/library/aa664669(v=vs.71).aspx
        -- It is supposedlt Hex, so we convert it as such
        return tonumber(s, 16)
    end,
    
    ConvertFromUtf32 = function(i)
        if i < 0 or i > 1114111 or (i >= 55296 and i <= 57343) then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString("ArgumentOutOfRange_InvalidUTF32")))
        end
        if i < 65536 then
            -- Note: AFAIK only #Lua supports this wide a range of chars. All other implementations go up to 255
            return string.char(i)
        end
        i = i - 65536
        return System.String:new(
            string.char(i / 1024 + 55296),
            string.char(i % 1024 + 55296)
        )
    end,
    
    ConvertToUtf32 = function(high, low)
        if not System.Char.IsHighSurrogate(high) then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString("ArgumentOutOfRange_InvalidHighSurrogate")))
        end
        if not System.Char.IsLowSurrogate(low) then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString("ArgumentOutOfRange_InvalidLowSurrogate")))
        end
        return ((highSurrogate - System.Char.ToUnicodeInt'd800') * '?' + (lowSurrogate - System.Char.ToUnicodeInt'dc00')) + 65536
    end,
    
    Equals = function(a, b)
        return a == b or (a and b and System.Char.IsChar(a) and System.Char.IsChar(b) and a.char == b.char)
    end,
    
    GetHashCode = function(self)
        if bit and bit.bor and bit.lshift then -- check if a suitable bit library was found
            local bor = bit.bor
            local blshift = bit.lshift
            local c = string.byte(self.char)
            return bor(c, blshift(c, 16))
        else
            System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString("BitLibraryNotFound")))
        end
    end,
    
    GetLatin1UnicodeCategory(ch)
        if System.Char.IsChar(ch) == false then
            System.ThrowHelper.Throw(System.Resources.GetString("Argument_NotChar"))
        end
        return System.Globalization.UnicodeCategory.From(categoryForLatin1[ch])
    end
}

setmetatable(System.Char, { __index = System.Object })

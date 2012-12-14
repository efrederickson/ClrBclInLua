require"System.Globalization"

local categoryForLatin1 = {
	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,
	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	11,	24,	24,	24,	26,	24,
	24,	24,	20,	21,	24,	25,	24,	19,	24,	24,	8,	8,	8,	8,	8,	8,	8,	8,	8,
	8,	24,	24,	25,	25,	25,	24,	24,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	20,	24,	21,	27,
	18,	27,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,
	1,	1,	1,	1,	1,	1,	1,	1,	1,	20,	25,	21,	25,	14,	14,	14,	14,	14,	14,
	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,	14,
	14,	14,	14,	14,	14,	14,	14,	14,	11,	24,	26,	26,	26,	26,	28,	28,	27,	28,	1,
	22,	25,	19,	28,	27,	28,	25,	10,	10,	27,	1,	28,	24,	27,	10,	1,	23,	10,	10,
	10,	24,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	25,	0,	0,	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,
	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,
	25,	1,	1,	1,	1,	1,	1,	1, 1
}

-- Oops. Forgot I need to add 1 to the index. Had to figure out why '$' (36) was not a symbol (UnicodeCategory of 24)
--print(categoryForLatin1[35], categoryForLatin1[36], categoryForLatin1[37])

System.Char = {
    ClassName = "Char",
    Namespace = "System",
    Implements = { System.IComparable, 
        --System.IConvertable, 
        System.IEquatable },
    --Inherits = System.ValueType, Note: System.Char is type 'struct' in the CLR
    HIGH_SURROGATE_START = 55296,
    LOW_SURROGATE_END = 57343,
    MaxValue = '\255',
    MinValue = '\0',
    
    new = function(self, ch)
        if System.Char.IsChar(ch) then
            return System.Char:new(ch.char)
        end
        
        if type(ch) == "number" then
            ch = string.char(ch)
        end
        if type(ch) ~= "string" then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString("Argument_NotString")))
        end
        if ch:len() ~= 1 then
            if ch:sub(1, 2) == "\\u" then
                ch = string.char(System.Char.ToUnicodeInt(ch:sub(3)))
            else
                System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString("Argument_StringLengthNotOne")))
            end
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
    
    FromUnicode = function(c)
        if c:sub(1, 2) == "\\u" then c = c:sub(3) end
        local n = tonumber(c, 16)
        if not n then n = tonumber(c) end
        if not n then return c end
        if n > 255 and not System.Char.SupportsUTF then return "" end
        return System.Char:new(n)
    end,
    
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
        return obj.char and obj.IsChar and obj.GetType and obj:GetType().FullName == "System.Char"
    end,
    
    ToString = function(self)
        return self.char
    end,
    
    ToUnicodeInt = function(s)
        -- According to C#, \u is the escape sequence for unicode chars
        -- http://msdn.microsoft.com/en-us/library/aa664669(v=vs.71).aspx
        -- It is supposedly Hex, so we convert it as such
        return tonumber(s, 16)
    end,
    
    ToNativeChar = function(obj)
        if System.Char.IsChar(obj) then return obj.char end
        if type(obj) == "string" then return obj end
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString("Argument_NotChar2")))
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
        local c = string.byte(self.char)
        return System.Bit.BOr(c, System.Bit.LShift(c, 16))
    end,
    
    GetLatin1UnicodeCategory = function(ch)
        local char = System.Char.ToNativeChar(ch)
        char = string.byte(char)
        return System.Globalization.UnicodeCategory.From(categoryForLatin1[char + 1])
    end,
    
    GetNumericValue = function(a, index)
        local char = a
        if index then
            char = a:sub(index, index)
        end
        return System.CharUnicodeInfo.GetNumericValue(char)
    end,
    
    GetTypeCode = function(self)
        return System.TypeCode.Char
    end,
    
    GetUnicodeCategory = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return System.Char.GetLatin1UnicodeCategory(a)
        end
        return System.CharUnicodeInfo.InternalGetUnicodeCategory(char:ToNumber())
    end,
    
    ToNumber = function(self)
        return string.byte(self.char)
    end,
    
    IsAscii = function(s)
        local char = System.Char.ToNativeChar(s)
        return char <= string.char(System.Char.ToUnicodeInt'007F')
    end,
    
    IsControl = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return System.Char.GetLatin1UnicodeCategory(char) == System.Globalization.UnicodeCategory.Control
        end
        return System.CharUnicodeInfo.GetUnicodeCategory(char) == System.Globalization.UnicodeCategory.Control
    end,
    
    IsDigit = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return char.char >= '0' and char.char <= '9'
        end
        return System.CharUnicodeInfo.GetUnicodeCategory(cahr) == System.Globalization.UnicodeCategory.DecimalDigitNumber
    end,
    
    IsHighSurrogate = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        return char.char >= System.Char:new(System.Char.ToUnicodeInt'D800').char and char.char <= System.Char:new(System.Char.ToUnicodeInt'DBFF').char
    end,
    
    IsLatin1 = function(char)
        char = System.Char.ToNativeChar(char)
        return char <= '\255'
    end,
    
    IsLetter = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if not System.Char.IsLatin1(char) then
            return System.Char.CheckLetter(System.CharUnicodeInfo.GetUnicodeCategory(char))
        end
        if System.Char.IsAscii(char) then
            local n = char:ToNumber()
            local n2 = System.Bit.BOr(n, string.byte' ')
            local ch = string.char(n2)
            return ch >= 'a' and ch <= 'z'
        end
    end,
    
    IsLetterOrDigit = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        if System.Char.IsLatin1(char) then
            return System.Char.CheckLetterOrDigit(System.Char.GetLatin1UnicodeCategory(char))
        end
        return System.Char.CheckLetterOrDigit(System.CharUnicodeInfo.GetUnicodeCategory(char))
    end,
    
    IsLower = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if not System.Char.IsLatin1(char) then
            return System.CharUnicodeInfo.GetUnicodeCategory(char) == System.Globalization.UnicodeCategory.LowercaseLetter
        end
        if System.Char.IsAscii(char) then
            return char.char >= 'a' and char.char <= 'z'
        end
        return System.Char.GetLatin1UnicodeCategory(char) == System.Globalization.UnicodeCategory.LowercaseLetter
    end,
    
    IsLowSurrogate = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        return char.char >= string.char(System.Char.ToUnicodeInt'DC00') and char.char <= string.char(System.Char.ToUnicodeInt'DFFF')
    end,
    
    IsNumber = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if not System.Char.IsLatin1(char) then
            return System.Char.CheckNumber(System.CharUnicodeInfo.GetUnicodeCategory(char))
        end
        if System.Char.IsAscii(char) then
            return char.char >= '0' and char.char <= '9'
        end
        return System.Char.CheckNumber(System.Char.GetLatin1UnicodeCategory(char))
    end,
    
    IsPunctuation = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return System.Char.CheckPunctuation(System.Char.GetLatin1UnicodeCategory(char))
        end
        return System.Char.CheckPunctuation(System.CharUnicodeInfo.GetUnicodeCategory(char))
    end,
    
    IsSeparator = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return System.Char.IsSeparatorLatin1(char)
        end
        return System.Char.CheckSeparator(System.CharUnicodeInfo.GetUnicodeCategory(char))
    end,
    
    IsSeparatorLatin1 = function(char)
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        char = char.char
        return char == ' ' or char == string.char(System.Char.ToUnicodeInt'00A0')
    end,
    
    IsSurrogate = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        char = char.char
        return char >= string.char(System.Char.ToUnicodeInt'D800') and char <= string.char(System.Char.ToUnicodeInt'DFFF')
    end,
    
    IsSurrogatePair = function(a, b)
        local charA = a
        local charB = b
        if type(b) == "number" and type(a) == "string" then
            charA = System.Char:new(a:sub(b, b))
            charB = System.Char:new(a:sub(b + 1, b + 1))
        end
        charA = charA.char
        charB = charB.char
        return charA >= string.char(System.Char.ToUnicodeInt'd800') and
            charA <= string.char(System.Char.ToUnicodeInt'DBFF') and
            charB >= string.char(System.Char.ToUnicodeInt'DC00') and
            charB <= string.char(System.Char.ToUnicodeInt'DFFF')
    end,
    
    IsSymbol = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return System.Char.CheckSymbol(System.Char.GetLatin1UnicodeCategory(char))
        end
        return System.Char.CheckSymbol(System.CharUnicodeInfo.GetUnicodeCategory(char))
    end,
    
    IsUpper = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if not System.Char.IsLatin1(char) then
            return System.Char.GetUnicodeCategory(char) == System.Globalization.UnicodeCategory.UppercaseLetter
        end
        if System.Char.IsAscii(char) then
            local char = System.Char.ToNativeChar(char)
            return char >= 'A' and char <= 'Z'
        end
        return System.Char.GetLatin1UnicodeCategory(char) == System.Globalization.UnicodeCategory.UppercaseLetter
    end,
    
    IsWhiteSpace = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        if System.Char.IsChar(char) == false then char = System.Char:new(char) end
        
        if System.Char.IsLatin1(char) then
            return System.Char.IsWhiteSpaceLatin1(char)
        end
        return System.CharUnicodeInfo.IsWhiteSpace(char)
    end,
    
    IsWhiteSpaceLatin1 = function(char)
        local c = System.Char.ToNativeChar(char)
        return c == ' ' or (c >= '\t' and c <= '\r') or c == string.char(System.Char.ToUnicodeInt'00A0') or c == string.char(System.Char.ToUnicodeInt'0085')
    end,
    
    Parse = function(str)
        return System.Char:new(str)
    end,
    
    ToLower = function(char, cult)
        cult = cult or System.Globalization.CultureInfo.CurrentCulture
        return cult.TextInfo.ToLower(System.Char.ToNativeChar(char))
    end,
    
    ToLowerInvariant = function(char)
        return System.Char.ToLower(char, System.Globalization.CultureInfo.InvariantCulture)
    end,
    
    ToUpper = function(char, cult)
        cult = cult or System.Globalization.CultureInfo.CurrentCulture
        return cult.TextInfo.ToUpper(System.Char.ToNativeChar(char))
    end,
    
    ToUpperInvariant = function(char)
        return System.Char.ToUpper(char, System.Globalization.CultureInfo.InvariantCulture)
    end,
    
    -- TODO: IConvertable, TryParse
}

setmetatable(System.Char, { __index = 
    function(t, k)
        if k == "SupportsUTF" then
            local uChar
            pcall(function() uChar = string.char(256) end)
            if uChar then return true end
            return false
        end
        return System.Object[k]
    end
})

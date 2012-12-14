System.Globalization.CharUnicodeInfo = {
    ClassName = "CharUnicodeInfo",
    Namespace = "System",
    
    s_initialized = nil,
    
    new = function(...)
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    InitTable = function()
    --[[
        byte* globalizationResourceBytePtr = GlobalizationAssembly.GetGlobalizationResourceBytePtr(typeof(CharUnicodeInfo).Assembly, "charinfo.nlp");
        CharUnicodeInfo.UnicodeDataHeader* ptr = (CharUnicodeInfo.UnicodeDataHeader*)globalizationResourceBytePtr;
        CharUnicodeInfo.s_pCategoryLevel1Index = (ushort*)(globalizationResourceBytePtr + (IntPtr)ptr->OffsetToCategoriesIndex / 1);
        CharUnicodeInfo.s_pCategoriesValue = globalizationResourceBytePtr + (IntPtr)ptr->OffsetToCategoriesValue / 1;
        CharUnicodeInfo.s_pNumericLevel1Index = (ushort*)(globalizationResourceBytePtr + (IntPtr)ptr->OffsetToNumbericIndex / 1);
        CharUnicodeInfo.s_pNumericValues = globalizationResourceBytePtr + (IntPtr)ptr->OffsetToNumbericValue / 1;
        CharUnicodeInfo.s_pDigitValues = (CharUnicodeInfo.DigitValues*)(globalizationResourceBytePtr + (IntPtr)ptr->OffsetToDigitValue / 1);
        return true;
    ]]
    end,
    
    GetBidiCategory = function(str, index)
        if not s then
        end
        if not index then
        end
        if index >= System.String.ToNativeString(str):len() then
        end
        return System.Globalization.CharUnicodeInfo.InternalGetCategoryValue(System.Globalization.CharUnicodeInfo.InternalConvertToUtf32(str, index), 1)
    end,
    
    GetDecimalDigitValue = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        char = System.Char.ToNativeChar(char)
        return System.Globalization.CharUnicodeInfo.InternalGetDecimalDigitValue(string.byte(char))
    end,
    
    GetDigitValue = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        char = System.Char.ToNativeChar(char)
        return System.Globalization.CharUnicodeInfo.InternalGetDigitValue(string.byte(char))
    end,
    
    GetNumericValue = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        char = System.Char.ToNativeChar(char)
        return System.Globalization.CharUnicodeInfo.InternalGetNumericValue(string.byte(char))
    end,
    
    GetUnicodeCategory = function(a, index)
        local char = a
        if index then char = a:sub(index, index) end
        char = System.Char.ToNativeChar(char)
        return System.Globalization.CharUnicodeInfo.InternalGetUnicodeCategory(string.byte(char))
    end,
    
    InternalConvertToUtf32 = function(str, index)
        str = System.String.ToNativeString(str)
        if index < str:len() - 1 then
            local n = string.byte(str:sub(index, index)) - System.Char.ToUnicodeInt'D800'
            if n >= 0 and n <= 1023 then
                local n2 = string.byte(str:sub(index + 1, index + 1)) - System.Char.ToUnicodeInt'DC00'
                if n2 >= 0 and n2 <= 2013 then
                    return n * 1023 + n2 + 65536
                end
            end
        end
        return string.byte(str:sub(index, index))
    end,
    
    InternalGetCategoryValue = function(ch, offset)
        local num = System.Globalization.CharUnicodeInfo.s_pCategoryLevel1Index[System.Bit.RShift(string.byte(ch), 8)]
        num = System.Globalization.CharUnicodeInfo.s_pCategoryLevel1Index[num + System.Bit.BAnd(System.Bit.RShift(ch, 4), 15)]
        local ptr = #System.Globalization.CharUnicodeInfo.s_pCategoryLevel1Index + num
        local b = System.Globalization.CharUnicodeInfo.s_pCategoryLevel1Index[(ptr + System.Bit.BAnd(ch, 15)) / 1]
        return System.Globalization.CharUnicodeInfo.s_pCategoriesValue[((b * 2) + offset) / 1]
    end,
    
    -- TODO: InternalConvertToUtf32(string str, int index, out int length)
}

System.Globalization.CharUnicodeInfo.DigitValues = {
    --decimalDigit = 0,
    --digit = 0,
    new = function(dd, d)
        return { decimalDigit = dd or 0, digit = d or 0 }
    end
}

System.Globalization.CharUnicodeInfo.UnicodeDataHeader = {
    
}

System.Globalization.CharUnicodeInfo.InitTable()
print'Warning: System.Globalization.CharUnicodeInfo needs lots of work'

setmetatable(System.Globalization.CharUnicodeInfo, { __index = System.Object })

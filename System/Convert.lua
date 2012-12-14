base64Table = {
	'A',	'B',	'C',	'D',	'E',	'F',	'G',	'H',	'I',	'J',
	'K',	'L',	'M',	'N',	'O',	'P',	'Q',	'R',	'S',	'T',
	'U',	'V',	'W',	'X',	'Y',	'Z',	'a',	'b',	'c',	'd',
	'e',	'f',	'g',	'h',	'i',	'j',	'k',	'l',	'm',	'n',
	'o',	'p',	'q',	'r',	's',	't',	'u',	'v',	'w',	'x',
	'y',	'z',	'0',	'1',	'2',	'3',	'4',	'5',	'6',	'7',
	'8',	'9',	'+',	'/',	'='
}

System.Convert = {
    ClassName = "Convert",
    Base64LineBreakPosition = 76,


    new = function()
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,

    ChangeType = function(obj, typeCode, fmtprovider)
        local tc = System.TypeCode
        if not obj and (typeCode == tc.Empty or typeCode == tc.String or typeCode == tc.Object) then return nil end

        if not System.Object.IsObject(obj) then
            System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString('NotClrClass2', type(obj))))
        end

        isConvertible = obj:GetType():ImplementsInterface(System.IConvertible)
        if not isConvertible then
            System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString('InvalidCast_ToIConvertible2', obj:GetType().FullName)))
        end

        if typeCode == tc.Empty then return nil
        elseif typeCode == tc.Object then return obj
        elseif typeCode == tc.DBNull then return System.DBNull.Value
        elseif typeCode == tc.Boolean then return obj:ToBoolean(fmtprovider)
        elseif typeCode == tc.Char then return obj:ToChar(fmtprovider)
        elseif typeCode == tc.SByte then return obj:ToSByte(fmtprovider)
        elseif typeCode == tc.Byte then return obj:ToByte(fmtprovider)
        elseif typeCode == tc.Int16 then return obj:ToInt16(fmtprovider)
        elseif typeCode == tc.UInt16 then return obj:ToUInt16(fmtprovider)
        elseif typeCode == tc.Int32 then return obj:ToInt32(fmtprovider)
        elseif typeCode == tc.UInt32 then return obj:ToUInt32(fmtprovider)
        elseif typeCode == tc.Int64 then return obj:ToInt64(fmtprovider)
        elseif typeCode == tc.UInt64 then return obj:ToUInt64(fmtprovider)
        elseif typeCode == tc.Single then return obj:ToSingle(fmtprovider)
        elseif typeCode == tc.Double then return obj:ToDouble(fmtprovider)
        elseif typeCode == tc.Decimal then return obj:ToDecimal(fmtprovider)
        elseif typeCode == tc.DateTime then return obj:ToDateTime(fmtprovider)
        elseif typeCode == tc.String then return obj:ToString(fmtprovider)
        end
    end,

    ISDBNull = function(o)
        return o == System.DBNull.Value or (System.Object.IsObject(o) and o:GetType():ImplementsInterface(System.IConvertible) and o:GetTypeCode() == System.TypeCode.DBNull)
    end
}

setmetatable(System.Convert, { __index = System.__index })

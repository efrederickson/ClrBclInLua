System.IConvertible = {
    ClassName = "IConvertible",
    
    GetTypeCode = function(self) return System.TypeCode.Empty end,
    ToBoolean = function(self) return System.Convert.ToBoolean(self) end,
    ToByte = function(self) return System.Convert.ToByte(self) end,
    ToChar = function(self) return System.Convert.ToChar(self) end,
    ToDateTime = function(self) return System.Convert.ToDateTime(self) end,
    ToDecimal = function(self) return System.Convert.ToDecimal(self) end,
    ToDouble = function(self) return System.Convert.ToDouble(self) end,
    ToInt16 = function(self) return System.Convert.ToInt16(self) end,
    ToUInt16 = function(self) return System.Convert.ToUInt16(self) end,
    ToInt32 = function(self) return System.Convert.ToInt32(self) end,
    ToUInt32 = function(self) return System.Convert.ToUnt32(self) end,
    ToInt64 = function(self) return System.Convert.ToInt64(self) end,
    ToUInt64 = function(self) return System.Convert.ToUInt64(self) end,
    ToSByte = function(self) return System.Convert.ToSByte(self) end,
    ToSingle = function(self) return System.Convert.ToSingle(self) end,
    ToString = function(self) return System.Convert.ToString(self) end,
    ToType = function(self, type) return System.Convert.ToType(self, type) end,
}
setmetatable(System.IConvertible, { __index = System.Interface })

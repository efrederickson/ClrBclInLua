System.DBNull = {
    ClassName = "DBNull",
    Implements = { System.IConvertible },
}

setmetatable(System.DBNull, { __index = System.__index })

System.DBNull.Value = System.DBNull:new()

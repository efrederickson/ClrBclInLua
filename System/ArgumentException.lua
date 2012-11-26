System.ArgumentException = {
    ClassName = "ArgumentException",
    Inherits = System.Exception,
    
}

setmetatable(System.ArgumentException, { __index = System.Exception })

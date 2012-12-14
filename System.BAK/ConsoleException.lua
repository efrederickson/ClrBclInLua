System.ConsoleException = {
    ClassName = "ConsoleException",
    Inherits = System.Exception
}

setmetatable(System.ConsoleException, { __index = System.Exception })

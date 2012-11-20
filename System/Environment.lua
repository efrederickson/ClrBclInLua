System.Environment = {
    ClassName = "Environment",
    
    NewLine = "\r\n",
    
    new = function(...)
        System.ThrowHelper.Throw(Exception:new("Cannot create an instance of System.Environment - it is static"))
    end,
}

setmetatable(System.Environment, { __index = System.Object })

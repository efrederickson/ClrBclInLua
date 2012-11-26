System.Environment = {
    ClassName = "Environment",
    Namespace = "System",
    
    NewLine = "\r\n",
    
    new = function(...)
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
}

setmetatable(System.Environment, { __index = System.Object })

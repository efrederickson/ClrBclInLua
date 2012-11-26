System.ThrowHelper = {
    ClassName = "ThrowHelper",
    Namespace = "System",
    
    new = function(...)
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    Throw = function(obj)
        if System.Object.IsObject(obj) and obj:IsA"System.Exception" == true then
            error(obj:ToString())
        else
            error("Exception thrown must inherit System.Exception")
        end
    end,
}

setmetatable(System.ThrowHelper, { __index = System.Object })

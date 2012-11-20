System.ThrowHelper = {
    ClassName = "ThrowHelper",
    
    new = function(...)
        System.ThrowHelper.Throw(Exception:new("Cannot create an instance of System.Environment - it is static"))
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

System.Resources = {
    ClassName = "Resources",
    Namespace = "System",
    CurrentLanguage = "en-US",
    
    new = function(...)
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    GetString = function(...)
        local arg = { ... }
        if type(arg[1]) == "table" then
            table.remove(arg, 1)
        end
        local str = System.LocalizedMessages[System.Resources.CurrentLanguage][arg[1]]
        if #arg > 1 then
            table.remove(arg, 1)
            str = string.format(str, unpack(arg))
        end
        return str
    end,
}
setmetatable(System.Resources, { __index = System.Object })

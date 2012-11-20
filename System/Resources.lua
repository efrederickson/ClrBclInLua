System.Resources = {
    CurrentLanguage = "en-US",
    
    GetString = function(...)
        local arg = { ... }
        if type(arg[1]) == "table" then
            table.remove(arg, 1)
        end
        return System.LocalizedMessages[System.Resources.CurrentLanguage][arg[1]]
    end,
}
setmetatable(System.Resources, { __index = System.Object })

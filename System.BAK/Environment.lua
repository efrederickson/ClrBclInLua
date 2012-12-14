System.Environment = {
    ClassName = "Environment",
    Namespace = "System",

    NewLine = "\r\n",

    new = function()
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    GetEnvironmentVariable = function(var)
        return os and os.getenv(var) or nil
    end,
}

setmetatable(System.Environment, { __index = System.__index })

if System.Platform == System.Platforms.Linux or System.Platform == System.Platforms.MacOS then
    System.Environment.NewLine = "\n"
end

if System.Platform == System.Platforms.Roblox then
    System.Environment.GetEnvironmentVariable = function() System.ThrowHelper.Throw(System.PlatformException:new()) end
end

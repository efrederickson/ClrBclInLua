-- Note: This is lacking, as Lua does not have this type of access to the Console.

System.Console = {
    ClassName = "Console",
    
    new = function(self, ...)
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    In = nil,
    Out = nil,
    Error = nil,
    
    Write = function(obj)
        obj = tostring(obj)
        if System.Console.Out then
            if System.Console.Out.write then
                System.Console.Out:write(obj)
                return
            end
        end
        if io and io.write then
            io.write(obj)
            return
        end
        print(obj)
    end,
    
    WriteLine = function(obj)
        obj = tostring(obj)
        local o2 = obj .. System.Environment.NewLine
        if System.Console.Out then
            if System.Console.Out.write then
                System.Console.Out:write(o2)
                return
            end
        end
        if io and io.write then
            io.write(o2)
            return
        end
        print(obj)
    end,
    
    CloseIn = function()
        if System.Console.In and System.Console.In.close then
            System.Console.In:close()
        end
    end,
    
    CloseOut = function()
        if System.Console.Out and System.Console.Out.close then
            System.Console.Out:close()
        end
    end,
    
    CloseError = function()
        if System.Console.Error and System.Console.Error.close then
            System.Console.Error:close()
        end
    end,
    
    OpenStandardError = function()
        System.Console.CloseError()
        System.Console.Error = nil
    end,
    
    OpenStandardOutput = function()
        System.Console.CloseOut()
        System.Console.Out = nil
    end,
    
    OpenStandardInput = function()
        System.Console.CloseIn()
        System.Console.In = nil
    end,
    
    Read = function(fmt)
        fmt = fmt or 1
        if System.Console.In and System.Console.In.read then
            return System.Console.In:read(1)
        end
        if io and io.read then
            return io.read(fmt)
        end
        System.ThrowHelper.Throw(System.ConsoleException:new(System.Resources.GetString'Console_NoInputStream'))
    end,
    
    ReadLine = function()
        local buff = ""
        if System.Console.In and System.Console.In.read then
            return System.Console.In:read"*l"
        end
        if io and io.read then
            return io.read"*l"
        end
        System.ThrowHelper.Throw(System.ConsoleException:new(System.Resources.GetString'Console_NoInputStream'))
    end,
}

setmetatable(System.Console, { __index = System.Object })

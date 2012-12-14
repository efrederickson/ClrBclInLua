System.IO.Path = {
	ClassName = "Path",
	Namespace = "System.IO",
    
    DirectorySeparatorChar = '\\',
    AltDirectorySeparatorChar = '/',
    InvalidFileNameChars = {
	'"',	'<',	'>',	'|',	'\0',	
    System.Char.FromUnicode'\\u0001',	System.Char.FromUnicode'\\u0002',	
    System.Char.FromUnicode'\\u0003',	System.Char.FromUnicode'\\u0004',	
    System.Char.FromUnicode'\\u0005',	    System.Char.FromUnicode'\\u0006',	
    '\a',	'\b',	'\t',	'\n',	'\v',	'\f',	'\r',	
    System.Char.FromUnicode'\\u000e',	System.Char.FromUnicode'\\u000f',	
    System.Char.FromUnicode'\\u0010',    System.Char.FromUnicode'\\u0011',	
    System.Char.FromUnicode'\\u0012',	System.Char.FromUnicode'\\u0013',	
    System.Char.FromUnicode'\\u0014',	System.Char.FromUnicode'\\u0015',	
    System.Char.FromUnicode'\\u0016',	System.Char.FromUnicode'\\u0017',	
    System.Char.FromUnicode'\\u0018',	System.Char.FromUnicode'\\u0019',	
    System.Char.FromUnicode'\\u001a',	System.Char.FromUnicode'\\u001b',	
    System.Char.FromUnicode'\\u001c',	System.Char.FromUnicode'\\u001d',	
    System.Char.FromUnicode'\\u001e',	System.Char.FromUnicode'\\u001f',	
    ':',	'*',	'?',	'\\',	'/' },
    
    InvalidPathChars = {
	'"',	'<',	'>',	'|',	'\0',
	System.Char.FromUnicode'\\u0001',	System.Char.FromUnicode'\\u0002',
	System.Char.FromUnicode'\\u0003',	System.Char.FromUnicode'\\u0004',
	System.Char.FromUnicode'\\u0005',	System.Char.FromUnicode'\\u0006',
	'\a',	'\b',	'\t',	'\n',	'\v',	'\f',	'\r',
	System.Char.FromUnicode'\\u000e',	System.Char.FromUnicode'\\u000f',
	System.Char.FromUnicode'\\u0010',	System.Char.FromUnicode'\\u0011',
	System.Char.FromUnicode'\\u0012',	System.Char.FromUnicode'\\u0013',
	System.Char.FromUnicode'\\u0014',	System.Char.FromUnicode'\\u0015',
	System.Char.FromUnicode'\\u0016',	System.Char.FromUnicode'\\u0017',
	System.Char.FromUnicode'\\u0018',	System.Char.FromUnicode'\\u0019',
	System.Char.FromUnicode'\\u001a',	System.Char.FromUnicode'\\u001b',
	System.Char.FromUnicode'\\u001c',	System.Char.FromUnicode'\\u001d',
	System.Char.FromUnicode'\\u001e',    System.Char.FromUnicode'\\u001f'
},
    MAX_DIRECTORY_PATH = 248,
    MAX_PATH = 260,
    MaxDirectoryLength = 255,
    MaxLongPath = 32000,
    MaxPath = 260,
    PathSeparator = ';',
    Prefix = '\\\\?\\',
    RealInvalidPathChars = {
	'"',	'<',	'>',	'|',	'\0',
	System.Char.FromUnicode'\\u0001',	System.Char.FromUnicode'\\u0002',
	System.Char.FromUnicode'\\u0003',	System.Char.FromUnicode'\\u0004',
	System.Char.FromUnicode'\\u0005',	System.Char.FromUnicode'\\u0006',
	'\a',	'\b',	'\t',	'\n',	'\v',	'\f',	'\r',
	System.Char.FromUnicode'\\u000e',	System.Char.FromUnicode'\\u000f',
	System.Char.FromUnicode'\\u0010',	System.Char.FromUnicode'\\u0011',
	System.Char.FromUnicode'\\u0012',	System.Char.FromUnicode'\\u0013',
	System.Char.FromUnicode'\\u0014',	System.Char.FromUnicode'\\u0015',
	System.Char.FromUnicode'\\u0016',	System.Char.FromUnicode'\\u0017',
	System.Char.FromUnicode'\\u0018',	System.Char.FromUnicode'\\u0019',
	System.Char.FromUnicode'\\u001a',	System.Char.FromUnicode'\\u001b',
	System.Char.FromUnicode'\\u001c',	System.Char.FromUnicode'\\u001d',
	System.Char.FromUnicode'\\u001e',	System.Char.FromUnicode'\\u001f'
},

    Base32Chars = {	'a',	'b',	'c',	'd',	'e',	'f',	'g',	'h',	
    'i',	'j',	'k',	'l',	'm',	'n',	'o',	'p',	'q',	'r',
	's',	't',	'u',	'v',	'w',	'x',	'y',	'z',	'0',	'1',
	'2',	'3',	'4',	'5' },
    
    TrimEndChars = { '\t', '\n', '\v', '\f', '\r', ' ', System.Char.FromUnicode'\\u0085', System.Char.FromUnicode'\\u00A0' },
    VolumeSeparatorChar = ':',
    
	new = function()
        System.ThrowHelper.Throw(System.Exception:new(System.Resources.GetString'Class_CannotCreateStaticClass'))
    end,
    
    AddLongPathPrefix = function(str)
        str = System.String.ToNativeString(str)
        if System.StringHelper.StartsWith(str, System.IO.Path.Prefix) then return str end
        return System.IO.Path.Prefix .. str
    end,
    
    ChangeExtension = function(path, ext)
        if path then
            System.IO.Path.CheckInvalidPathChars(path, false)
            local text = path
            local n = path:len()
            while n > 0 do
                local c = path:sub(n, n)
                if c == '.' then
                    text = path:sub(1, n - 1)
                    break
                elseif c == System.IO.Path.DirectorySeparatorChar or c == System.IO.Path.AltDirectorySeparatorChar or c == System.IO.Path.VolumeSeparatorChar then
                    break
                end
                n = n - 1
            end
            if ext and path:len() ~= 0 then
                if ext:len() == 0 or ext:sub(1, 1) ~= "." then
                    text = text .. "."
                end
                text = text .. ext
            end
            return text
        end
        return nil
    end,
    
    CheckInvalidPathChars = function(path, additional)
        additional = additional or false
        if not path then System.ThrowHelper.Throw(System.ArgumentNullException:new("path")) end
        if System.IO.Path.HasIllegalCharacters(path, additional) then
            System.ThrowHelper.Throw(System.ArgumentException:new(System.Resources.GetString'Path_InvalidPath'))
        end
    end,
    
    Combine = function(...)
        local arg = { ... }
        for k, v in pairs(arg) do 
            if not v then System.ThrowHelper.Throw(System.ArgumentNullException:new()) end 
            System.IO.Path.CheckInvalidPathChars(v)
        end
        
        local ret =  arg[#arg]
        for i = #arg - 1, 1, -1 do
            ret = System.IO.Path.CombineNoChecks(ret, arg[i])
        end
        return ret
    end,
    
    CombineNoChecks = function(a, b)
        if a:len() == 0 then return b end
        if b:len() == 0 then return a end
        if System.IO.Path.IsPathRooted(b) then return b end
        local c = a:sub(-1, -1)
        if c ~= System.IO.Path.DirectorySeparatorChar and c ~= System.IO.Path.AltDirectorySeparatorChar and c ~= System.IO.Path.VolumeSeparatorChar then
            return path1 .. System.IO.Path.DirectorySeparatorChar .. path2
        end
        return path1 .. path2
    end,
    
    GetDirectoryName = function(path)
        if path then
            System.IO.Path.CheckInvalidPathChars(path, false);
            path = System.IO.Path.NormalizePath(path, false);
            local rootLength = System.IO.Path.GetRootLength(path)
            local num = path:len()
            if num > rootLength then
                num = path:len()
                if num == rootLength then
                    return nil
                end
                while num > rootLength and 
                path:sub(num, num) ~= System.IO.Path.DirectorySeparatorChar and
                path:sub(num, num) ~= System.IO.Path.AltDirectorySeparatorChar do
                    num = num - 1
                end
                return path:sub(1, num - 1)
            end
        end
        return nil
    end,
    
    GetExtension = function(path)
        if not path then return nil end
        System.IO.Path.CheckInvalidPathChars(path, false)
        local length = path:len()
        while length > 0 do
            local c = path:sub(length, length)
            if c == '.' then
                if length ~= path:len() then
                    return path:sub(length + 1)
                end
                return ""
            elseif c == System.IO.Path.DirectorySeparatorChar or c == System.IO.Path.AltDirectorySeparatorChar or c == System.IO.Path.VolumeSeparatorChar then
                return ""
            end
            length = length - 1
        end
        return ""
    end,
    
    GetFileName = function(path)
        if not path then return nil end
        System.IO.Path.CheckInvalidPathChars(path, false)
        local length = path:len()
        while length > 0 do
            local c = path:sub(length, length)
            if c == System.IO.Path.DirectorySeparatorChar or c == System.IO.Path.AltDirectorySeparatorChar or c == System.IO.Path.VolumeSeparatorChar then
                return path:sub(length + 1)
            end
            length = length - 1
        end
        return ""
    end,
    
    GetFileNameWithoutExtension = function(path)
        path = System.IO.Path.GetFileName(path)
        if not path then return nil end
        local str = System.String:new(path)
        local len = str:LastIndexOf('.')
        if len == -1 then return str:ToString() end
        return str:Substring(1, len - 1)
    end,
    
    HasIllegalCharacters = function(str, additional)
        for i = 1, str:len() do
            local num = string.byte(str:sub(i, i))
            if num == 34 or num == 60 or num == 62 or num == 124 or num < 32 then
                return true
            end
            if additional and (num == 63 or num == 42) then
                return true
            end
        end
        return false
    end,
}

setmetatable(System.IO.Path, { __index = System.__index })

System = { }

function System.GetStandardMetatable(obj)
    local t = { }
    for k, v in pairs(getmetatable(obj or System.Object)) do
        t[k] = v
    end
    t.__obj = obj or System.Object
    t.__index = System.__index
    return t
end

System.__index = function(t, k)
    local o = getmetatable(t).__obj --or System.Object
	if not o then
		if t ~= System.Object then
			o = System.Object
		end
	end
	local obj = o and o[k] or nil
	if obj then return obj end
    for k_, interface in pairs(
	--rawget(t, 'Implements')
	t.Implements
	or { }) do
        if interface and interface[k] and not obj then
            return interface[k]
        end
    end

    return obj -- this will only happen if obj is nil
end

require 'System.LocalizedMessages'
require 'System.Resources'
require 'System.Platform'

require 'System.Object'
require 'System.Delegate'
require 'System.Interface'

require 'System.IConvertible'

require 'System.Type'
require 'System.Exception'
require 'System.ArgumentException'
require 'System.Environment'
require 'System.ThrowHelper'
require 'System.StringHelper'
require 'System.String'
require 'System.Char'
require 'System.Action'
require 'System.Func'
require 'System.Byte'
require 'System.Console'
require 'System.ConsoleException'
require 'System.Math'
require 'System.MidpointRounding'
require 'System.Double'
require 'System.Complex'
require 'System.InternalBit'
require 'System.Bit'
require 'System.Convert'
require 'System.DBNull'
require 'System.PlatformException'
require 'System.ArgumentNullException'

require 'System.Text'
require 'System.Runtime'
require 'System.Globalization'
require 'System.EmbeddedResources'
require 'System.IO'

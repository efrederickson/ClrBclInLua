System = { }

function System.GetStandardMetatable(obj)
    local t = { }
    for k, v in pairs(getmetatable(obj or System.Object)) do
        t[k] = v
    end
    t.__index = obj or System.Object
    return t
end

require 'System.LocalizedMessages'
require 'System.Resources'
require 'System.Object'
require 'System.Delegate'

require 'System.Type'
require 'System.Exception'
require 'System.ArgumentException'
require 'System.Environment'
require 'System.Interface'
require 'System.Platform'
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

require 'System.Text'
require 'System.Runtime'
require 'System.Globalization'
require 'System.EmbeddedResources'

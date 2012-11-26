System.Globalization = System.Globalization or { }

System.Globalization.CultureInfo = {
    ClassName = "CultureInfo",
    Namespace = "System.Globalization",
    Implements = { System.ICloneable, System.IFormatProvider },
    
    new = function(self, culture, useUserOverride)
        local mt = System.GetStandardMetatable()
        mt.__index = self
        local cultureId = 127
        local cultureData
        if type(culture) == "string" then
            cultureData = System.Globalization.CultureData.GetCultureData(culture, useUserOverride)
            if not cultureData then
                System.ThrowHelper.Throw(System.Globalization.CultureNotFoundException:new(culture, System.Resources.GetString'Argument_CultureNotSupported'))
            end
            return setmetatable({
                CultureData = cultureData,
                CultureId = cultureId,
                name = cultureData.CultureName,
            }, mt)
        elseif type(culture) == "number" then
            
        end
    end,
}

setmetatable(System.Globalization.CultureInfo, { __index = System.Object })

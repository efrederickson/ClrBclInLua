local file = io.open("charinfo.nlp", "rb")
if not file then
    error'Cannot open charinfo.nlp for reading'
end

local source = [[
-- Notice: charinfo.nlp file was taken from the mscorlib embedded resources using ILSpy
System._charinfo_nlp = ']]
local raw = file:read'*a'
local patched = ""
for i = 1, raw:len() do
    patched = patched .. "\\" .. string.byte(raw:sub(i, i))
end

source = source .. patched
source = source .. "'"
file:close()
file = io.open("charinfo.lua", "wb")
file:write(source)
file:close()

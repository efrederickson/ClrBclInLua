package.path = "./?/init.lua;" .. package.path

if not bit then
    bit = require"luanumber-bit"
end
require"System"

--print("Loaded System")

function use(...)
    local nss = { ... }
    local env = getfenv(2)
    for k, ns in pairs(nss) do
        for k, v in pairs(ns) do
            env[k] = v
        end
    end
end

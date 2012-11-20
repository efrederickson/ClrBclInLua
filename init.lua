package.path = "./?/init.lua;" .. package.path

require"System"

--print("Loaded System")

function using(...)
    local nss = { ... }
    local env = getfenv(2)
    for k, ns in pairs(nss) do
        for k, v in pairs(ns) do
            env[k] = v
        end
    end
end

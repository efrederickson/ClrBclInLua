package.path = "./?/init.lua;" .. package.path

require"System"

--print("Loaded System")

function using(ns)
    local env = getfenv(2)
    for k, v in pairs(ns) do
        env[k] = v
    end
end

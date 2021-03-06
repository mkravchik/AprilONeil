package.path = package.path .. ";./lua/rules/?.lua"

local system_cpu_usage = {}
local system_ram_usage = {}
local system_ram_usage_req = require ('system_ram_usage_rule')
system_ram_usage.pre_run = pre_run
system_ram_usage.run = run

local system_cpu_usage_req = require ('system_cpu_usage_rule')
system_cpu_usage.pre_run = pre_run
system_cpu_usage.run = run



print("[Lua] [system_ram_and_cpu_usage] required...")

-- function pre_run()
--     print("[Lua] [system_ram_and_cpu_usage] pre-running...")
--     return system_cpu_usage.pre_run and system_ram_usage.pre_run
-- end

function run()
    system_ram_usage.run()
    system_cpu_usage.run()
end

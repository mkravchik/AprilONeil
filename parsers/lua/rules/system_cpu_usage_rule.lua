package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [system_cpu_usage] running...")
-- function pre_run()
--     print("[Lua] [system_cpu_and_ram_usage] pre-running...")
--     --check {'/proc/stat'}
--     return true
-- end

default_max_cpu_diff = 0.0001 -- in percentages

default_temp_file_name = 'temp_proc_stat_cpu_diff_data'

function run(max_cpu_diff, temp_file_name)
    if max_cpu_diff == nil then
        max_cpu_diff = max_cpu_diff
    end
    if temp_file_name == nil then
        temp_file_name = default_temp_file_name
    end
    print('[Lua] [system_cpu_usage] getting new cpu data...')
    local cpu_parsed_data = cyberlib.temp.get_data('/proc/stat', 'open')
    local new_cpu_data = cpu_parsed_data['cpu']
    local diff = 100 * (tonumber(new_cpu_data[1]) + tonumber(new_cpu_data[3])) / (tonumber(new_cpu_data[1]) + tonumber(new_cpu_data[3]) + tonumber(new_cpu_data[4]))
    local table_to_save = {}
    table_to_save.diff = tostring(diff)

    print('[Lua] [system_cpu_usage] loading old data')
    local old_data = cyberlib.temp.read_global_variable_from_file(temp_file_name)
    if old_data == nil then
        print("[Lua] [system_cpu_usage] [action] old_data not found, can't compare to old value...")
        cyberlib.temp.set_data(temp_file_name, table_to_save)
        return
    end
    cyberlib.temp.set_data(temp_file_name, table_to_save)
    local old_diff = tonumber(old_data['diff'])


    if math.abs(diff - old_diff) > max_cpu_diff then
        print('[Lua] [system_cpu_usage] [action] more than ' .. max_cpu_diff .. ' diff in cpu!, ' .. (diff - old_diff) .. ' diff found!')
    else
        print("[Lua] [system_cpu_usage] [action] less than " .. max_cpu_diff .. ' diff in cpu!, ' .. (diff - old_diff) .. ' diff found..')
    end
end

run()
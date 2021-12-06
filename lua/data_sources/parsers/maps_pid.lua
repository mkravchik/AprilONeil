print("[Lua] [maps_pid] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";../lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua

name = "maps"

function parse(pid)
    pid = "self"
    print("[Lua] [maps_pid] parse("..name..")...")
    local parsed_data = cyberlib.parse_lines_to_lists(name, pid)
    print("[Lua] [maps_pid] parsed "..parsed_data)
    return parsed_data
end

local json = require "json"
local file = io.open("debug.json",'w')
local debuginfo=json.encode(peripheral.getNames())
if file then
    file:write(debuginfo)
    file:close()
end
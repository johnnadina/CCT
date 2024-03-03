local json = require "json"
local scanLib= require "scanLib"

-- begin starting to write code
local inputChests = {"right"}

local storageData=scanLib.scan(inputChests)
local chestData=json.encode(storageData)

local file,err = io.open("storage_database.json",'w')
if file then
    file:write(chestData)
    file:close()
else
        print("error:", err)
end
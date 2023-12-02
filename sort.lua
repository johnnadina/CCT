local json = require "json"
local sortLib= require "sortLib"

io.input("storage_database.json")
local file=io.read("*all")

local inputChests = {"minecraft:barrel_0"}
local outputChests = json.decode(file)

while true do
    sortLib.sort(inputChests,outputChests)
end
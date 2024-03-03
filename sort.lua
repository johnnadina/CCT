local json = require "json"
local sortLib= require "sortLib"

io.input("storage_database.json")
local file=io.read("*all")

local inputChests = {"right"}
local outputChests = json.decode(file)
local overflow = "quark:variant_chest_136"
while true do
   sortLib.sort(inputChests,outputChests,overflow)
end


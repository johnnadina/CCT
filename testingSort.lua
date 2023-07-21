--no i will NOT learn to use git branches, ill make testing files foreverrr!!!!/s
json = require "json"




--creates the tables
inbox = {
    peripheral.wrap("minecraft:barrel_4"),
    peripheral.wrap("quark:variant_chest_9")
}
outbox = {}
storage_table = {
    ["quark:variant_chest_0"] = {"stone","cobblestone","diorite","andesite","granite","deepslate","shale","sturdy_stone"},
    ["quark:variant_chest_1"] = {"spruce_log","birch_log","oak_log",""},
    ["quark:variant_chest_3"] = {"bone_meal","gunpowder","arrow","leather","ink_sac","spider_eye","phantom_membrane","bone_block","string","ghast_tear"},
    ["quark:variant_chest_5"] = {
        "diamond","diamond_block",
        "iron_ingot","iron_block","iron_nugget",
        "gold_ingot","gold_block","gold_nugget",
        "emerald","emerald_block",
        "redstone","redstone_block",
        "copper_ingot","copper_block",
        "lapis_lazuli","lapis_block",
        "quartz",
        "flint"},
    ["quark:variant_chest_8"] = {"dirt","grass_block","gravel"},
    ["quark:variant_chest_11"] = {"carrot","beetroot","glow_berries","cooked_chicken","melon_slice","potato","wheat"},
    ["quark:variant_chest_12"] = {"bamboo","sugar_cane"},
    ["quark:variant_chest_14"] = {"glowstone","glowstone_dust","netherrack","soul_sand","soul_soil","crimson_nylium","warped_nylium","nether_wart_blocks"},
    ["quark:variant_chest_17"] = {"glass","glass_pane","pipe","encased_pipe"},

    ["quark:variant_chest_10"] = {"feather","wheat_seeds","beetroot_seeds","poisonous_potato"}

}
trash = peripheral.wrap("quark:variant_chest_10")


--json bs fuckery commences here


local database_path = "database.txt"
local database, err = io.open(database_path, "w")
local storage_jason = json.encode(storage_table)

-- Check if there was an error opening the file
if not database then
    print("Error opening the file:", err)
else -- If not, write to the json file
    print("Writing database")
    database:write(storage_jason)
    database:close()
    database = nil
    print("Database wrote!")

end

--Extract from json file:

-- Open the file in read mode ("r" mode)
local database, err = io.open(database_path, "r")
if not database then
    print("Error opening the file:", err)
else
    -- Read the content from the file
    print("Reading database")
    local storage_retrieved = database:read("*a")
    database:close()
    local storage = json.decode(storage_retrieved)
    print("Database read!")

end

-- function that checks if a value exists in a table. why this isnt a default function perplexes me
local function isIn (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end 


-- removes the prefix on item names (for example, takes "minecraft:item" and returns "item")
function rmpfx(name)
    return string.match(name,":(.*)")
end

-- converts the item names in readable ones (for example, takes "minecraft:useful_item" and returns "Useful Item")
function displayName(name)
    local dingus = string.match(name,":(.*)")
    local dingus2 = string.gsub(dingus,"_"," ")
    return (dingus2:gsub("^%l", string.upper))
end

--variables for the transfer log
transferLog = {}
transLogNumbers = {}
monitor = peripheral.wrap("top")

-- this function basically collects and prints the items transfered. It doesn't do any sorting, at all, all it does is take the name of the item processed and the amount, and uses that info to update the display/counter thing
function transLog(name,number)
    if isIn(transferLog,name) then
        for i,v in pairs(transferLog) do
            if v == name then
                transferLog[#transferLog+1] = name
                transLogNumbers[#transLogNumbers+1] = transLogNumbers[i]+number
                table.remove(transferLog,i)
                table.remove(transLogNumbers,i)
            end
        end
    else
        transferLog[#transferLog+1] = name
        transLogNumbers[#transLogNumbers+1] = number
        if #transferLog > 10 then
            table.remove(transferLog,1)
            table.remove(transLogNumbers,1)
        end
    end
    monitor.clear()
    monitor.setCursorPos(1,1)
    for i,v in pairs(transferLog) do
        monitor.setCursorPos(1,i)
        monitor.write(displayName(v).." x"..transLogNumbers[i])
    end
end


-- this is the actual sorting. as you can see its very rudimentary
while true do
    for i, inv in pairs(inbox) do
        for slot, item in pairs(inv.list()) do
            for chest, pattern in pairs(storage) do
                if isIn(pattern, rmpfx(item.name)) then
                    if inv.pushItems(chest,slot) == 0 then
                        inv.pushItems(peripheral.getName(trash),slot)
                    else
                        transLog(item.name,item.count)
                    end
                end
            end
        end
    end
end
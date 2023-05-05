
inbox = {
    peripheral.wrap("minecraft:barrel_4"),
    peripheral.wrap("quark:variant_chest_9")
}
outbox = {}
storage = {
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
    ["quark:variant_chest_11"] = {"carrot","beetroot","glow_berries","cooked_chicken"},
    ["quark:variant_chest_12"] = {"bamboo","sugar_cane"},
    ["quark:variant_chest_14"] = {"glowstone","glowstone_dust","netherrack","soul_sand","soul_soil","crimson_nylium","warped_nylium","nether_wart_blocks"},
    ["quark:variant_chest_17"] = {"glass","glass_pane","pipe","encased_pipe"}

}
trash = peripheral.wrap("quark:variant_chest_10")
-- make a function here that loads all the switchboard values into the storage box, basically


local function isIn (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end 
--why the hell is this one not a default lua function?

function rmpfx(name)
    return string.match(name,":(.*)")
end

function displayName(name)
    local dingus = string.match(name,":(.*)")
    local dingus2 = string.gsub(dingus,"_"," ")
    return (dingus2:gsub("^%l", string.upper))
end
transferLog = {}
transLogNumbers = {}
monitor = peripheral.wrap("top")
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



while true do
    for i, inv in pairs(inbox) do
        for slot, item in pairs(inv.list()) do
            for chest, pattern in pairs(storage) do
                if isIn(pattern, rmpfx(item.name)) then
                    transLog(item.name,item.count)
                    if inv.pushItems(chest,slot) < 0 then
                        inv.pushItems(trash.getName,slot)
                    end
                end
            end
        end
    end
end
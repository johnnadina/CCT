
inbox = {
    peripheral.wrap("quark:crate_2")
    peripheral.wrap("quark:variant_chest_9")
}
outbox = {}
storage = {
    ["quark:variant_chest_1"] = {"spruce_log","birch_log","oak_log",""}
}
--trash = peripheral.wrap("minecraft:chest_")
-- make a function here that loads all the switchboard values into the storage box, basically


function fetchPattern()
end

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



for i, inv in pairs(inbox) do
    for slot, item in pairs(inv.list()) do
        print(item.name)
        for chest, pattern in pairs(storage) do
            for i,v in pairs(pattern) do
                print(v)
            end
            if isIn(pattern, rmpfx(item.name)) then
                inv.pushItems(chest,slot)
                print("pushing!")
                print(chest)
            end
        end
    end
end

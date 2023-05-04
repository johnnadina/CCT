
inbox = {
    peripheral.wrap("quark:crate_0")
}
outbox = {}
storage = {
    [peripheral.wrap("quark:variant_chest_1")] = {"spruce_log","birch_log"}
}
trash = peripheral.wrap("minecraft:chest_")
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



for i, inv in ipairs(inbox) do
    for slot, item in pairs(inv.list()) do
        for chest, pattern in pairs(storage) do
            if isIn(pattern, rmpfx(item.name)) then
                if inv.pushItems(chest.getName,slot) < 1 then
                    inv.pushItems(trash.getName,slot)
                end
            end
        end
    end
end
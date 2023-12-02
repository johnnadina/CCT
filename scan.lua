--why the hell is this one not a default lua function?
local function isIn (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end 


-- This will be the hardcoded list of input chests
inputChest = {"minecraft:barrel_0"}


-- Scans all connected inventories, and returns a list
-- Every entry in the list consists of 
--    a "name" index, holding the name of the inv as a string
--    and a "items" index, holding a list of all item names in that inventory
function scan(inputchests)
    local chestlist = {}
    for i,v in ipairs(peripheral.getNames()) do
        if select(2,peripheral.getType(v)) == 'inventory' and isIn(inputchests,v) == false then
            local chest = peripheral.wrap(v)
            local itemlist = {}
            for slot, item in pairs(chest.list()) do
                if isIn(itemlist,item.name) == false then
                    table.insert(itemlist,item.name)
                end
            end
            local indexedChest = {}
            indexedChest.name = v
            indexedChest.items = itemlist
            table.insert(chestlist,indexedChest)
        end
    end
    return chestlist
end

inbox = {
    peripheral.wrap("minecraft:barrel_4"),
    peripheral.wrap("quark:variant_chest_9")
}
outbox = {}
storage = {
    ["quark:variant_chest_1"] = {"spruce_log","birch_log","oak_log",""},
    ["quark:variant_chest_11"] = {"carrot","beetroot","glow_berries","cooked_chicken"},
    ["quark:variant_chest_12"] = {"bamboo","sugar_cane"}

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
        table.remove(transferLog,1)
        table.remove(transLogNumbers,1)
    end
    for i,v in pairs(transferLog) do
        monitor.clear()
        monitor.setCursorPos(5,5)
        monitor.write(v.." x"..transLogNumbers[i])
        monitor.setCursorPos(monitor.getCursorPos()[1], monitor.getCursorPos()[2]-5)
    end
end


function rmpfx(name)
    return string.match(name,":(.*)")
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
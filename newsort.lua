--why the hell is this one not a default lua function?
local function isIn (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end 


-- The entire following code block is purely for the display
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


-- this is the actual sorting. as you can see its very rudimentary
function sort(input,output)
    for i, inv in pairs(input) do
        currentinv = peripheral.wrap(inv)
        for slot, item in pairs(currentinv.list()) do
            for ii, chest in pairs(output) do
                if isIn(chest.items, item.name) then
                    if currentinv.pushItems(chest.name,slot) == 0 then
                        -- inv.pushItems(peripheral.getName(trash),slot)
                        print("whoops, nowhere to push")
                    else
                        print("pooshed")
                        transLog(item.name,item.count)
                    end
                end
            end
        end
    end
end

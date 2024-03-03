local sortLib = {}

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
local function displayName(name)
    local dingus = string.match(name,":(.*)")
    local dingus2 = string.gsub(dingus,"_"," ")
    return (dingus2:gsub("^%l", string.upper))
end
local transferLog = {}
local transLogNumbers = {}
local monitor = peripheral.wrap("top")
local function transLog(name,number)
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
function sortLib.sort(input,output,overflow)
    for i, inv in pairs(input) do
        print(inv)
        local currentinv = peripheral.wrap(inv)
        print(tostring(currentinv))
        for slot, item in pairs(currentinv.list()) do
            for ii, chest in pairs(output) do
                if isIn(chest.items, item.name) then
                    --THIS LINE IN PARTICULAR IS BROKEN IT KEEPS INSISTING THAT THE CHESTS DONT EXIST
                   if currentinv.pushItems(chest.name,slot) == 0 then
                        currentinv.pushItems(overflow,slot)
                        print(item.name .. "sent to overflow")
                    else
                        transLog(item.name,item.count)
                    end
                end
            end
        end
    end
end

return sortLib
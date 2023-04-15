
rowbreak = true
rowParity = false
leniency = 3
dio = {"minecraft:wheat","minecraft:beetroots","minecraft:carrots","minecraft:potatoes"}
rel = require "rel"

local function isIn (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end 
--why the hell is this one not a default lua function?


function harvest()
    local _,block = turtle.inspectDown()
    turtle.select(math.random(1,4))
    if block["name"] == "minecraft:wheat" then
        print(block["state"]["age"])
        if block["state"]["age"] ~= 7 then
            return
        end
    elseif block["name"] == "minecraft:beetroots" then
        if block["state"]["age"] ~= 3 then
            return
        end
    elseif block["name"] == "minecraft:potatoes" then
        if block["state"]["age"] ~= 7 then
            return
        end
    elseif block["name"] == "minecraft:carrots" then
        if block["state"]["age"] ~= 7 then
            return
        end
    end
    turtle.digDown()
    turtle.placeDown()
end
function blockCheck()
    local _,block = turtle.inspectDown()
    if isIn(dio,block["name"]) then
        return true
    else
        return false
    end
end
function turnParityLeft()
    if rowParity then
        rel.turnLeft()
    else
        rel.turnRight()
    end
end
function turnParityRight()
    if rowParity then
        rel.turnRight()
    else
        rel.turnLeft()
    end
end
function nextRow ()
    turnParityRight()
    if turtle.detect() then
        print("next row obstructed, backtracking")
        local EPSearch = leniency
        while EPSearch > 0 do
            turnParityRight()
            rel.forward()
            turnParityLeft()
            if not turtle.detect() then
                EPSearch = 0
                findRowEnd()
            end
        end
        print("no entry found, terminating")
        return
    else
        findRowEnd()
    end
end
function findRowEnd()
    rel.forward()
    -- HERE IT DECIDES IF IT NEEDS TO SEARCH FOR THE START OF THE ROW OR END OF IT
    if blockCheck() then
        turnParityLeft()
        rowParity = not rowParity
        local NRSearch = leniency
        print("reseting NRS")
        -- LOOP FOR IF IT HASNT FOUND THE END OF THE ROW
        while NRSearch > 0 do
            if turtle.detect() then
                print("block in front, ending search")
                NRSearch = 0
                rel.turnLeft()
                rel.turnLeft()
            else
                rel.forward()
                if blockCheck() == false then
                    print("end of row, ending search")
                    NRSearch = 0
                    rel.turnLeft()
                    rel.turnLeft()
                    rel.forward()
                end
            end
            NRSearch = NRSearch-1
        end
        if blockCheck() then
            print("found row in front of me")
            harvestRow()
        end
    else
        turnParityRight()
        rowParity = not rowParity
        local NRSearch = leniency
        print("reseting NRS")
        while NRSearch > 1 do
            rel.forward()
            NRSearch = NRSearch-1
            if blockCheck() then
                print("found row beginning behind entry point")
                harvestRow()
            end
        end
    end
end
function harvestRow ()
    rowbreak = true
    while rowbreak do
        harvest()
        if blockCheck() then

            if turtle.detect() then
                print("no more space in front, LOOKING FOR NEXT ROW")
                rowbreak = false
            else
                rel.forward()
            end
        else
            print("row done, LOOKING FOR NEXT ROW")
            rowbreak = false
        end
    end
    nextRow()
end
harvestRow()
rel.returnHome()
    

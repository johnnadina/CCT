
fieldSize = {18,18} 
cropList = {"minecraft:wheat","minecraft:beetroots","minecraft:carrots","minecraft:potatoes"}

--- forward first, to the side second
startDirection = "right"
if startDirection == "right" then
    rowParity = true
else
    rowParity = false
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

function blockCheck(blockList)
    local _,block = turtle.inspectDown()
    if isIn(blockList,block["name"]) then
        return true
    else
        return false
    end
end

function turnParityLeft()
    if rowParity then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
end
function turnParityRight()
    if rowParity then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end
end
function harvest()
    local _,block = turtle.inspectDown()
    if isIn(cropList,block["name"]) then
        if block["name"] == "minecraft:wheat" then
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
        turtle.select(math.random(1,4))
        turtle.placeDown()
    end
end

function sortie()
    turtle.forward()
    for i=1, fieldSize[2] do
        harvest()
        for i=1, fieldSize[1]-1 do
            turtle.forward()
            harvest()
        end
        -- turning around action:
        if i<fieldSize[2] then
            turnParityRight()
            turtle.forward()
            turnParityRight()
            rowParity = not rowParity
        else
            turnParityLeft()
            for i=1, fieldSize[2]-1 do
                turtle.forward()
            end
            turtle.turnLeft()
            if rowParity then
                for i=1, fieldSize[1] do
                    turtle.forward()
                end
            else
                turtle.forward()
            end
        end
    end
end
function deposit()
    for i=5, 16 do
        turtle.select(i)
        turtle.drop()
    end
    print("Ended run with fuel percent of ".. 100*turtle.getFuelLevel()/turtle.getFuelLimit())
    if turtle.getFuelLevel() < (turtle.getFuelLimit()*0.9) then
        turtle.select(16)
        while turtle.getFuelLevel() < (turtle.getFuelLimit()) do
            turtle.suckDown(10)
            if turtle.refuel(10)
                print("Refuelled to ".. 100*turtle.getFuelLevel()/turtle.getFuelLimit())
            else
                print("No more fuel!")
                break
            end
        end
    end
    turtle.turnLeft()
    turtle.turnLeft()
end

if blockCheck({"minecraft:barrel"}) then
    while true do
        sortie()
        deposit()
        sleep(1200)
    end
else
    print("ERROR: Where fuck am I??")
end

function cut()
    height = 0
    turtle.dig()
    turtle.forward()
    local inTree = true
    while inTree do
        turtle.dig()
        turtle.digUp()
        turtle.up()
        height = height+1
        if turtle.detectUp() == false then
            inTree = false
        end
    end
    for i=1,3 do
        turtle.dig()
        turtle.digUp()
        turtle.up()
        height = height+1
    end
    refuelFull()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
    for i=1,height do
        turtle.digDown()
        turtle.down()
        turtle.dig()
    end
    turtle.back()
    for i=1,16 do
        turtle.select(1)
        turtle.dropDown()
    end
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
    turtle.select(1)
    turtle.suckDown(4)
    turtle.forward()
    turtle.turnLeft()
    turtle.place()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
    turtle.place()
    turtle.turnRight()
    turtle.back()
    turtle.place()
    turtle.back()
    turtle.place()
end

function refuelFull()
    if turtle.getFuelLevel() < (turtle.getFuelLimit()*0.9) then
        turtle.select(1)
        while turtle.getFuelLevel() < (turtle.getFuelLimit()) do
            turtle.suckDown(10)
            if turtle.refuel(10) then
                print("Refuelled to ".. 100*turtle.getFuelLevel()/turtle.getFuelLimit())
            else
                print("No more fuel!")
                break
            end
        end
    end
end

function blockCheck(blockList)
    local _,block = turtle.inspectDown()
    if blockList == block["name"] then
        return true
    else
        return false
    end
end

if blockCheck("minecraft:barrel") then
    while true do
        local _,block = turtle.inspect()
        if block["name"] == "minecraft:spruce_log" then
            cut()
        sleep(30)
    end
else
    print("ERROR: Where fuck am I??")
end
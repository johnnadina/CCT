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
    turtle.select(1)
    turtle.refuel()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
    for i=1,height do
        turtle.digDown()
        turtle.down()
        turtle.dig()
    end
end
cut()


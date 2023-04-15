local rel = {}

position = {}
position["x"] = 0
position["z"] = 0
position["y"] = 0
rotation = "forward"

-- x positive is forward, z positive is to the right

local function turnLeft()
    turtle.turnLeft()
    if rotation == "forward" then
        rotation = "left"
    elseif rotation =="left" then
        rotation = "backward"
    elseif rotation == "backward" then
        rotation = "right"
    elseif rotation == "right" then
        rotation = "forward"
    end
end

local function turnRight()
    turtle.turnRight()
    if rotation == "forward" then
        rotation = "right"
    elseif rotation =="right" then
        rotation = "backward"
    elseif rotation == "backward" then
        rotation = "left"
    elseif rotation == "left" then
        rotation = "forward"
    end
end


local function face(direction)
    if direction == "origin" then
        if math.abs(position["x"]) >= math.abs(position["z"]) then
            if position["x"]<0 then
                direction = "forward"
            else
                direction = "backward"
            end
        else
            if position["z"]<0 then
                direction = "right"
            else
                direction = "left"
            end
        end
    end
    while rotation ~= direction do
        turnLeft()
        print(rotation)
    end
end


local function forward()
    if turtle.forward() then
        print("x"..position["x"].." z"..position["z"])
        if rotation=="forward" then
            position["x"]=position["x"]+1
        elseif rotation=="backward" then
            position["x"]=position["x"]-1
        elseif rotation=="right" then
            position["z"]=position["z"]+1
        elseif rotation=="left" then
            position["z"]=position["z"]-1
        end
        return true
    else
        return false
    end
end
local function up()
    if turtle.up() then
        position["y"]=position["y"]+1
    end
end
local function down()
    if turtle.down() then
        position["y"]=position["y"]-1
    end
end
local function returnHome()
    print("coming home!")
    while position["x"]+position["y"]~=0 do
        if math.abs(position["x"]) >= math.abs(position["z"]) then
            priority = "x"
            otherone = "z"
        else
            priority = "z"
            otherone = "x"
        end
        while position["y"] ~= 0 do
            if position["y"]>0 then
                down()
            else
                up()
            end
        end
        face("origin")
        while position[priority] ~= 0 do
            print(priority..position[priority])
            if forward() == false then
                while turtle.detect() do
                    turnRight()
                    forward()
                    turnLeft()
                end
            end
        end
        face("origin")
        while position[otherone] ~= 0 do
            print(otherone..position[otherone])
            if forward() == false then
                while turtle.detect() do
                    turnRight()
                    forward()
                    turnLeft()
                end
            end
        end
    end
    face("forward")
end

rel.turnLeft = turnLeft
rel.turnRight = turnRight
rel.face = face
rel.forward = forward
rel.up = up
rel.down = down
rel.returnHome = returnHome
return rel
                        

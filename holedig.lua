for i = 8,1,-1 
do 
    for i = 4,1,-1 
    do 
        for i = 15,1,-1 
        do 
            turtle.down()	
            turtle.digDown()
        end
		turtle.forward()
		turtle.dig()
        for i = 15,1,-1 
        do 
            turtle.up()
            turtle.digUp()	
        end
    end
		turtle.turnRight()
		turtle.forward()
		turtle.turnRight()
		turtle.forward()
		turtle.forward()
		turtle.forward()
		turtle.forward()
		turtle.turnLeft()
		turtle.turnLeft()
end
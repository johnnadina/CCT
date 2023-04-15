for i = arg[1]/2,1,-1 
do 
    for j = arg[3]/2,1,-1 
    do 
        for k = arg[2],1,-1 
        do 
			turtle.digDown()
            turtle.down()	
        end
		
		turtle.dig()
		turtle.forward()
		
        for k = arg[2],1,-1 
        do 
			turtle.digUp()
            turtle.up()
        end
		
		if ( j%2 == 0 ) then
			turtle.turnLeft()
			turtle.dig()
			turtle.forward()
			turtle.turnLeft()
		else
			turtle.turnRight()
			turtle.dig()
			turtle.forward()
			turtle.turnRight()
		end
    end
end
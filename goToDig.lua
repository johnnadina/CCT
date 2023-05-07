i, j , k = 0 , 0 , 1

while(true) 
do
	k=1
	if (i < arg[1]/1) --dividing by 1 to quickly convert to a number
	then
		i=i+1
		turtle.dig()
		turtle.digUp()
		turtle.forward()
	end
	
	--k=k%16+1
	--turtle.select(k)
	turtle.digDown()
	while (not turtle.placeDown())
	do
		k=turtle.getSelectedSlot()+1
		turtle.select(k)
		if k>16 then
			return
		end
	end
	
	
	if (j < arg[2]/1)
	then
		j=j+1
		turtle.turnRight()
		turtle.dig()
		turtle.digUp()
		turtle.forward()
		turtle.turnLeft()
	end
	
	turtle.digDown()
	while (not turtle.placeDown())
	do
		k=turtle.getSelectedSlot()+1
		turtle.select(k)
		if k>16 then
			return
		end
	end
	
end
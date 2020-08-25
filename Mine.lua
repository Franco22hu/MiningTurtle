---- Introduction
-- This is a Lua script written for the Mining Turtle, which is included in a mod ComputerCraft (www.computercraft.info) created for Minecraft (minecraft.net).
-- The script makes the turtle mine shafts in parallel lines until it runs out of fuel.
-- Uploaded to (and explained): github.com/Franco22hu/MiningTurtle
-- Version: 2.4


---- Constants
local SHAFT_LENGTH = 20 -- The length of a shaft mined
local GO_LEFT = false -- Create shafts to the left or right
local START_SHAFT = 0 -- Which shaft to begin from
local BLOCKS_BETWEEN = 2 -- How far apart shafts should be


---- Functions
local function tryGoForward()
	while not turtle.forward() do
		if turtle.detect() then
			turtle.dig()
		elseif turtle.attack() then
		else sleep( 0.5 )
		end
	end
end
local function tryGoUp()
	while not turtle.up() do
		if turtle.detectUp() then
			turtle.digUp()
		elseif turtle.attackUp() then
		else sleep( 0.5 )
		end
	end
end
local function tryGoDown()
	while not turtle.down() do
		if turtle.detectDown() then
			turtle.digDown()
		elseif turtle.attackDown() then
		else sleep( 0.5 )
		end
	end
end
local function tryDigUp()
	while turtle.detectUp() do
		turtle.digUp()
	end
end
local function unload()
	for n=1,16 do
		local nCount = turtle.getItemCount(n)
		if nCount > 0 then
			turtle.select(n)
			turtle.dropDown()
		end
	end
	turtle.select(1)
end


---- Main
local shaftsMined = START_SHAFT

while true do
	
	-- Calculate fuel needed
	local fuelNeeded = (shaftsMined * (BLOCKS_BETWEEN+1) * 2) + (SHAFT_LENGTH * 4) + (2 * 6)
	--   (getting to the shaft) + (through the shaft) + (ups and downs)
	
	-- Refuel
	print("Refueling. Fuel needed: ", fuelNeeded)
	if turtle.getFuelLevel() < fuelNeeded then
		turtle.turnLeft()
		turtle.turnLeft()
		while turtle.getFuelLevel() < fuelNeeded do
			if not turtle.suck(1) then
				print("Not enough fuel detected! Stopping")
				turtle.turnRight()
				turtle.turnRight()
				return
			end
			turtle.refuel()
		end
		turtle.turnRight()
		turtle.turnRight()
	end

	-- Go to shaft
	print("Starting next shaft: ", shaftsMined)
	if shaftsMined > 0 then
		if GO_LEFT then turtle.turnLeft()
		else turtle.turnRight() end

		for n=1,(shaftsMined*(BLOCKS_BETWEEN+1)) do
			tryGoForward()
			tryDigUp()
		end

		if GO_LEFT then turtle.turnRight()
		else turtle.turnLeft() end
	end

	-- Dig shaft
	for n=1,2 do
		
		for n=1,SHAFT_LENGTH do
			tryGoForward()
			tryDigUp()
		end

		turtle.turnLeft()
		turtle.turnLeft()

		tryGoUp()
		tryGoUp()

		for n=1,SHAFT_LENGTH do
			tryDigUp()
			tryGoForward()
		end

		turtle.turnRight()
		turtle.turnRight()
		
		if n ~= 2 then
			tryGoUp()
			tryGoUp()
		end
	end

	for n=1,6 do
		tryGoDown()
	end

	-- Go to chests
	if shaftsMined > 0 then
		if GO_LEFT then turtle.turnRight()
		else turtle.turnLeft() end
		
		for n=1,(shaftsMined*(BLOCKS_BETWEEN+1)) do
			tryGoForward()
		end
		
		if GO_LEFT then turtle.turnLeft()
		else turtle.turnRight() end
	end

	-- Finish
	print("Finished. Unloading")
	unload()
	shaftsMined = shaftsMined + 1

	-- Repeat
end
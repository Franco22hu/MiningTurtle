
## Introduction

This Lua script is written for the Mining Turtle, which is included in a mod ComputerCraft (www.computercraft.info) created for Minecraft (minecraft.net).
It makes the turtle mine shafts in parallel lines until it runs out of fuel.

## Setting up

1. Place chests then turtle in shown pattern
	![Pattern](pattern.png?raw=true)
1. Place fuel (coal) in chest behind
1. Enter turtle (right click)
1. Type 'pastebin get cg0jVba7 mine'
	(if outdated, upload script again to pastebin.com and replace reference code)
1. Type 'edit mine'
1. Navigate to constants
1. Set shaft length, direction, starting position and distance
1. Press ctrl, save then exit
1. Type 'mine'


## Process

First the turtle calculates the fuel level needed for digging the next shaft. If there isn't enough, it wont start.
The turtle will relocate to the beginning shaft START_SHAFT.
It will try to dig a SHAFT_LENGTH blocks long and 8 blocks tall shaft (height cannot be changed), 
then return to the chests and unloads its inventory to the chest below.
If there is enough fuel, it repeats the process, starting another shaft to the side depending on GO_LEFT,
and leaving BLOCKS_BETWEEN blocks between shafts.


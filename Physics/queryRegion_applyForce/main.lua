-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local physics = require("physics")


physics.start()
physics.setGravity(0,0.88)

local background = display.newImageRect("images/background.png",480,320)
background.x=display.contentWidth/2
background.y=display.contentHeight/2


local function checkRegion()
	local touching=physics.queryRegion(0,display.contentHeight-30,display.contentWidth,display.contentWidth)

	if touching then
		physics.setGravity(0,-0.88)
	end
end
local function createBox()
	local box = display.newImageRect("images/box.png",60,60)
	box.x=display.contentWidth/2
	box.y=0
	box:rotate(math.random(0,360))

	physics.addBody( box, { density=1.0, friction=0.5, bounce=0.2 } )
	box.bodyType = "dynamic"
	box.name="box"

	box:addEventListener("tap",function() box:applyForce(math.random(-10,10),-math.random(200,1000),box.x,box.y) end)
end

createBox()

Runtime:addEventListener("enterFrame",checkRegion)
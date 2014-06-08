-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local physics = require("physics")

physics.start()

local background = display.newImageRect("images/background.png",480,320)
background.x=display.contentWidth/2
background.y=display.contentHeight/2

local floor = display.newRect(0,display.contentHeight-10,display.contentWidth,20)
floor.x=display.contentWidth/2
floor:setFillColor(0,200,0)

physics.addBody( floor, "static", { friction=0.3 } )
	
local function createBox(event)
	local box = display.newImageRect("images/box.png",60,60)
	box.x=event.x
	box.y=0
	box:rotate(math.random(0,360))

	physics.addBody( box, { density=15.0, friction=0.5, bounce=0.2 } )
	box.bodyType = "dynamic"

	transition.to(box,{delay=10000, onComplete=function() box:removeSelf() end})
end

Runtime:addEventListener("tap",createBox)

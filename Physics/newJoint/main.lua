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
floor.name="floor"

physics.addBody( floor, "static", { friction=0.3 } )



local myJoints = {}

local function createBox(event)

local i = 1 
	local link = {}
	for j = 1,17 do
		link[j] = display.newImageRect("images/box.png",50,50)
		link[j].x = 121 + (i*34)
		link[j].y = 55 + (j*10)
		physics.addBody( link[j], { density=2.0, friction=0, bounce=0 } )
		
		-- Create joints between links
		if (j > 1) then
			prevLink = link[j-1] -- each link is joined with the one above it
		else
			prevLink = link[j]
		end
		myJoints[#myJoints + 1] = physics.newJoint( "pivot", prevLink, link[j], 121 + (i*34), (j) )


end
end

Runtime:addEventListener("tap",createBox)

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

local platform = display.newImageRect("images/platform.png",50,50)
platform.x=0
platform.y=80
platform.name="platformOne"

physics.addBody(platform,"kinematic")
platform:setLinearVelocity(30,0)
	
platform = display.newImageRect("images/platform.png",50,50)
platform.x=display.contentWidth
platform.y=200
platform.name="platformTwo"

physics.addBody(platform,"kinematic")
platform:setLinearVelocity(-30,0)

local function createBox(event)
	local box = display.newImageRect("images/box.png",60,60)
	box.x=event.x
	box.y=0
	box:rotate(math.random(0,360))

	physics.addBody( box, { density=1.0, friction=0.5, bounce=0.2 } )
	box.bodyType = "dynamic"
	box.name="box"

	transition.to(box,{delay=10000, onComplete=function() box:removeSelf() end})
end

local function preCollisionListener(event)
	print(event.name .. " " .. event.x .. " " .. event.y)
end

local function collisionListener(event)
	print(event.name .. " " .. event.object1.name .. " " .. event.object2.name)
end

local function postCollisionListener(event)
	print(event.name .. " Force:" .. event.force )
end
Runtime:addEventListener("tap",createBox)
Runtime:addEventListener("preCollision",preCollisionListener)
Runtime:addEventListener("collision",collisionListener)
Runtime:addEventListener("postCollision",postCollisionListener)
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

local spinner = widget.newSpinner{
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	width=100,
	height=100,
    deltaAngle = 20
}

spinner:start()
timer.performWithDelay(2000,function() spinner:stop() end,1)
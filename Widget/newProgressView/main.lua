-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require ("widget")

local progress = widget.newProgressView{
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	width=200,
	isAnimated=true,
	fillYOffset = -1,
	fillXOffset = -1
}

function updateProgress()
	print(progress:getProgress()) 
	progress:setProgress(progress:getProgress()+0.25)
end
progress:setProgress(0)

updateProgress()
timer.performWithDelay(1000,updateProgress,4)
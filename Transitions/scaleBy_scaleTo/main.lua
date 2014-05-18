-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local square = display.newRect(200,200,40,40)
transition.scaleBy(square, {time=2000,xScale=1,yScale=1} )

transition.scaleTo(square,{time=2000,delay=2000,xScale=1,yScale=1})



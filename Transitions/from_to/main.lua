-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local square = display.newRect(200,200,40,40)
local trans = transition.to(square, {time=20000,xScale=2,yScale=2,rotation=-360} )

transition.to(1,{delay=1000,onComplete=function() transition.pause(trans) end})

transition.to(1,{delay=3000,onComplete=function() transition.resume(trans) end})


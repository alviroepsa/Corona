-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local square = display.newRect(200,200,40,40)
square.alpha=0
transition.fadeIn(square, {time=2000} )

transition.fadeOut(square,{time=2000,delay=2000})
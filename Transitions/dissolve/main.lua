-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local square = display.newRect(200,200,40,40)
local circle = display.newCircle(200,200,20)
circle.alpha=0
transition.dissolve(square, circle, 2000,0 )

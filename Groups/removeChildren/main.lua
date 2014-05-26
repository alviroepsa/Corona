-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local line = display.newLine(100,100,70,70)
line:setStrokeColor(1,0,0)
local rect = display.newRect(100,100,40,40)
rect:setFillColor(0,1,0)
local circle = display.newCircle(100,100,30)
circle:setFillColor(0,0,1)

local group = display.newGroup()

group:insert(rect)
group:insert(circle)
group:insert(line)

-- Remove
group:remove(rect)
group:remove(circle)
group:remove(line)







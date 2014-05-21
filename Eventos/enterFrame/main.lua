-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local count = 0
local text = display.newText(count,display.contentWidth/2,display.contentHeight/2,nil,50)

local function listener(event)
	count=count+1
	text.text=count
end

Runtime:addEventListener("enterFrame",listener)

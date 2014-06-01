-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require ("widget")

local background

local function tapBarListener(event)

	print(event.target.label.text)
	if event.target.label.text=="Tab1" then
		background:setFillColor(1,0,0)
	elseif event.target.label.text=="Tab2" then
		background:setFillColor(0,1,0)
	else
		background:setFillColor(0,0,1)
	end
end


local tabButtons = {
    {
        label = "Tab1",
        selected = true,
        size=20,
        onPress = tapBarListener
    },
    {
       	label = "Tab2",
        size=20,
        onPress = tapBarListener
    },
    {
        label = "Tab3",
        size=20,
        onPress = tapBarListener
    }
}

background = display.newRect(display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
background:setFillColor(1,0,0)

widget.newTabBar{
	
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	buttons = tabButtons
}
	

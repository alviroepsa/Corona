-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

local value = display.newText("0",0,0,nil,40)

local function sliderValues(event)
	value.text=event.value
end

local slider = widget.newSlider{
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	value=0,
	height=100,
	orientation="vertical",
	listener = sliderValues
}

value.x = slider.x
value.y = slider.y+80
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

local value = 0
local valueStepper = display.newText(value,0,0,nil,40)

local function updateValue(event)
	 if ( "increment" == event.phase ) then
        value = value + 1
    elseif ( "decrement" == event.phase ) then
        value = value - 1
    end
	valueStepper.text=value
end

local stepper = widget.newStepper{
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	minimumValue= -10,
	maximumValue= 10,
	changeSpeedAtIncrement=5,
	onPress = updateValue
}

valueStepper.x = stepper.x
valueStepper.y = stepper.y+60
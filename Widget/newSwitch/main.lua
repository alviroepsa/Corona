-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

local onOffWidget = widget.newSwitch{
	x=display.contentWidth/2,
	y=50,
	style="onOff",
	onPress= function(event) print(event.target.isOn) end
}




local radioGroup = display.newGroup()
local radioButtonWidgetOne = widget.newSwitch{
	id="radioOne",
    x=130,
	y=150,
	style="radio",
	onPress= function(event) print(event.target.id) end
}
local firstTextRadio = display.newText("Radio One",radioButtonWidgetOne.x-60,radioButtonWidgetOne.y,nil,15)
local radioButtonWidgetTwo = widget.newSwitch{
	id="radioTwo",
	x=display.contentWidth/2+100,
	y=150,
	style="radio",
	onPress= function(event) print(event.target.id) end
}
local secondTextRadio = display.newText("Radio Two",radioButtonWidgetTwo.x-60,radioButtonWidgetTwo.y,nil,15)

radioGroup:insert(radioButtonWidgetOne)
radioGroup:insert(radioButtonWidgetTwo)




local checkButtonWidgetOne = widget.newSwitch{
	id="checkOne",
    x=140,
	y=300,
	style="checkbox",
	onPress= function(event) print(event.target.id) end
}
local firstTextRadio = display.newText("CheckBox One",checkButtonWidgetOne.x-70,checkButtonWidgetOne.y,nil,15)
local checkButtonWidgetTwo = widget.newSwitch{
	id="checkTwo",
	x=display.contentWidth/2+130,
	y=300,
	style="checkbox",
	onPress= function(event) print(event.target.id) end
}
local secondTextRadio = display.newText("CheckBox Two",checkButtonWidgetTwo.x-70,checkButtonWidgetTwo.y,nil,15)

-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local segmentControl 
local textSelected

local function itemSelected(event)
	textSelected.text=event.target.segmentLabel
end

segmentControl = widget.newSegmentedControl{
	
	segments={"Easy","Normal","Hard","Extreme"},
	segmentWidth =70,
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	onPress = itemSelected
}
textSelected =display.newText(segmentControl.segmentLabel,segmentControl.x,segmentControl.y+60,nil,40)

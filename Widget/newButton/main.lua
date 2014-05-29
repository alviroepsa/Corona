-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

-- only text btn
--[[widget.newButton{
	
	label="Press button",
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	onPress = function() print("pressed") end,
	onRelease = function() print("release") end,
	labelColor= {default={1,0,0}, over={0,1,0}},
	fontSize=20,
	emboss=true
}]]
local options =
{

    width = 64,
    height = 64,
    numFrames = 28,

    sheetContentWidth = 512,  
    sheetContentHeight = 256 
}

local imageSheet = graphics.newImageSheet( "images/ui_sheet.png", options )

widget.newButton{
	x=display.contentWidth/2,
	y=display.contentHeight/2,
	onPress = function() print("pressed") end,
	onRelease = function() print("release") end,
	labelColor= {default={1,0,0}, over={0,1,0}},
	fontSize=20,
	emboss=true,
	sheet=imageSheet,
	defaultFrame=11,
	overFrame=13
}

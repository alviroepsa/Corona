-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

local group = display.newGroup()
local background = display.newImage("images/background.jpg",display.contentWidth/2,display.contentHeight/2)
local backgroundTwo = display.newImage("images/background.jpg",display.contentWidth/2+background.width,display.contentHeight/2)
local textOne = display.newText(1,background.x,display.contentHeight/2,nil,40)
local textTwo = display.newText(2,backgroundTwo.x,display.contentHeight/2,nil,40)

group:insert(background)
group:insert(backgroundTwo)
group:insert(textOne)
group:insert(textTwo)

local scroll = widget.newScrollView{
	top = 0,
	left = 0,
	width=display.contentWidth+80,
	height=display.contentHeight-display.screenOriginY-2,
	scrollWidth=320,
	hideBackground=true,
    backgroundColor={0,0,0,255},
	left = display.screenOriginX*2,
	verticalScrollDisabled=true

	}

scroll:insert(group)

-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local options =
{

    width = 64,
    height = 64,
    numFrames = 28,

    sheetContentWidth = 512,  
    sheetContentHeight = 256 
}

local imageSheet = graphics.newImageSheet( "images/ui_sheet.png", options )
local img = display.newImage(imageSheet,8,display.contentWidth/4,display.contentHeight/2)
img = display.newImage(imageSheet,18,display.contentWidth/2,display.contentHeight/2)
img = display.newImage(imageSheet,27,display.contentWidth - display.contentWidth/4,display.contentHeight/2)

-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


local options =
{
    width = 56, height = 80,
    numFrames = 27,
    sheetContentWidth = 168, sheetContentHeight = 720 
}

local imageSheet = graphics.newImageSheet( "images/fox.png", options )
local image = display.newImage(imageSheet,1,display.contentWidth/2,display.contentHeight/2)

local function tapListener(event)
	print(event.name .. " " .. event.phase)
	print(event.target.width .. "x" .. event.target.height)
end

image:addEventListener("touch",tapListener)

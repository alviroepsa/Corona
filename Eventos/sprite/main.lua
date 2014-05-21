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
	local sheet = graphics.newImageSheet( "sprites/fox.png", options )

	local sequence ={ 
						{ name="start", start=1, count=3,time=1000, loopCount=2 }
	 				}

	local image = display.newSprite( sheet, sequence )
	image.x = display.contentWidth/2
	image.y = display.contentHeight/2
	image:play()

local function tapListener(event)
	print(event.name .. " " .. event.phase)
	print(event.target.sequence)
end

image:addEventListener("sprite",tapListener)

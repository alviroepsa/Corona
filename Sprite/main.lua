-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local options = 
		{
			width = 32, height = 32,
			numFrames = 8,
			sheetContentWidth = 256, sheetContentHeight = 32,
		}

	local sheet = graphics.newImageSheet( "sprites/gema_azul.png", options )

	local sequence ={ 
						{ name="start", start=1, count=8,time=1000, loopDirection="bounce" }
	 				}

	local sprite = display.newSprite( sheet, sequence )
	sprite.x=display.contentWidth/2
	sprite.y=display.contentWidth/2
	sprite:setSequence("start")
	sprite:play()
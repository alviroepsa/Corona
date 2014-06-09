-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local backgroundMusic = audio.loadStream( "sounds/music.mp3" )

local function listener()
	print("FINISH SOUND")
end

local options = {	
    channel=1,
    loops=-1,
    duration=3000,
    fadein=1000,
    onComplete=listener
}

local backgroundMusicChannel = audio.play( backgroundMusic,options)

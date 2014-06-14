-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local backgroundMusic = audio.loadStream( "sounds/music.mp3" )

local options = {	
    channel=1,
    duration=30000,
}

local backgroundMusicChannel = audio.play( backgroundMusic,options)

-- REWIND
--timer.performWithDelay(3000,function() audio.rewind(backgroundMusicChannel) end)

-- STOP
--timer.performWithDelay(3000,function() audio.stop(backgroundMusicChannel) end)

-- PAUSE AND RESUME
--timer.performWithDelay(3000,function() audio.pause(backgroundMusicChannel) end)
--timer.performWithDelay(4000,function() audio.resume(backgroundMusicChannel) end)

-- DISPOSE
timer.performWithDelay(3000,function() audio.stop(backgroundMusicChannel) 
							audio.dispose(backgroundMusicChannel)
							end)


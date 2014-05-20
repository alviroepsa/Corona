-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local count = 6

local function timerListener(event)
	print(event.source.params.index)
end

local time = timer.performWithDelay(1000,timerListener,6)
time.params = {index = count}
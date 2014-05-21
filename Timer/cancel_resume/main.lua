-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local count = 0

local function timerListener(event)
	print("EVENT LISTENER")
end

local time = timer.performWithDelay(1000,timerListener,6)
timer.pause(time)

local function pauseListener()
	count=count+1
	 print(count)
	 if (count == 8) then
		timer.resume(time)
	 end
end

timer.performWithDelay(1000,pauseListener,0)
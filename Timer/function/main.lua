-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local count = 0
local function timerListener()

	print(count)
	count=count+1
end

timer.performWithDelay(1000,timerListener,6)
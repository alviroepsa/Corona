-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local count = 0
local timerListener = {}
function timerListener:timer()

	print(count)
	count=count+1
end

timer.performWithDelay(1000,timerListener,6)
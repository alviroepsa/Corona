-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require("widget")

local days = {}
local month = {}
local year = {}

for i=1,31 do
	days[i]=i
end

month = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
for i=1,75 do
	year[i]=1925+i
end

local columnData = { 
	{
	    align="center",
	    width=100,
	    startIndex=1,
	   labels =  days
	},
	{
	    align="center",
	    width=100,
	    startIndex=1,
	   labels =  month
	},
	{
	    align="center",
	    width=100,
	    startIndex=1,
	   labels =  year
	}
}

widget.newPickerWheel{
	columns=columnData
}
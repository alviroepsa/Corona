-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local square = display.newRect(200,200,40,40)
transition.moveBy(square, {time=2000,x=-60,y=-90} )

transition.moveTo(square,{time=2000,delay=2000,x=300,y=300})


display.newText("position 1",140,110,nil,20)
display.newText("position 2",300,300,nil,20)
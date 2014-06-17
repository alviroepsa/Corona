-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local alert
local function onComplete( event )
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
            print("CLICK OK")
        elseif 2 == i then
          print("CLICK CANCEL")
       end
    end
end
alert = native.showAlert( "Error title", "ERROR, SOMETHING IS WRONG",{"OK","Cancel"}, onComplete )

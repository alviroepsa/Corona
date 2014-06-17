-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local textField

local function textListener( event )
    if ( event.phase == "editing" ) then
        print( event.text )

    end
end

textField = native.newTextField( 150, 150, 180, 30 )
textField.userInput="numeric"

textField:addEventListener( "userInput", textListener )

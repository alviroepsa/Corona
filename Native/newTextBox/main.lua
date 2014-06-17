-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local textBox

local function textListener( event )
    if ( event.phase == "editing" ) then
        print( event.text )
    end
end

textBox = native.newTextBox( 150, 150, 180, 80 )
textBox.isEditable=true
textBox:addEventListener( "userInput", textListener )

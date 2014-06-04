----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

---------------------------------------------------------------------------------



function scene:create( event )
	local sceneGroup = self.view

	display.newImage(sceneGroup,"images/background/space_bck.png",display.contentWidth/2, display.contentHeight/2)

	local bckMenu = display.newRoundedRect(sceneGroup,display.contentWidth/2,display.contentHeight/2,300,250,10)
	bckMenu.alpha = 0.4

    local startBtn = widget.newButton{
		x=bckMenu.x,
		y=bckMenu.y,
		onRelease = function() composer.gotoScene("configuration") end,
		labelColor= {default={0,0,0}, over={1,1,1}},
		label = "Jugar",
		fontSize=35,
		emboss=true,
	}

	sceneGroup:insert(startBtn)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
	
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then
	
	end	
end


function scene:destroy( event )
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
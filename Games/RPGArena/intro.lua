-----------------------
-- Alfredo Vilaplana --
-----------------------
-- 	   intro.lua     --
-----------------------

local composer = require( "composer" )
local scene = composer.newScene()
local tablero = require("clases.scenario")


local pressText

local function changeTextAlpha()

 	transition.to(pressText, {alpha=0, time=1000, onComplete=
			function()  transition.to(pressText, {alpha=1, time=1000}) end
 	  })

end



function scene:create( event )
	local sceneGroup = self.view
	tablero.dibujarEscenario(sceneGroup,sceneGroup,nil,nil,6)
     
	lifeGroup.alpha=0
    goldGroup.alpha=0

	local authorText = display.newEmbossedText(sceneGroup,"Alfredo Vilaplana 2014", display.contentWidth-150,display.contentHeight-30,nil,25)
	local color = 
		{
		    highlight = { r=0, g=0, b=0 },
		    shadow = { r=255, g=255, b=255 }
		}

		authorText:setEmbossColor(color)

	
	local titleText = display.newEmbossedText(sceneGroup,"RPG Arena", display.contentWidth/2,display.contentHeight/4,nil,100)
	local color = 
		{
		    highlight = { r=0, g=0, b=0 },
		    shadow = { r=255, g=255, b=255 }
		}

		titleText:setEmbossColor(color)

	pressText = display.newEmbossedText(sceneGroup,"Pulsa la pantalla para continuar", display.contentWidth/2,display.contentHeight/2+40,nil,30)
	local color = 
		{
		    highlight = { r=0, g=0, b=0 },
		    shadow = { r=255, g=255, b=255 }
		}

		titleText:setEmbossColor(color)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		changeTextAlpha()
		timer.performWithDelay(2500, changeTextAlpha,0)

		sceneGroup:addEventListener("tap",function()    composer.removeScene("intro") composer:gotoScene("selectPlayer") end)
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
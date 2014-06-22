local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	media.playSound( 'sounds/end_game.wav' )
	endGame=endGame+1
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

	local background = display.newImageRect(sceneGroup,"images/gameover.png",display.contentHeight,display.contentWidth)
	background.x=display.contentWidth/2
	background.y=display.contentHeight/2

	composer.skillLevel=0
	composer.savedPlayer=nil
	composer.gold=0
	composer.level=0
	endGame = 0
	initGame = 0
	level = 0
	spriteSelected = nil
	currentMap = 0


	composer.removeScene("gameOver")
	composer.gotoScene("intro")
	--sceneGroup:addEventListener("tap",function()    composer.removeScene("gameOver") composer.gotoScene("intro") end)
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
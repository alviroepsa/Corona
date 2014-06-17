----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local json = require ("json")
local scene = composer.newScene()

---------------------------------------------------------------------------------

local getScore
local bestScore
local gameOverText
local path = system.pathForFile( "score.txt", system.DocumentsDirectory )
local scoreGroup = display.newGroup()

local function showData()

	display.newText(scoreGroup,"Score: " .. getScore, gameOverText.x, gameOverText.y+60,nil,20)
	display.newText(scoreGroup,"Best Score: " .. bestScore, gameOverText.x,gameOverText.y+100,nil,20)

end

local function initAnimation()
	transition.to(gameOverText,{y=100,time=1000,onComplete = showData})
end

local function setSavedScore()
 
     	local data = {
	   		score = getScore
	    }
	    print(data.score)
   		local data = json.encode(data)
	    local file = io.open( path, "w" )
	   
	    file:write(data)
	    return
   
end

local function getSavedScore()

     
   local file = io.open( path, "r" )

   if file == nil then
   		setSavedScore()
   end

   local data = file:read("*a")
   bestScore = json.decode(data).score

   if bestScore<getScore then
   		bestScore = getScore
   		io.close(file)  
   		setSavedScore()
   else
	    io.close(file)
	end

end


function scene:create( event )
	local sceneGroup = self.view

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	getScore = event.params.score
	if phase == "will" then
		local background = display.newRect(sceneGroup,display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
		background:setFillColor(0)
		getSavedScore()
		gameOverText = display.newText(sceneGroup,"Game Over", display.contentWidth/2,display.contentHeight/2,nil,20)
		sceneGroup:insert(scoreGroup)
		initAnimation()

		sceneGroup:addEventListener("tap",function() composer.removeScene("gameover") composer.gotoScene("game") end)
	elseif phase == "did" then
	
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end


function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
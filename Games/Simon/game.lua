----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

---------------------------------------------------------------------------------

local redButton, yellowButton, blueButton, greenButton
local redButtonOverlay, yellowButtonOverlay, blueButtonOverlay, greenButtonOverlay
local combination = { math.random(1,4)}
local playerEnabled = false

local currentComputerCount = 1
local currentUserCount = 1


local timerClick

local computerClick

local sounds = {
	redSound = "sounds/red.mp3",
	greenSound = "sounds/green.mp3",
	blueSound = "sounds/blue.mp3",
	yellowSound = "sounds/yellow.mp3"
}


local function clearButton()

	redButtonOverlay.alpha=0
	greenButtonOverlay.alpha=0
	yellowButtonOverlay.alpha=0
	blueButtonOverlay.alpha=0

	redButton:setEnabled(false)
	greenButton:setEnabled(false)
	blueButton:setEnabled(false)
	yellowButton:setEnabled(false)

end

local function callGameOver()

	local options = {
		params={
			score = #combination-1
		}
	}
	composer.removeScene("game")
	composer.gotoScene("gameover",options)

end


local function playSound(event, type)

	if event~=nil then
		if playerEnabled == false then
			return
		end
		if event.target.id == "red" then
			if combination[currentUserCount]~=1 then callGameOver() return end
			audio.play(audio.loadStream("sounds/red.mp3"))

		elseif event.target.id == "yellow"  then
			if combination[currentUserCount]~=2 then callGameOver() return end
			audio.play(audio.loadStream("sounds/yellow.mp3"))
		elseif event.target.id == "green"  then
			if combination[currentUserCount]~=3 then callGameOver() return end
			audio.play(audio.loadStream("sounds/green.mp3"))
		else
			if combination[currentUserCount]~=4 then callGameOver() return end
			audio.play(audio.loadStream("sounds/blue.mp3"))
		end

		currentUserCount = currentUserCount+1
		if (currentUserCount == #combination) then
			clearButton()
			currentUserCount=1
			playerEnabled=false
			timer.performWithDelay(1000,computerClick,1)
		end
	else
		if  type=="red" then
			audio.play(audio.loadStream("sounds/red.mp3"))
		elseif type=="yellow" then
			audio.play(audio.loadStream("sounds/yellow.mp3"))
		elseif type=="green" then
			audio.play(audio.loadStream("sounds/green.mp3"))
		else
			audio.play(audio.loadStream("sounds/blue.mp3"))
		end
	end
end


function computerClick()
	if combination[currentComputerCount]==1 then
		playSound(nil,"red")
		redButtonOverlay.alpha=1
	elseif combination[currentComputerCount]==2 then
		playSound(nil,"yellow")
		yellowButtonOverlay.alpha=1
	elseif combination[currentComputerCount]==3 then
		playSound(nil,"green")
		greenButtonOverlay.alpha=1
	else
		playSound(nil,"blue")
		blueButtonOverlay.alpha=1
	end


	
	if (currentComputerCount < #combination) then
		timer.performWithDelay(400,clearButton,1)
		currentComputerCount = currentComputerCount+1
		timerClick = timer.performWithDelay(500, computerClick,1)
	else
		timer.performWithDelay(400,clearButton,1)
		timer.performWithDelay(500,function() 
			playerEnabled=true
			redButton:setEnabled(true)
			greenButton:setEnabled(true)
			blueButton:setEnabled(true)
			yellowButton:setEnabled(true)
			combination[#combination+1] = math.random(1,4)
			currentComputerCount=1 
		end,1)
		
	end
	
end


local function displayButtons(sceneGroup)

	redButton = widget.newButton{
		id = "red",
		x=display.contentWidth/2-50,
		y=display.contentHeight/2-50,
		defaultFile = "images/red.png",
		overFile = "images/red_over.png",
		onRelease = playSound,
		fontSize=20,
		emboss=true
	}

	redButton.yScale=0.4
	redButton.xScale=0.4
	redButtonOverlay = display.newImage("images/red_over.png")
	redButtonOverlay.x = redButton.x
	redButtonOverlay.y = redButton.y
	redButtonOverlay.xScale=0.4
	redButtonOverlay.yScale=0.4
	redButtonOverlay.alpha=0

	blueButton = widget.newButton{
		id = "blue",
		x=display.contentWidth/2-50,
		y=display.contentHeight/2+50,
		defaultFile = "images/blue.png",
		overFile = "images/blue_over.png",
		onRelease = playSound,
		fontSize=20,
		emboss=true
	}

	blueButton.yScale=0.4
	blueButton.xScale=0.4
	blueButtonOverlay = display.newImage("images/blue_over.png")
	blueButtonOverlay.x = blueButton.x
	blueButtonOverlay.y = blueButton.y
	blueButtonOverlay.xScale=0.4
	blueButtonOverlay.yScale=0.4
	blueButtonOverlay.alpha=0

	greenButton = widget.newButton{
		id = "green",
		x=display.contentWidth/2+50,
		y=display.contentHeight/2-50,
		defaultFile = "images/green.png",
		overFile = "images/green_over.png",
		onRelease = playSound,
		fontSize=20,
		emboss=true
	}

	greenButton.yScale=0.4
	greenButton.xScale=0.4
	greenButtonOverlay = display.newImage("images/green_over.png")
	greenButtonOverlay.x = greenButton.x
	greenButtonOverlay.y = greenButton.y
	greenButtonOverlay.xScale=0.4
	greenButtonOverlay.yScale=0.4
	greenButtonOverlay.alpha=0

	yellowButton = widget.newButton{
		id = "yellow",
		x=display.contentWidth/2+50,
		y=display.contentHeight/2+50,
		defaultFile = "images/yellow.png",
		overFile = "images/yellow_over.png",
		onRelease = playSound,
		fontSize=20,
		emboss=true
	}

	yellowButton.yScale=0.4
	yellowButton.xScale=0.4
	yellowButtonOverlay = display.newImage("images/yellow_over.png")
	yellowButtonOverlay.x = yellowButton.x
	yellowButtonOverlay.y = yellowButton.y
	yellowButtonOverlay.xScale=0.4
	yellowButtonOverlay.yScale=0.4
	yellowButtonOverlay.alpha=0

	sceneGroup:insert(redButton)
	sceneGroup:insert(redButtonOverlay)
	sceneGroup:insert(greenButton)
	sceneGroup:insert(greenButtonOverlay)
	sceneGroup:insert(blueButton)
	sceneGroup:insert(blueButtonOverlay)
	sceneGroup:insert(yellowButton)
	sceneGroup:insert(yellowButtonOverlay)

end

function scene:create( event )
	local sceneGroup = self.view

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		playerEnabled=true
		displayButtons(sceneGroup)
		computerClick()
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
	
	if timerClick~= nil then
		timer.cancel(timerClick)
	end
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
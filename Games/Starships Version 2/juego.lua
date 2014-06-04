----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------


local shipTimer
local countDownTimer

local destroyedShips = 0
local arrivedShips = 0

local maxShipsSaved = 3
local defaultTime = 60

local itemsGroup = display.newGroup()

local explosionOptions = {
	width = 62.5, height = 62.5,
	numFrames = 16,
	sheetContentWidth = 250, sheetContentHeight = 250,
}

local shipOptions = {
	width = 40, height = 32,
	numFrames = 20,
	sheetContentWidth = 160, sheetContentHeight = 160,
}

local explosionSheet = graphics.newImageSheet( "images/sprites/explosion.png", explosionOptions )
local shipSheet = graphics.newImageSheet( "images/sprites/ships.png", shipOptions )

local sequenceExplosion ={ 
					{ name="start", start=1, count=16,time=500, loopCount = 1 }
	}


local sequenceShip ={ 
					{ name="ship1", start=1, count=4,time=500, loopDirection="bounce" },
					{ name="ship2", start=5, count=4,time=500 },
				    { name="ship3", start=9, count=4,time=500 },
				    { name="ship4", start=13, count=4,time=500 },
					{ name="ship5", start=17, count=4,time=500 }
	}


local countDownText = display.newText(itemsGroup,defaultTime,display.contentWidth/2, 30,nil,20)

local function countDown()
	countDownText.text=countDownText.text-1

	if countDownText.text=="0" then
		timer.cancel(shipTimer)
		timer.cancel(countDownTimer)
		countDownText:removeSelf()
		countDownText=nil

		display.newText("Ships destroyed = " .. destroyedShips,display.contentWidth/2,display.contentHeight/2-20,nil,20)
		display.newText("Ships arrived to limit = ".. arrivedShips ,display.contentWidth/2,display.contentHeight/2+20,nil,20)
	end
end

local function destroyShip(event)

	local explosion =display.newSprite(itemsGroup,explosionSheet,sequenceExplosion)
	explosion.x = event.target.x
	explosion.y = event.target.y
	explosion:setSequence("start")
	explosion:play()
	explosion:addEventListener("sprite", function(event) if event.phase=="ended" then explosion:removeSelf()  end end)
	event.target.alpha=0

	destroyedShips = destroyedShips+1
	
end

local function savedShip(ship)

	if ship.alpha==1 then

		arrivedShips = arrivedShips+1
		if arrivedShips>maxShipsSaved then
			composer.removeScene("juego")
			composer.gotoScene("gameover")
		end
	end

	ship:removeSelf()
end


local function createShip()

	local ship = display.newSprite(itemsGroup,shipSheet,sequenceShip)
	ship.x = display.contentWidth - display.screenOriginY
	ship.y = math.random(40, display.contentHeight-40)

	local randomSequence = math.random(1,5)
	ship:setSequence("ship"..randomSequence)
	ship:play()
	ship:addEventListener("tap",destroyShip)
	ship.movement=transition.to(ship,{time=math.random(4000,10000), x=-100, onComplete=function() savedShip(ship) end})

end








function scene:create( event )
	local sceneGroup = self.view

	display.newImage(sceneGroup,"images/background/space_bck.png",display.contentWidth/2, display.contentHeight/2)

	maxShipsSaved = tonumber(event.params.shipsSave)
	defaultTime = tonumber(event.params.time)
	countDownText.text=defaultTime
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		shipTimer = timer.performWithDelay(750,createShip,0)

		countDownText:toFront()
		countDownTimer = timer.performWithDelay(1000,countDown,0)

		sceneGroup:insert(itemsGroup)

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
	
	timer.cancel(countDownTimer)
	timer.cancel(shipTimer)

	for i=sceneGroup.numChildren,1,-1 do

		transition.cancel(sceneGroup[i].movement)
		sceneGroup[i]:removeSelf()

	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
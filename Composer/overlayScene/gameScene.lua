----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)

local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
local shipTimer
local countDownTimer
local globalGroup = display.newGroup()

local destroyedShips = 0
local arrivedShips = 0

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


local countDownText = display.newText(60,display.contentWidth/2, 30,nil,20)

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

	local explosion =display.newSprite(explosionSheet,sequenceExplosion)
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
	end

	ship:removeSelf()
end


local function createShip()

	local ship = display.newSprite(globalGroup,shipSheet,sequenceShip)
	ship.x = display.contentWidth - display.screenOriginY
	ship.y = math.random(40, display.contentHeight-40)

	local randomSequence = math.random(1,5)
	ship:setSequence("ship"..randomSequence)
	ship:play()
	ship:addEventListener("tap",destroyShip)
	transition.to(ship,{time=math.random(4000,10000), x=-100, onComplete=function() savedShip(ship) end})

end

function scene:create( event )
	local sceneGroup = self.view

	display.newImage(globalGroup,"images/background/space_bck.png",display.contentWidth/2, display.contentHeight/2)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then
	shipTimer = timer.performWithDelay(750,createShip,0)

	countDownText:toFront()
	countDownTimer = timer.performWithDelay(1000,countDown,0)

	sceneGroup:insert(globalGroup)

	local options ={
	isModal = true,
	effect="fade",
	time=1000
}
	composer.showOverlay("menu",options)
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
	timer.cancel(shipTimer)
	timer.cancel(countDownTimer)
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
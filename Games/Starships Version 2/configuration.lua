----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

---------------------------------------------------------------------------------

local value=3
local valueStepper

local function updateValue(event)
	 if ( "increment" == event.phase ) then
        value = value + 1
    elseif ( "decrement" == event.phase ) then
        value = value - 1
    end
	valueStepper.text=value
end

local valueSlide
local function sliderValues(event)
	if event.value<30 or event.value>80 then return end
	valueSlide.text=event.value
end

local function openGameScene()

	local options = {
		params={
			time=valueSlide.text,
			shipsSave = valueStepper.text
		}
	}	

	composer.gotoScene("juego",options) 
end



local function initUI(sceneGroup)

display.newImage(sceneGroup,"images/background/space_bck.png",display.contentWidth/2, display.contentHeight/2)

	local bckMenu = display.newRoundedRect(sceneGroup,display.contentWidth/2,display.contentHeight/2,300,250,10)
	bckMenu.alpha = 0.4

	local stepper = widget.newStepper{
		x=display.contentWidth/2,
		y=bckMenu.y-75,
		initialValue=value,
		minimumValue= 0,
		maximumValue= 5,
		changeSpeedAtIncrement=5,
		onPress = updateValue
	}
	
	local maxEnemiesText = display.newText(sceneGroup,"Max enemigos salvados",stepper.x,stepper.y-30,nil,18)
	maxEnemiesText:setFillColor(0,0,0)
    valueStepper = display.newText(sceneGroup,value,stepper.x,stepper.y+30,nil,18)
	valueStepper:setFillColor(0,0,0)

	
	local slider = widget.newSlider{
		x=display.contentWidth/2,
		y=bckMenu.y+20,
		valueSlide=50,
		height=100,
		orientation="horizontal",
		listener = sliderValues
	}

	local timeText = display.newText(sceneGroup,"Tiempo total",slider.x,slider.y-30,nil,18)
	timeText:setFillColor(0,0,0)
    

    valueSlide = display.newText(sceneGroup,50,slider.x,slider.y+30,nil,18)
	valueSlide:setFillColor(0,0,0)

	 local startBtn = widget.newButton{
		x=valueSlide.x,
		y=valueSlide.y+45,
		onRelease = openGameScene,
		labelColor= {default={0,0,0}, over={1,1,1}},
		label = "Iniciar",
		fontSize=30,
		emboss=true,
	}

	sceneGroup:insert(stepper)
	sceneGroup:insert(maxEnemiesText)
	sceneGroup:insert(valueStepper)
	sceneGroup:insert(slider)
	sceneGroup:insert(startBtn)

end

function scene:create( event )
	local sceneGroup = self.view

	initUI(sceneGroup)
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
local composer = require( "composer" )
local scene = composer.newScene()
local tablero = require("clases.scenario")
local widget = require("widget")

local uiGroup = display.newGroup()

	local options = 
		{
			width = 32,
			height = 32,
			numFrames =8,
			sheetContentWidth = 256,
			sheetContentHeight = 32,
		}

local textDescription = {
	
 ["armor"]="Aumenta la defensa",
 ["bowAttack"]="Aumenta el daño del arco",
 ["swordAttack"]="Aumenta el daño del arma cuerpo a cuerpo",
 ["speed"]="Aumenta la velocidad de movimiento",
 ["life"]="Aumenta la vida maxima",
 ["arrowSpeed"]="Aumenta la velocidad de ataque del arco",
 ["swordSpeed"]="Aumenta la velocidad de ataque del arma cuerpo a cuerpo",
 ["swordBleed"]="Recuperas vida al matar un enemigo"


}


local coste = 25+(composer.skillLevel*25)

local sheet = graphics.newImageSheet( "images/items/skills.png", options )

local sequence ={ 
						{ name="armor", start=1, count=1 },
	 					{ name="bowAttack", start=2, count=1 },
	 					{ name="swordAttack", start=3, count=1 },
	 					{ name="speed", start=4, count=1 },
	 					{ name="life", start=5, count=1 },
	 					{ name="arrowSpeed", start=6, count=1 },
	 					{ name="swordSpeed", start=7, count=1 },
	 					{ name="swordBleed", start=8, count=1 }
	 				}


local function upgrade(type)

	if composer.gold>=coste then
		composer.gold=composer.gold-coste

		local interface = require("clases.ui")
		interface.updateGold()
		if type=="armor" then
			composer.savedPlayer.armor = composer.savedPlayer.armor+1
			armorValue.text=" + " .. composer.savedPlayer.armor
		elseif type=="bowAttack" then
			composer.savedPlayer.distanceAttackDamage = composer.savedPlayer.distanceAttackDamage+0.5
			bowAttackValue.text=" + " .. composer.savedPlayer.distanceAttackDamage
		elseif type=="swordAttack" then
			composer.savedPlayer.meleeAttackDamage = composer.savedPlayer.meleeAttackDamage+0.5
			swordAttackValue.text=" + " .. composer.savedPlayer.meleeAttackDamage
		elseif type=="speed" then
			composer.savedPlayer.speed = composer.savedPlayer.speed+0.5
			speedValue.text=" + " .. composer.savedPlayer.speed
		elseif type=="life" then
	   		composer.savedPlayer.life = composer.savedPlayer.life+10
			lifeValue.text=" + " .. composer.savedPlayer.life
		elseif type=="arrowSpeed" then
			composer.savedPlayer.distanceAttackDelay = composer.savedPlayer.distanceAttackDelay-10
			arrowSpeedValue.text=" + " .. composer.savedPlayer.distanceAttackDelay
		elseif type=="swordSpeed" then
			composer.savedPlayer.meleeAttackDelay = composer.savedPlayer.meleeAttackDelay-10
			swordSpeedValue.text=" + " .. composer.savedPlayer.meleeAttackDelay
		elseif type=="swordBleed" then
			composer.savedPlayer.bleed = composer.savedPlayer.bleed+1
			swordBleedValue.text=" + " .. composer.savedPlayer.bleed
		end


		composer.skillLevel=composer.skillLevel+1
		coste = 25+(composer.skillLevel*25)
		costeOro.text="Coste : " .. coste
		media.playSound( 'sounds/success.wav' )
		   		
	else
		costeOro:setFillColor(255,0,0)
		transition.to(costeOro,{delay=500, onComplete= function() costeOro:setFillColor(255) end})

	end

end

local function writeText()
     actualLength=actualLength+1
     textExplicacion.text=string.sub(frase,0,actualLength)
     textExplicacion.anchorX=0
     textExplicacion.anchorY=0
     textExplicacion.x= 20
     if actualLength==fraseLength then
         timer.cancel(timerText)
         actualLength=0

     end
end

local function setDescriptionText(string)

  	frase=textDescription[string]
    fraseLength=string.len(frase)
    actualLength=0

    if timerText ~= nil then
        timer.cancel(timerText)
    end
	timerText = timer.performWithDelay(20, writeText,0)

end


local function initUI(sceneGroup)

	tablero.dibujarEscenario(sceneGroup,sceneGroup,nil,nil,6)

	local textField = display.newRect(sceneGroup,0,display.contentHeight-100,display.contentWidth,150)
	textField.anchorX=0
	textField.anchorY=0
	textField.x=0
	textField.y=display.contentHeight-150
	textField:setFillColor(0)
	textField.alpha=0.3


    textExplicacion = display.newText(sceneGroup,"",textField.x+30,textField.y+30,nil,30)
	

    costeOro = display.newText(sceneGroup,"Coste : ".. coste, display.contentWidth/2, 100,nil,50)


 	

 	local armorGroup = display.newGroup()
	local bowAttackGroup = display.newGroup()
	local swordAttackGroup = display.newGroup()
	local speedGroup = display.newGroup()
	local lifeGroup = display.newGroup()
	local arrowSpeedGroup = display.newGroup()
	local swordSpeedGroup = display.newGroup()
	local swordBleedGroup = display.newGroup()


    local armorIcon = display.newSprite(armorGroup, sheet, sequence )
	armorIcon:setSequence("armor")
	armorIcon:scale(2,2)
	armorIcon.x=125
	armorIcon.y=175

    armorValue = display.newText(armorGroup," + " ..composer.player.armor,0,0, nil,30)
    armorValue.x = armorIcon.x + armorValue.contentWidth + 50
    armorValue.y = armorIcon.y

	local armorUpgrade = display.newImageRect(armorGroup,"images/items/skillBtn.png",50,50)
	armorUpgrade.x = armorIcon.x + 275
	armorUpgrade.y = armorIcon.y
	armorUpgrade:addEventListener("tap",function() upgrade("armor") end)
	
   
	local speedIcon = display.newSprite(speedGroup, sheet, sequence )
	speedIcon:setSequence("speed")
	speedIcon:scale(2,2)
	speedIcon.x=125
	speedIcon.y=250

	speedValue = display.newText(speedGroup," + " ..composer.player.speed,0,0, nil,30)
    speedValue.x = speedIcon.x + speedValue.contentWidth + 50
    speedValue.y = speedIcon.y

	local speedUpgrade = display.newImageRect(speedGroup,"images/items/skillBtn.png",50,50)
	speedUpgrade.x = armorIcon.x + 275
	speedUpgrade.y = speedIcon.y
	speedUpgrade:addEventListener("tap",function() upgrade("speed") end)
	

	local bowAttackIcon = display.newSprite(bowAttackGroup, sheet, sequence )
	bowAttackIcon:setSequence("bowAttack")
	bowAttackIcon:scale(2,2)
	bowAttackIcon.x=125
	bowAttackIcon.y=325

	bowAttackValue = display.newText(bowAttackGroup," + " ..composer.player.distanceAttackDamage,0,0, nil,30)
    bowAttackValue.x = bowAttackIcon.x + bowAttackValue.contentWidth + 50
    bowAttackValue.y = bowAttackIcon.y

	local bowAttackUpgrade = display.newImageRect(bowAttackGroup,"images/items/skillBtn.png",50,50)
	bowAttackUpgrade.x = bowAttackIcon.x + 275
	bowAttackUpgrade.y = bowAttackIcon.y
	bowAttackUpgrade:addEventListener("tap",function() upgrade("bowAttack") end)
	
	local swordAttackIcon = display.newSprite(swordAttackGroup, sheet, sequence )
	swordAttackIcon:setSequence("swordAttack")
	swordAttackIcon:scale(2,2)
	swordAttackIcon.x=125
	swordAttackIcon.y=400

	swordAttackValue = display.newText(swordAttackGroup," + " ..composer.player.meleeAttackDamage,0,0, nil,30)
    swordAttackValue.x = swordAttackIcon.x + swordAttackValue.contentWidth + 50
    swordAttackValue.y = swordAttackIcon.y

	local swordAttackUpgrade = display.newImageRect(swordAttackGroup,"images/items/skillBtn.png",50,50)
	swordAttackUpgrade.x = swordAttackIcon.x + 275
	swordAttackUpgrade.y = swordAttackIcon.y
	swordAttackUpgrade:addEventListener("tap",function() upgrade("swordAttack") end)
	

	local lifeIcon = display.newSprite(lifeGroup, sheet, sequence )
	lifeIcon:setSequence("life")
	lifeIcon:scale(2,2)
	lifeIcon.x=550
	lifeIcon.y=175
	
	lifeValue = display.newText(lifeGroup," + " ..composer.player.life,0,0, nil,30)
    lifeValue.x = lifeIcon.x + lifeValue.contentWidth + 50
    lifeValue.y = lifeIcon.y

	local lifeUpgrade = display.newImageRect(lifeGroup,"images/items/skillBtn.png",50,50)
	lifeUpgrade.x = lifeIcon.x + 275
	lifeUpgrade.y = lifeIcon.y
	lifeUpgrade:addEventListener("tap",function() upgrade("life") end)
	

	local arrowSpeedIcon = display.newSprite(arrowSpeedGroup, sheet, sequence )
	arrowSpeedIcon:setSequence("arrowSpeed")
	arrowSpeedIcon:scale(2,2)
	arrowSpeedIcon.x=550
	arrowSpeedIcon.y=250
	
	arrowSpeedValue = display.newText(arrowSpeedGroup," - " ..composer.player.distanceAttackDelay,0,0, nil,30)
    arrowSpeedValue.x = arrowSpeedIcon.x + arrowSpeedValue.contentWidth + 50
    arrowSpeedValue.y = arrowSpeedIcon.y

	local arrowSpeedUpgrade = display.newImageRect(arrowSpeedGroup,"images/items/skillBtn.png",50,50)
	arrowSpeedUpgrade.x = arrowSpeedIcon.x + 275
	arrowSpeedUpgrade.y = arrowSpeedIcon.y
	arrowSpeedUpgrade:addEventListener("tap",function() upgrade("arrowSpeed") end)
	

	local swordSpeedIcon = display.newSprite(swordSpeedGroup, sheet, sequence )
	swordSpeedIcon:setSequence("swordSpeed")
	swordSpeedIcon:scale(2,2)
	swordSpeedIcon.x=550
	swordSpeedIcon.y=325

    swordSpeedValue = display.newText(swordSpeedGroup," + " ..composer.player.meleeAttackDelay,0,0, nil,30)
    swordSpeedValue.x = swordSpeedIcon.x + swordSpeedValue.contentWidth + 50
    swordSpeedValue.y = swordSpeedIcon.y

	local swordSpeedUpgrade = display.newImageRect(swordSpeedGroup,"images/items/skillBtn.png",50,50)
	swordSpeedUpgrade.x = swordSpeedIcon.x + 275
	swordSpeedUpgrade.y = swordSpeedIcon.y
	swordSpeedUpgrade:addEventListener("tap",function() upgrade("swordSpeed") end)
	

	local swordBleedIcon = display.newSprite(swordBleedGroup, sheet, sequence )
	swordBleedIcon:setSequence("swordBleed")
	swordBleedIcon:scale(2,2)
	swordBleedIcon.x=550
	swordBleedIcon.y=400

    swordBleedValue = display.newText(swordBleedGroup," + ".. composer.player.bleed,0,0, nil,30)
    swordBleedValue.x = swordBleedIcon.x + swordBleedValue.contentWidth + 50
    swordBleedValue.y = swordBleedIcon.y

	local swordBleedUpgrade = display.newImageRect(swordBleedGroup,"images/items/skillBtn.png",50,50)
	swordBleedUpgrade.x = swordBleedIcon.x + 275
	swordBleedUpgrade.y = swordBleedIcon.y
	swordBleedUpgrade:addEventListener("tap",function() upgrade("swordBleed") end)
	

	armorGroup:addEventListener("tap",function() setDescriptionText("armor") end)
	bowAttackGroup:addEventListener("tap",function() setDescriptionText("bowAttack") end)
	swordAttackGroup:addEventListener("tap",function() setDescriptionText("swordAttack") end)
	speedGroup:addEventListener("tap",function() setDescriptionText("speed") end)
	lifeGroup:addEventListener("tap",function() setDescriptionText("life") end)
	arrowSpeedGroup:addEventListener("tap",function() setDescriptionText("arrowSpeed") end)
	swordSpeedGroup:addEventListener("tap",function() setDescriptionText("swordSpeed") end)
	swordBleedGroup:addEventListener("tap",function() setDescriptionText("swordBleed") end)

	uiGroup:insert(armorGroup)
	uiGroup:insert(bowAttackGroup)
	uiGroup:insert(swordAttackGroup)
	uiGroup:insert(speedGroup)
	uiGroup:insert(lifeGroup)
	uiGroup:insert(arrowSpeedGroup)
	uiGroup:insert(swordSpeedGroup)
	uiGroup:insert(swordBleedGroup)
	
	

	local okButton = widget.newButton
	{
    width = 100,
    height = 110,
    left=display.contentWidth-130,
    top = display.contentHeight-130,
    defaultFile = "images/ok.png",
    overFile = "images/ok_hover.png",
    onRelease = function() 
    			
    			composer.removeScene("skills")
    			composer.gotoScene("juego")
				end
	}

sceneGroup:insert(okButton)
	

end

function scene:create( event )
	local sceneGroup = self.view

	initGame=initGame+1
	initUI(sceneGroup)
	sceneGroup:insert(uiGroup)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
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
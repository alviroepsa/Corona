-----------------------
-- Alfredo Vilaplana --
-----------------------
-- 	   intro.lua     --
-----------------------

local composer = require( "composer" )
local scene = composer.newScene()
local tablero = require("clases.scenario")
local player = require("clases.player")
local utils = require("clases.utils")
local widget = require("widget")

local spritesGroup = display.newGroup()
local textGroup = display.newGroup()
local sprite = display.newGroup()

local speedDataGroup = display.newGroup()
local lifeDataGroup = display.newGroup()
local meleeDataGroup = display.newGroup()
local distanceDataGroup = display.newGroup()




local selectedCharacter = 1

local function setIcon(group, numVidas, img)

    for i=1,numVidas do
     
     	local heart = display.newImageRect(img,30,25)
     	heart.x = (i-1)*35
     	heart.y = 0

     	group:insert(heart)	
	end
end


local function updateInfo()

   
	utils.cleanGroup(speedDataGroup)
	utils.cleanGroup(lifeDataGroup)
	utils.cleanGroup(meleeDataGroup)
	utils.cleanGroup(distanceDataGroup)
	utils.cleanGroup(spritesGroup)
	local psjOne = player.new(spritesGroup,selectedCharacter)

 	psjOne.x=display.contentWidth/2
	psjOne.y=display.contentHeight/3-20
	psjOne:scale(3,3)
	display.setDefault( "anchorX", 0 )

	local character = characters[selectedCharacter]
	setIcon(speedDataGroup,character.speed,"images/wing.png")
	--setIcon(lifeDataGroup,character.life,"images/heart.png")
	display.newText(lifeDataGroup,character.life,0,0,nil,30)
	display.newText(meleeDataGroup,character.melee,0,0,nil,30)
	display.newText(distanceDataGroup,character.distance,0,0,nil,30)
	display.setDefault( "anchorX", 0.5 )
end



local function initUI(sceneGroup)

	tablero.dibujarEscenario(sceneGroup,sceneGroup,nil,nil,6)

	local settings = display.newText(textGroup,"Caracteristicas:",display.contentWidth/2, display.contentHeight/2,nil,35)
	local speedSetting = display.newText(textGroup,"Velocidad: ",display.contentWidth/2-200, settings.y+settings.contentHeight+20,nil,35)

	speedSetting.anchorX=1
	speedSetting.anchorY=0
	speedSetting.x=display.contentWidth/2-50
	
	speedDataGroup.anchorX=0
	speedDataGroup.anchorY=0
	
	speedDataGroup.y=speedSetting.y+speedSetting.contentHeight/2
	speedDataGroup.x=speedSetting.x

	local lifeSetting = display.newText(textGroup,"Vidas: ",speedSetting.x, speedSetting.y+speedSetting.contentHeight+20,nil,35)
	
	lifeSetting.anchorX=1
	lifeSetting.anchorY=0
	lifeSetting.x=display.contentWidth/2-50

	lifeDataGroup.anchorX=1
	lifeDataGroup.anchorY=0
	
	lifeDataGroup.y=lifeSetting.y+lifeSetting.contentHeight/2
	lifeDataGroup.x=lifeSetting.x



	local meleeSetting = display.newText(textGroup,"Arma cuerpo a cuerpo: ",lifeSetting.x, lifeSetting.y+lifeSetting.contentHeight+20,nil,35)
	--meleeSettingOne.x =meleeSettingOne.x + meleeSettingOne.contentWidth/4
	
	meleeSetting.anchorX=1
	meleeSetting.anchorY=0
    meleeSetting.x=display.contentWidth/2-50

	meleeDataGroup.anchorX=0
	meleeDataGroup.anchorY=0
	
	meleeDataGroup.y = meleeSetting.y+meleeSetting.contentHeight/2
	meleeDataGroup.x = meleeSetting.x

	local distanceSetting = display.newText(textGroup,"Arma a distancia: ",meleeSetting.x, meleeSetting.y+meleeSetting.contentHeight+20,nil,35)
	--distanceSettingOne.x =distanceSettingOne.x + distanceSettingOne.contentWidth/4

	distanceSetting.anchorX=1
	distanceSetting.anchorY=0
 	distanceSetting.x=display.contentWidth/2-50

	
	distanceDataGroup.anchorX=0
	distanceDataGroup.anchorY=0
	
	distanceDataGroup.y=distanceSetting.y+distanceSetting.contentHeight/2
	distanceDataGroup.x=distanceSetting.x


local leftButton = widget.newButton
{
    width = 100,
    height = 100,
    left=50,
    top = display.contentHeight/2-50,
    defaultFile = "images/arrow.png",
    overFile = "images/arrow_hover.png",
    onRelease = function() selectedCharacter=selectedCharacter-1   if selectedCharacter<1 then selectedCharacter=#characters end  updateInfo() end
}
leftButton.xScale=-1

local rightButton = widget.newButton
{
    width = 100,
    height = 100,
    left=display.contentWidth-150,
    top = display.contentHeight/2-50,
    defaultFile = "images/arrow.png",
    overFile = "images/arrow_hover.png",
    onRelease = function() selectedCharacter=selectedCharacter-1   if selectedCharacter<1 then selectedCharacter=#characters end  updateInfo() end
}
local okButton = widget.newButton
{
    width = 100,
    height = 110,
    left=display.contentWidth-130,
    top = display.contentHeight-130,
    defaultFile = "images/ok.png",
    overFile = "images/ok_hover.png",
    onRelease = function() 
    			local options = {params ={spriteSelected = selectedCharacter}}
    			composer.removeScene("selectPlayer")
    			composer.gotoScene("juego",options)
				end
}

sceneGroup:insert(leftButton)
sceneGroup:insert(rightButton)
sceneGroup:insert(okButton)
	

end



function scene:create( event )
	local sceneGroup = self.view
	initUI(sceneGroup)

	updateInfo()
	
	sceneGroup:insert(speedDataGroup)
	sceneGroup:insert(lifeDataGroup)
	sceneGroup:insert(meleeDataGroup)
	sceneGroup:insert(distanceDataGroup)
	sceneGroup:insert(textGroup)

end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
	
	display.newText(sceneGroup, "Selecciona un personaje", display.contentWidth/2, 60,nil,35)

	sceneGroup:insert(spritesGroup)
	--	sceneGroup:addEventListener("tap",function() composer:gotoScene("juego") end)
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
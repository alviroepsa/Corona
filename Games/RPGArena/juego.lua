----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
-- Load Joystick Class
local joystickClass = require( "clases.joystick" )
local tablero = require("clases.scenario")
local player = require("clases.player")
local enemies = require("clases.enemy")
local widget = require( "widget" )
local physics = require("physics")
local interface = require("clases.ui")
local effects = require("clases.effects")
local items = require("clases.items")
local utils = require("clases.utils")
---------------------------------------------------------------------------------
system.activate( "multitouch" )
-- Tamaño de cada cuadro del juego   = Ej. 32x32 
tamCuadrados=32

local board = display.newGroup()
local walls = display.newGroup()
local heartGroup = display.newGroup()
local playerGroup = display.newGroup()
local itemsGroup = display.newGroup()
local enemiesGroup = display.newGroup()
local itemsGroup = display.newGroup()
local sprite
local folderImg = "images/"

local currentNumEnemies = 0
local quantity 

local delaySword = 300
local delayBow = 700
local contenedoresPosition={}




local function getRandomItem(posX, posY,isContainer)
		local rand = math.random(1,isContainer == true and 30 or 20)
		   	 		local nameObject

		   	 			print(rand)
		   	 		if rand<5 then
		   	 			nameObject = "bronze"
		   	 		elseif rand < 10 then
						nameObject = "heart"
		   	 		elseif rand <15 then
						nameObject = "arrows"
		   	 		elseif rand <=18 then
						nameObject = "silver"
		   	 		elseif rand <=20 then
						nameObject = "gold"
					else
						nameObject = "empty"
		   	 		end

		   	 		if nameObject~="empty" then
			   	 		local drop = items.newDropItem(nameObject,itemsGroup,true)
			   	 		drop.x=posX
			   	 		drop.y=posY
			   	 		return drop
		   	 	end
end
 function playerTouchItem( item, removeOnHit)
 
   if ( item == nil ) then  --make sure the first object exists
      return false
   end

  local back=false
  
   	   obj2=composer.player
	
	if obj2~=nil then	   
		   local left = item.contentBounds.xMin <= obj2.contentBounds.xMin and item.contentBounds.xMax >= obj2.contentBounds.xMin
		   local right = item.contentBounds.xMin >= obj2.contentBounds.xMin and item.contentBounds.xMin <= obj2.contentBounds.xMax
		   local up = item.contentBounds.yMin <= obj2.contentBounds.yMin and item.contentBounds.yMax >= obj2.contentBounds.yMin
		   local down = item.contentBounds.yMin >= obj2.contentBounds.yMin and item.contentBounds.yMin <= obj2.contentBounds.yMax


		   if ((left or right) and (up or down)) then
		   		   	
		   	if item~=nil and item[1]~=nil then
		   		if item[1].sequence=="bronze" then
		   			composer.gold=composer.gold+math.random(3,8) + level*2
		   			media.playSound( 'sounds/coin.wav' )
			
		   		elseif item[1].sequence=="silver" then
					composer.gold=composer.gold+math.random(10,30) + level*3
		   			media.playSound( 'sounds/coin.wav' )
			
				elseif item[1].sequence=="gold" then
					composer.gold=composer.gold+math.random(30,60) + level*5
		   			media.playSound( 'sounds/coin.wav' )
				
				elseif item[1].sequence=="arrows" then
		   			media.playSound( 'sounds/coin.wav' )
				
		   			composer.player.ammo=composer.player.ammo+math.random(5,10)
		   			if composer.player.ammo>composer.player.maxAmmo then
		   				composer.player.ammo=composer.player.maxAmmo
		   			end
		   			quantity.text=composer.player.ammo

		   		elseif item[1].sequence=="heart" then
		   			 media.playSound( 'sounds/potion_drink.wav' )
		   			playerGroup.currentLife=playerGroup.currentLife+math.random(10,25)
		   			if playerGroup.currentLife > playerGroup.life then
						playerGroup.currentLife = playerGroup.life
		   			end
		   			updatePlayerLife()
	  			
		   		end
				interface.updateGold()
		   		if removeOnHit==true  then
			   		utils.cleanObject(item)
			   		item:removeSelf()
			   	end
		   end
		end
   end
	
end

local function itemHitMonster( item, removeOnHit,meleeAttack)
   
   if ( item == nil ) then  --make sure the first object exists
      return false
   end

  local back=false
  
 for i=1,enemiesGroup.numChildren do
   	 
   	   obj2=enemiesGroup[i]
	
	if obj2~=nil and obj2.isHitable==true then	   
		   local left = item.contentBounds.xMin <= obj2.contentBounds.xMin and item.contentBounds.xMax >= obj2.contentBounds.xMin
		   local right = item.contentBounds.xMin >= obj2.contentBounds.xMin and item.contentBounds.xMin <= obj2.contentBounds.xMax
		   local up = item.contentBounds.yMin <= obj2.contentBounds.yMin and item.contentBounds.yMax >= obj2.contentBounds.yMin
		   local down = item.contentBounds.yMin >= obj2.contentBounds.yMin and item.contentBounds.yMin <= obj2.contentBounds.yMax

		   if ((left or right) and (up or down)) then

		   	if enemiesGroup[i].name=="container" then
		   	    media.playSound( 'sounds/break_vase.wav' )
		   		getRandomItem(enemiesGroup[i].x,enemiesGroup[i].y,true)
	 			enemiesGroup[i]:removeSelf()
		   		
		   	else
		   
		   		local enemyState = enemies.updateLife(enemiesGroup[i],(meleeAttack and -playerGroup.meleeAttackDamage or -playerGroup.distanceAttackDamage))
		   	 	if enemiesGroup[i].name == "wizard" then
 					effects.showLifeDamage(itemsGroup.insideItem,(meleeAttack and -playerGroup.meleeAttackDamage or -playerGroup.distanceAttackDamage),enemiesGroup[i].teleport.x,enemiesGroup[i].teleport.y)
	      
		   	 	else
		   	 	 effects.showLifeDamage(itemsGroup,(meleeAttack and -playerGroup.meleeAttackDamage or -playerGroup.distanceAttackDamage),enemiesGroup[i].x,enemiesGroup[i].y)
	      		end
	      	
		   	 	if enemyState == "destroyed" then
		   	 		media.playSound( 'sounds/killed_monster.wav' )
		   	 		if playerGroup.bleed>0 then
			   	 		playerGroup.currentLife=playerGroup.currentLife+playerGroup.bleed
		        
				        effects.showLifeDamage(itemsGroup,playerGroup.bleed,playerGroup.x,playerGroup.y)
				        updatePlayerLife()
				    end

		   	 		local drop = getRandomItem(enemiesGroup[i].x,enemiesGroup[i].y)
	
		   	 		if enemiesGroup[i].name == "death" then
			   	 		for j=1,#enemiesGroup[i].transitions do 
							transition.cancel(enemiesGroup[i].transitions[j])
						end
			   	 		for j=1,#enemiesGroup[i].timers do 

	   		 				timer.cancel(enemiesGroup[i].timers[j]) 
	   					end 
	   				elseif enemiesGroup[i].name == "wizard" then

						enemiesGroup[i].teleport:removeEventListener( "sprite", effects.teleportHandler )
				   	    enemiesGroup[i].teleport.alpha=0
				   	    drop.x=enemiesGroup[i].teleport.x
		   	 			drop.y=enemiesGroup[i].teleport.y
				   elseif enemiesGroup[i].name == "skeleton" then
						for j=1,#enemiesGroup[i].timers do 
	   		 				timer.cancel(enemiesGroup[i].timers[j]) 
	   					end 
				    end
   					
   					enemiesGroup[i]:removeSelf()
		   	 		currentNumEnemies = currentNumEnemies-1

		   	 		if currentNumEnemies==0 then
		   	 			interface.prepareNewLevel(heartGroup)
		   	 			transition.to(true,{delay=4500,onComplete=function() 
		   	 				composer.savedPlayer=composer.player
		   	 				composer.removeScene("juego")
		   	 				if level % 5 == 0 then
		        				composer.gotoScene("skills")
			        		else
			        			composer.gotoScene("newLevel")
			        		end
		        	    end})
		   	 			
		   	 		end
		   	 	end
		   	 end
		   	 	if meleeAttack~=true then
		   	 		utils.cleanObject(item)
			   	end
		   		
		   		if removeOnHit==true  then
			   		item:removeSelf()
			   	end
		   end
		end
	end
end

function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end


function itemHitPlayer( item, removeOnHit,meleeAttack)
   
   if ( item == nil ) then  --make sure the first object exists
      return false
   end
   if (sprite==nil) then
   	  return false
   	end

  local back=false
  
 	
   	   obj2=sprite
		   
	   local left = item.contentBounds.xMin <= obj2.contentBounds.xMin and item.contentBounds.xMax >= obj2.contentBounds.xMin--+obj2.contentWidth/2-10
	   local right = item.contentBounds.xMin >= obj2.contentBounds.xMin and item.contentBounds.xMin <= obj2.contentBounds.xMax---obj2.contentWidth/2-10
	   local up = item.contentBounds.yMin <= obj2.contentBounds.yMin and item.contentBounds.yMax >= obj2.contentBounds.yMin--+obj2.contentHeight/2-10
	   local down = item.contentBounds.yMin >= obj2.contentBounds.yMin and item.contentBounds.yMin <= obj2.contentBounds.yMax---obj2.contentHeight/2-10


	   if ((left or right) and (up or down)) then
		   	if item.name=="skeleton" then
	   	 		timer.pause(item.timers[1])
	   	 		transition.to(true,{delay=1500,onComplete = function() timer.resume(item.timers[1]) end})
	   	 	end

	   	    local damage = item.damage-composer.player.armor/3 
	   	    if damage<1 then
	   	    	damage=1
	   	    end

	   	    damage=round(damage,2)
	   		playerGroup.currentLife=playerGroup.currentLife-damage
	        
	        effects.showLifeDamage(itemsGroup,-damage,playerGroup.x,playerGroup.y)
	        updatePlayerLife()


	        if playerGroup.currentLife<=0 then
		        composer.removeScene("juego")
		        composer.gotoScene("gameOver")
		    end

	   		if removeOnHit==true  then
	   			for i=1,#item.timers do 
   		 			timer.cancel(item.timers[i]) 
   				end 
   				if item~=nil then
			   		item:removeSelf()
			   	end
		   	end
	   end
end




-- Function to handle button events
local function buttonBowHandler( event )

    if ( "ended" == event.phase and event.target.delay~=true ) then
    	event.target.delay = true
    	timer.performWithDelay(playerGroup.distanceAttackDelay,function() event.target.delay=false end,1)
    	
    	if composer.player.ammo>0 then

    			composer.player.ammo=composer.player.ammo-1
    			quantity.text=composer.player.ammo
		    	local arrow = display.newImageRect("images/ammo/arrow.png",57,21)
		    
		    	local destinyX = 0
		    	local destinyY = 0
		    	local timeSpeed = 0
		    	if (sprite.sequence=="up") then
		    		arrow.rotation=90
		    		arrow.x=playerGroup.x
		    		arrow.y=playerGroup.y-sprite.contentHeight/2

					destinyX=arrow.x
		    		destinyY=0+tamCuadrados/2
		    		timeSpeed=1000-(display.contentHeight-playerGroup.y)*1000/display.contentHeight
		    	
		    	elseif (sprite.sequence=="right") then
					arrow.rotation=180
					arrow.x=playerGroup.x+sprite.contentWidth/2
		    		arrow.y=playerGroup.y
					destinyY=arrow.y
					destinyX=display.contentWidth-tamCuadrados/2
					timeSpeed=(display.contentWidth-playerGroup.x)*1000/display.contentWidth
		
				elseif (sprite.sequence=="down") then
					arrow.rotation=270
					arrow.x=playerGroup.x
		    		arrow.y=playerGroup.y+sprite.contentHeight/2
					destinyX=arrow.x
					destinyY=display.contentHeight-tamCuadrados/2
					timeSpeed=(display.contentHeight-playerGroup.y)*1000/display.contentHeight

				elseif (sprite.sequence=="left") then
					arrow.x=playerGroup.x-sprite.contentWidth/2
		    		arrow.y=playerGroup.y
					destinyY=arrow.y
					destinyX=0+tamCuadrados/2
					timeSpeed=1000-(display.contentWidth-playerGroup.x)*1000/display.contentWidth
				end
		    	arrow.timers= {}
		    	arrow.trans = {}
		    	arrow.timers[#arrow.timers+1] = timer.performWithDelay(50,function() itemHitMonster(arrow, true,false) end,0)
		    	arrow.trans[#arrow.trans+1] = transition.moveTo(arrow,{x=destinyX,  y=destinyY, time=timeSpeed, onComplete = 
		    		function() 
		    			timer.cancel(arrow.timers[1]) 
		    		 	transition.to(arrow,{time=2000,onComplete=
		    		 		function() 
		    		 		
		    		 				arrow.alpha=0
		    	
		    		 	    end})  
		    		end})
		    	arrow.name="arrow"
				media.playSound( 'sounds/bow_attack.wav' )
		    	itemsGroup:insert(arrow)
		    end

		end
	end


local function buttonSwordHandler( event )

    if ( "ended" == event.phase and event.target.delay~=true ) then
    	event.target.delay = true
    	timer.performWithDelay(playerGroup.meleeAttackDelay,function() event.target.delay=false end,1)
    	
	    		local effectSword = effects.swordSwipe()
	    		if playerGroup.name=="Thief"  then
	    			effectSword:scale(0.5,2)
	    		elseif playerGroup.name=="Warrior" then
	    			effectSword:scale(1.3,2)
	    		elseif playerGroup.name=="Soldier" then
					effectSword:scale(0.75,2)
	    		end

	    		if (sprite.sequence=="up") then
		    		effectSword.rotation=270
					effectSword.x=sprite.x-effectSword.contentWidth/4
	    			effectSword.y=sprite.y-sprite.contentHeight/2-effectSword.contentHeight/2
		    	elseif (sprite.sequence=="right") then
					effectSword.x=sprite.x+sprite.contentWidth/2+effectSword.contentWidth/2
		    		effectSword.y=sprite.y-sprite.contentHeight/4	
		    
				elseif (sprite.sequence=="down") then
					effectSword.rotation=90
					effectSword.x=sprite.x+effectSword.contentWidth/4
	    			effectSword.y=sprite.y+sprite.contentHeight/2+effectSword.contentHeight/2
	    			
				elseif (sprite.sequence=="left") then
					effectSword.x=sprite.x-sprite.contentWidth/2-effectSword.contentWidth/2
		    		effectSword.y=sprite.y+sprite.contentHeight/4	
		    		effectSword.rotation=180
				end
		    	
				playerGroup:insert(effectSword)
	    		effectSword:play()
	    		media.playSound( 'sounds/sword_attack.wav' )
	    		effectSword.timers={}
				effectSword.timers[1] = timer.performWithDelay(90,function() itemHitMonster(effectSword,false,true) end,0)
		    	
	    		effectSword.timers[2] = timer.performWithDelay( 100, function() utils.cleanObject(effectSword) effectSword:removeSelf() end)
	    			
	    end
    end



local function initUI(sceneGroup)

	local buttonSword= widget.newButton
	{
	    defaultFile = folderImg.."ui/button_sword.png",
    	overFile = folderImg.."ui/button_sword_over.png",
	    onEvent = buttonSwordHandler
	}


	local buttonBow= widget.newButton
	{
	    defaultFile = folderImg.."ui/button_bow.png",
    	overFile = folderImg.."ui/button_bow_over.png",
	    onEvent = buttonBowHandler
	}

	local ammoQuantity = display.newCircle(0,0,25)
	ammoQuantity:setFillColor(0,0,0)
	ammoQuantity.anchorX=1
	ammoQuantity.anchorY=1

	buttonBow:scale(1.25,1.25)
	buttonSword:scale(1.25,1.25)
	buttonBow.x=display.contentWidth-60
	buttonBow.y=display.contentHeight-65
	
	ammoQuantity.x=buttonBow.x-10
	ammoQuantity.y=buttonBow.y-10

	quantity = display.newText(playerGroup.ammo==nil and 0 or playerGroup.ammo,ammoQuantity.x-25,ammoQuantity.y-25,nil,25)


	buttonSword.x=buttonBow.x-buttonBow.contentWidth-15
	buttonSword.y=buttonBow.y

	buttonSword.name="sword"
	buttonBow.name="bow"
	
	sceneGroup:insert(buttonBow)
	sceneGroup:insert(buttonSword)
	sceneGroup:insert(ammoQuantity)
	sceneGroup:insert(quantity)
end


function scene:create( event )
	local sceneGroup = self.view

	initGame= initGame+1

	sceneGroup:insert(board)
	sceneGroup:insert(walls)
	sceneGroup:insert(itemsGroup)


	local r = math.random(1,4)
	if r==1 then
		composer.typeMap="rock"
		contenedoresPosition=tablero.dibujarEscenario(board,walls,mapTest,"rock",nil)
	elseif r==2 then
		composer.typeMap="grass"
		contenedoresPosition=tablero.dibujarEscenario(board,walls,mapTest,"grass",nil)
	elseif r==3 then
		composer.typeMap="castle"
		contenedoresPosition=tablero.dibujarEscenario(board,walls,mapTest,"castle",nil)
	else
		composer.typeMap="desert"
		contenedoresPosition=tablero.dibujarEscenario(board,walls,mapTest,"desert",nil)
	end
	--for i = enemiesGroup.numChildren, 1, -1 do
	
	
	walls.name="walls"
	physics.addBody( walls,"static")
end


local function movedJoystick( event )

	local direction

	if event.joyAngle ~= false then
		if (event.joyAngle>0 and event.joyAngle<=45) or (event.joyAngle<360 and event.joyAngle>=315) and sprite.sequence ~= "up" then
			sprite:setSequence("up")	
			sprite:play()
		elseif (event.joyAngle>45 and event.joyAngle<=135) and sprite.sequence ~= "right" then
			sprite:setSequence("right")	
			sprite:play()
		elseif (event.joyAngle>135 and event.joyAngle<=225) and sprite.sequence ~= "down"  then
			sprite:setSequence("down")	
			sprite:play()
		elseif (event.joyAngle>225 and event.joyAngle<=315) and sprite.sequence ~= "left" then
			sprite:setSequence("left")	
			sprite:play()
		end
	end


	local lastX = playerGroup.x
	local lastY = playerGroup.y
	if event.joyX ~= false then
			playerGroup.x = (playerGroup.x+event.joyX*playerGroup.currentSpeed<playerGroup.contentWidth or playerGroup.x+event.joyX*playerGroup.currentSpeed>display.contentWidth-playerGroup.contentWidth) and playerGroup.x or playerGroup.x+event.joyX*playerGroup.currentSpeed
	end

	if  event.joyY ~= false then
			playerGroup.y = (playerGroup.y+event.joyY*playerGroup.currentSpeed<playerGroup.contentHeight or playerGroup.y+event.joyY*playerGroup.currentSpeed>display.contentHeight-playerGroup.contentHeight) and playerGroup.y or playerGroup.y+event.joyY*playerGroup.currentSpeed
	end

	if playerGroup.x > 0 and playerGroup.y >0 then
	    local terrainType = mapCastle[currentMap][math.round((playerGroup.y+playerGroup.contentHeight/2)/32)][math.round((playerGroup.x)/32)]
		if terrainType==23 then
			playerGroup.x=lastX
			playerGroup.y=lastY
		end
		if terrainType==22 then

			playerGroup.currentSpeed=playerGroup.speed/2
		else
			playerGroup.currentSpeed=playerGroup.speed
		end
	end

	composer.player=playerGroup

end

function updatePlayerLife()

	interface.updateLife(heartGroup,playerGroup.life)

end

local function drawContainers()
local options = {width = 32, height = 32, numFrames = 4, sheetContentWidth=128, sheetContentHeight=32 }

local sheet = graphics.newImageSheet("images/items/jarron.png", options)

local sequence =
{
    { name=1, start=1, count=1 },
    { name=2, start=2, count=1 },
    { name=3, start=3, count=1 },
    { name=4, start=4, count=1 },

}
	for i = 1,#contenedoresPosition do
		local container = display.newSprite(enemiesGroup,sheet,sequence)
		container:setSequence(math.random(1,4))
		container.x=contenedoresPosition[i][2]
		container.y=contenedoresPosition[i][1]
		container.isHitable = true
		container.name="container"
	end


end


local function startLevel(sceneGroup)
	drawContainers()
	level = level +1 
	local text = display.newText("Level " .. level,display.contentWidth/2,display.contentHeight/2,nil,30)
	transition.to(text,{xScale=2,yScale=2,time=2000, onComplete=function() text:removeSelf() end})
	interface.setLevel(heartGroup,level)

	local maxEnemiesInLevel = level % 5 == 0 and 5 or level % 5
	currentNumEnemies = 0
	while(currentNumEnemies<maxEnemiesInLevel) do
		local i = math.random(1,3)
		if i==1 then
			enemies.newWizard(enemiesGroup)
		elseif i == 2 then
			enemies.newSkeleton(enemiesGroup)
		else
			enemies.newDeath(enemiesGroup)
		end
		currentNumEnemies=currentNumEnemies+1

	end


end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
    	elseif phase == "did" then

		if event.params ~= nil then
			spriteSelected = event.params.spriteSelected
		end
	
		playerGroup = player.new(sceneGroup,spriteSelected)
		
		composer.player=playerGroup

		if composer.savedPlayer ~= nil then	
			playerGroup.currentLife=composer.savedPlayer.currentLife
			playerGroup.speed=composer.savedPlayer.speed
			playerGroup.ammo=composer.savedPlayer.ammo


		playerGroup.life=composer.savedPlayer.life
	    playerGroup.armor=composer.savedPlayer.armor
		playerGroup.meleeAttackDamage=composer.savedPlayer.meleeAttackDamage
		playerGroup.meleeAttackDelay=composer.savedPlayer.meleeAttackDelay
		playerGroup.distanceAttackDelay=composer.savedPlayer.distanceAttackDelay
		playerGroup.distanceAttackDamage=composer.savedPlayer.distanceAttackDamage
		playerGroup.distanceAttackSpeedShot=composer.savedPlayer.distanceAttackSpeedShot
     	playerGroup.bleed = composer.savedPlayer.bleed

		end

		sprite=playerGroup[1]
		sprite:scale(1.5,1.5)
	
		playerGroup.x=display.contentWidth/2
		playerGroup.y=100
	

		updatePlayerLife()

	
	 	startLevel(sceneGroup)
	end	
	joystick = joystickClass.newJoystick{
			outerRadius = 0,						-- Outer Radius - Size Of Outer Joystick Element - The Limit
			outerAlpha = 0,							-- Outer Alpha ( 0 - 1 )
			innerImage = "images/joystickInner.png",		-- Inner Image - Circular - Leave Empty For Default Vector
			innerRadius = 0,						-- Inner Radius - Size Of Touchable Joystick Element
			innerAlpha = 0,							-- Inner Alpha ( 0 - 1 )
			backgroundImage = "images/joystickDial.png",	-- Background Image
			background_x = 0,						-- Background X Offset
			background_y = 0,						-- Background Y Offset
			backgroundAlpha = 0,					-- Background Alpha ( 0 - 1 )
			position_x = display.contentWidth/2,						-- X Position Top - From Left Of Screen - Positions Outer Image
			position_y = display.contentHeight/2,					-- Y Position - From Left Of Screen - Positions Outer Image
			ghost = 255,							-- Set Alpha Of Touch Ghost ( 0 - 255 )
			joystickAlpha = 0,					-- Joystick Alpha - ( 0 - 1 ) - Sets Alpha Of Entire Joystick Group
			joystickFade = false,					-- Fade Effect ( true / false )
			joystickFadeDelay = 2000,				-- Fade Effect Delay ( In MilliSeconds )
			outerImage = "",						-- Outer Image - Circular - Leave Empty For Default Vector
			onMove = movedJoystick
		}

		joystick:scale(50,50)
		joystick.alpha=0.01

    sceneGroup:insert(playerGroup)
    
	sceneGroup:insert(enemiesGroup)
	
	sceneGroup:insert(joystick)
	
	initUI(sceneGroup)


	sceneGroup:insert(heartGroup)
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

	utils.cleanGroup(itemsGroup)
	utils.cleanGroup(playerGroup)

	for i = enemiesGroup.numChildren, 1, -1 do

		if enemiesGroup[i].timers then
			for j = 1,#enemiesGroup[i].timers do
						         	
						timer.cancel(enemiesGroup[i].timers[j])
		    end
		
		end
		if enemiesGroup[i].transitions then
			for j = 1,#enemiesGroup[i].transitions do
						         	
						transition.cancel(enemiesGroup[i].transitions[j])
		    end
		
		end
			enemiesGroup[i]:removeSelf()
			enemiesGroup[i]=nil
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
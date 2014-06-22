
local _enemy = {}
local composer = require( "composer" )

local options = 
	{

		width = 32,
		height = 32,
		numFrames = 36,

		sheetContentWidth = 288,
		sheetContentHeight = 128,
	}


local sequenceDeath ={ 
					{ name="down", start=7, count=3, time=1000, loopDirection="bounce" },
					{ name= "left", start=16, count=3, time=1000,  loopDirection="bounce" },
 					{ name="right", start=25, count=3, time=1000, loopDirection="bounce" },
 					{ name= "up", start=34, count=3, time=1000, loopDirection="bounce" }
 				}
local sequenceSkeleton ={ 
					{ name="down", start=4, count=3, time=1000, loopDirection="bounce" },
					{ name= "left", start=13, count=3, time=1000,  loopDirection="bounce" },
 					{ name="right", start=22, count=3, time=1000, loopDirection="bounce" },
 					{ name= "up", start=31, count=3, time=1000, loopDirection="bounce" }
 				}
local sequenceWizard ={ 
					{ name="down", start=1, count=3, time=1000, loopDirection="bounce" },
					{ name= "left", start=10, count=3, time=1000,  loopDirection="bounce" },
 					{ name="right", start=19, count=3, time=1000, loopDirection="bounce" },
 					{ name= "up", start=28, count=3, time=1000, loopDirection="bounce" }
 				}


local function moveToRandomPosition(spriteGroup,sceneGroup)

	spriteGroup.transitions[#spriteGroup.transitions+1]=transition.to(spriteGroup,{time=3000,x=math.random(100,display.contentWidth-100),y=math.random(100,display.contentHeight-100), onComplete = function()  
		local effectOne = display.newImageRect(sceneGroup,"images/ammo/arrow.png",57,21)
		local effectTwo = display.newImageRect(sceneGroup,"images/ammo/arrow.png",57,21)
		local effectThree = display.newImageRect(sceneGroup,"images/ammo/arrow.png",57,21)
		local effectFour = display.newImageRect(sceneGroup,"images/ammo/arrow.png",57,21)

		effectOne.x = spriteGroup.x
		effectOne.y = spriteGroup.y
		effectOne.rotation=90
		effectOne.timers={}
		effectTwo.x = spriteGroup.x
		effectTwo.y = spriteGroup.y
		effectTwo.rotation=180
		effectTwo.timers={}
		effectThree.x = spriteGroup.x
		effectThree.y = spriteGroup.y
		effectThree.rotation=270
		effectThree.timers={}
		effectFour.x = spriteGroup.x
		effectFour.y = spriteGroup.y
		effectFour.rotation=0
		effectFour.timers={}
 	
 		effectOne.damage=level
		effectTwo.damage=level
		effectThree.damage=level
		effectFour.damage=level

		effectOne.timers[1]=timer.performWithDelay(1,function() itemHitPlayer(effectOne, true,false) end,0)
		effectTwo.timers[1]=timer.performWithDelay(1,function() itemHitPlayer(effectTwo, true,false) end,0)
		effectThree.timers[1]=timer.performWithDelay(1,function() itemHitPlayer(effectThree, true,false) end,0)
		effectFour.timers[1]=timer.performWithDelay(1,function() itemHitPlayer(effectFour, true,false) end,0)

		transition.to(effectOne,{time=2000-(display.contentHeight-effectOne.y)*2000/display.contentHeight,x=effectOne.x,y=tamCuadrados/2,onComplete= function()  timer.cancel(effectOne.timers[1]) if effectOne~=nil then effectOne.alpha=0 end  end})
		transition.to(effectTwo,{time=2000-(display.contentHeight-effectTwo.y)*2000/display.contentHeight,x=display.contentWidth-tamCuadrados/2,y=effectTwo.y,onComplete= function()  timer.cancel(effectTwo.timers[1]) if effectTwo~=nil then effectTwo.alpha=0 end  end})
		transition.to(effectThree,{time=2000-(display.contentHeight-effectThree.y)*2000/display.contentHeight,x=effectThree.x,y=display.contentHeight-tamCuadrados/2,onComplete=  function()  timer.cancel(effectThree.timers[1]) if effectThree~=nil then effectThree.alpha=0 end  end})
		transition.to(effectFour,{time=2000-(display.contentHeight-effectFour.y)*2000/display.contentHeight,x=tamCuadrados/2,y=effectFour.y,onComplete=  function()  timer.cancel(effectFour.timers[1]) if effectFour~=nil then effectFour.alpha=0 end  end})
		
		spriteGroup.transitions[#spriteGroup.transitions+1]=transition.to(spriteGroup,{delay=1000, onComplete=function() moveToRandomPosition(spriteGroup,sceneGroup) end})
		end})
	
end


function getTypeMap()

	if composer.typeMap == "castle" then
		return "images/sprites/monsterCastle.png"
	elseif composer.typeMap == "rock" then
		return "images/sprites/monsterRock.png"
	elseif composer.typeMap == "desert" then
		return "images/sprites/monsterDesert.png"
	elseif composer.typeMap == "grass" then
		return "images/sprites/monsterGrass.png"
	end

end

function _enemy.newDeath(sceneGroup)


	local spriteGroup = display.newGroup()
	local sprite
	
	local currentLife=0
	local maxLife = 0
	local speed=0
	
	maxLife = 1 * (level*0.5)
	currentLife = maxLife
	speed=5


    local sheet = graphics.newImageSheet(getTypeMap(), options )

    sprite = display.newSprite( sheet, sequenceDeath )
    sprite:scale(1.5,1.5)
	sprite:setSequence("down")
	sprite:play()
	sprite.transitions={}
	spriteGroup:insert(sprite)
	spriteGroup.name="death"
	
    -- INIT STATS
	spriteGroup.life=life
	spriteGroup.speed=speed
	spriteGroup.currentLife=currentLife
	spriteGroup.maxLife=maxLife
	spriteGroup.isHitable = true
	spriteGroup.timers = {}
	spriteGroup.transitions = {}
	-- FINISH STATS
	local effects = require("clases.effects")
	spriteGroup.x = math.random(100, display.contentWidth-100)
    spriteGroup.y = math.random(100, display.contentHeight-100)

    sceneGroup:insert(spriteGroup)

    moveToRandomPosition(spriteGroup,sceneGroup)
	return spriteGroup
end


function _enemy.newSkeleton(sceneGroup)


	local spriteGroup = display.newGroup()
	local sprite
	
	local currentLife=0
	local maxLife = 0
	local speed=0
	
    maxLife = 1 * (level*0.5)
	currentLife = maxLife
	speed=2
  local sheet = graphics.newImageSheet(getTypeMap(), options )

    sprite = display.newSprite( sheet, sequenceSkeleton )
  	sprite:scale(1.5,1.5)
	sprite:setSequence("down")
	sprite:play()
	sprite.transitions={}
	spriteGroup:insert(sprite)
    spriteGroup.name="skeleton"
    -- INIT STATS
	spriteGroup.life=life
	spriteGroup.speed=speed
	spriteGroup.currentLife=currentLife
	spriteGroup.maxLife=maxLife
	spriteGroup.isHitable = true
	spriteGroup.timers = {}
	-- FINISH STATS
	local effects = require("clases.effects")
	spriteGroup.x = math.random(100, display.contentWidth-100)
    spriteGroup.y = math.random(100, display.contentHeight-100)
 



   	spriteGroup.timers[#spriteGroup.timers+1]=timer.performWithDelay(10,function()
   						
   	 							 if spriteGroup.x<composer.player.x then
   	 							 		spriteGroup.x=spriteGroup.x+spriteGroup.speed
   	 							 elseif spriteGroup.x>=composer.player.x then
   	 							 		spriteGroup.x=spriteGroup.x-spriteGroup.speed
   	 							 end
   	 							 if spriteGroup.y<composer.player.y then
   	 							 		spriteGroup.y=spriteGroup.y+spriteGroup.speed
   	 							 elseif spriteGroup.y>=composer.player.y then
   	 							 		spriteGroup.y=spriteGroup.y-spriteGroup.speed
   	 							 end
   	 							end,0)
   	spriteGroup.timers[#spriteGroup.timers+1]=timer.performWithDelay(100,function() itemHitPlayer(spriteGroup, false,false) end,0)
    spriteGroup.damage=1
    sceneGroup:insert(spriteGroup)

	return spriteGroup
end


function _enemy.newWizard(sceneGroup)


	local spriteGroup = display.newGroup()
	local sprite
	
	local currentLife=0
	local maxLife = 0
	local speed=0
	
	maxLife = 1 * (level*0.5)
	currentLife = maxLife
	speed=5
  local sheet = graphics.newImageSheet(getTypeMap(), options )

    sprite = display.newSprite( sheet, sequenceWizard )
    sprite:scale(1.5,1.5)
	sprite:setSequence("down")
	sprite:play()
	sprite.transitions={}
	spriteGroup:insert(sprite)
	spriteGroup.name="wizard"
    -- INIT STATS
	spriteGroup.life=life
	spriteGroup.speed=speed
	spriteGroup.currentLife=currentLife
	spriteGroup.maxLife=maxLife
	spriteGroup.isHitable = true

	sprite.alpha=0
	-- FINISH STATS
	local effects = require("clases.effects")
	local teleport = effects.teletransport()
	teleport:scale(0.5,0.5)
	sceneGroup:insert(teleport)
    teleport.x = math.random(150, display.contentWidth-150)
    teleport.y = math.random(150, display.contentHeight-150)
    sprite.x=teleport.x
    sprite.y=teleport.y
    teleport:scale(2,2)
    teleport:play()
   
    teleport.insideItem=sprite
    teleport.group = sceneGroup
    teleport:addEventListener("sprite",effects.teleportHandler)

	spriteGroup.teleport=teleport
    sceneGroup:insert(spriteGroup)

	return spriteGroup
end


function _enemy.updateLife( obj, lifePoint)
	

	-- LifePoint could be positive or negative
	obj.currentLife = obj.currentLife+lifePoint
	if obj.currentLife<=0 then
		obj.currentLife = 0
		return "destroyed"
	elseif obj.currentLife>obj.maxLife then
		obj.currentLife = obj.maxLife
		return "hit"
	else
		return "hit"
	end


	--local textLife = display.newText(obj.currentLife.."/"..objmaxLife,obj.x,obj.y-obj.contentHeight/2-20,nil,25)
	--textLife:setFillColor(0,255,0)
	
	--obj:insert(textLife)

end


return _enemy
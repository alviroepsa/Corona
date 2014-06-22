
local _effects = {}
local composer = require( "composer" )
function _effects.swordSwipe()
	local options = 
		{
			width = 32,
			height = 32,
			numFrames = 3,
			sheetContentWidth = 96,
			sheetContentHeight = 32,
		}

	local sheet = graphics.newImageSheet( "images/effects/sword_swipe.png", options )

	local sequence ={ 
						{ name="start", start=1, count=3, time=100, loopCount = 1 }
	 				}

	local effect = display.newSprite( sheet, sequence )
	effect:scale(2,2)
	effect:setSequence("start")
    return effect
end


local function fireball(posX,posY)
	local options = 
		{
			width = 64,
			height = 64,
			numFrames = 64,
			sheetContentWidth = 512,
			sheetContentHeight = 512,
		}

	local sheet = graphics.newImageSheet( "images/effects/fireball.png", options )

	local sequence ={ 
						{ name="left", start=1, count=8, time=100,loopDirection="bounce"},
						{ name="leftUp", start=9, count=8, time=100, loopDirection="bounce" },
						{ name="up", start=17, count=8, time=100,loopDirection="bounce" },
						{ name="rightUp", start=25, count=8, time=100, loopDirection="bounce"},
						{ name="right", start=33, count=8, time=100, loopDirection="bounce" },
						{ name="rightDown", start=41, count=8, time=100, loopDirection="bounce" },
						{ name="down", start=49, count=8, time=100, loopDirection="bounce" },
	 					{ name="leftDown", start=57, count=8, time=100, loopDirection="bounce"}
	 				}

	local effect = display.newSprite( sheet, sequence )
	effect.x=posX
	effect.y=posY
	if composer.player.x-effect.x > 0 then
		effect.velX=math.random(3,10)
	else
		effect.velX=math.random(-10,-3)
	end
	if composer.player.y-effect.y > 0 then
		effect.velY=math.random(3,10)
	else
		effect.velY=math.random(-10,-3)
	end
	effect:setSequence("left")
    return effect
end

function _effects.teletransport()
	local options = 
		{
			width = 32,
			height = 31,
			numFrames = 12,
			sheetContentWidth = 96,
			sheetContentHeight = 124,
		}

	local sheet = graphics.newImageSheet( "images/effects/teleport.png", options )

	local sequence ={ 
						{ name="start", start=1, count=12, time=2000, loopCount=1 },
						{ name="reverse",frames= {12,11,10,9,8,7,6,5,4,3,2,1 }, time=2000,loopCount=1}			
	 				}

	local effect = display.newSprite( sheet, sequence )

	effect:setSequence("start")
    return effect
end


function _effects.showLifeDamage(group, damageReceived,posX, posY)

	
	local damage = display.newEmbossedText(damageReceived,posX,posY,nil,40)
	damage.strokeWidth=4
	damage:setStrokeColor(0,255,0)
	if damageReceived<0 then
		damage:setFillColor(255,0,0)
	else
		damage:setFillColor(0,255,0)
	end

	transition.to(damage,{time=2000,y=posY-100,alpha=0,onComplete = function() damage:removeSelf() end})
end



local function effectRebote(event)

local px,py,vx,vy,diametre

    px = event.source.params.paramOne.x
    py =  event.source.params.paramOne.y
    vx =  event.source.params.paramOne.velX
    vy =  event.source.params.paramOne.velY
    diametre = event.source.params.paramOne.contentHeight
  
    if (px + diametre/2 > display.contentWidth - 1-32 or px - diametre/2 < 32) then
       vx = vx * -1
    end

    if (py + diametre/2 > display.contentHeight - 1-32 or py - diametre/2 < 32) then
       vy = vy * -1 
    end

       px = px + vx
       py = py + vy

        if vx>0 and vy > 0 then
        	event.source.params.paramOne:setSequence("rightDown")
        elseif vx>0 and vy==0 then
        	event.source.params.paramOne:setSequence("right")
       	elseif vx>0 and vy<0 then
 			event.source.params.paramOne:setSequence("rightUp")
        elseif vx<0 and vy==0 then
        	event.source.params.paramOne:setSequence("left")
       	elseif vx<0 and vy>0 then
 			event.source.params.paramOne:setSequence("leftDown")
 		elseif vx==0 and vy>0 then
        	event.source.params.paramOne:setSequence("down")
       	elseif vx<0 and vy<0 then
 			event.source.params.paramOne:setSequence("leftUp")
 		elseif vx==0 and vy<0 then
        	event.source.params.paramOne:setSequence("up")
        end

        event.source.params.paramOne.x=px
        event.source.params.paramOne.y=py
        event.source.params.paramOne.velX=vx
        event.source.params.paramOne.velY=vy


end


local function shootFireBall(event)

	--local eventr = event.source.params.paramOne
	local fire = fireball(event.source.params.paramOne.insideItem.x, event.source.params.paramOne.insideItem.y)
		event.source.params.paramOne.group:insert(fire)

	fire.damage=level+level/2
	fire.timers={}
	fire.timers[1]=timer.performWithDelay(100,function() itemHitPlayer(fire, true,false) end,0)
    fire.timers[2]=timer.performWithDelay(20, effectRebote  ,0)
   	fire.timers[2].params = { paramOne = fire }
   	fire.timers[3]=timer.performWithDelay(15000, function() 
   		 												for i=1,#fire.timers do 
   		 													timer.cancel(fire.timers[i]) 
   		 											    end 
   		 											        fire:removeSelf() 
   		 										  end,1)
  
end


function _effects.teleportHandler(event)

	if event.phase=="ended" then
	    if event.target.sequence=="start" then
  			event.target:setSequence("reverse")
  			event.target:play()
  			transition.to(event.target.insideItem,{alpha=1, time=2000})
		elseif event.target.sequence=="reverse" then
			
			--shootFireBall()
			local timer = timer.performWithDelay(0,shootFireBall,math.random(1,1))
			timer.params = { paramOne = event.target}
			local currentStage = initGame
			event.target.insideItem.transitions[#event.target.insideItem.transitions+1]=transition.to(true,{delay=math.random(3000,7000),onComplete = function() 
																			if initGame>endGame and currentStage==initGame then
																				event.target:setSequence("start") 
																				event.target:play() 
																				event.target.insideItem.alpha=0
																				event.target.x=math.random(50,display.contentWidth-50)
																		     	event.target.y=math.random(50,display.contentHeight-50)
																		     	event.target.insideItem.x = event.target.x
																		     	event.target.insideItem.y = event.target.y
																		   end
																		    end},1)
		end
	end
end



return _effects
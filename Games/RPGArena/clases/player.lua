
local _player = {}

local options = 
	{

		width = 32,
		height = 32,
		numFrames = 36,

		sheetContentWidth = 288,
		sheetContentHeight = 128,
	}

local sheet = graphics.newImageSheet( "images/sprites/players.png", options )
local sequenceThief ={ 
					{ name="down", start=7, count=3, time=1000, loopDirection="bounce" },
					{ name= "left", start=16, count=3, time=1000,  loopDirection="bounce" },
 					{ name="right", start=25, count=3, time=1000, loopDirection="bounce" },
 					{ name= "up", start=34, count=3, time=1000, loopDirection="bounce" }
 				}
local sequenceSoldier ={ 
					{ name="down", start=4, count=3, time=1000, loopDirection="bounce" },
					{ name= "left", start=13, count=3, time=1000,  loopDirection="bounce" },
 					{ name="right", start=22, count=3, time=1000, loopDirection="bounce" },
 					{ name= "up", start=31, count=3, time=1000, loopDirection="bounce" }
 				}
local sequenceWarrior ={ 
					{ name="down", start=1, count=3, time=1000, loopDirection="bounce" },
					{ name= "left", start=10, count=3, time=1000,  loopDirection="bounce" },
 					{ name="right", start=19, count=3, time=1000, loopDirection="bounce" },
 					{ name= "up", start=28, count=3, time=1000, loopDirection="bounce" }
 				}

 local sequences = {
  sequenceThief,
  sequenceSoldier, 
  sequenceWarrior
} 

 local sequencesName = {
  "Thief",
  "Soldier",
  "Warrior",
}


function _player.new(sceneGroup,sprite)
	local spriteGroup = display.newGroup()

 	drawPlayer(spriteGroup,sequences[sprite])
	
	-- INIT STATS
	spriteGroup.life=characters[sprite].life
    spriteGroup.currentLife=spriteGroup.life
	spriteGroup.armor=characters[sprite].armor
	spriteGroup.speed=characters[sprite].speed
	spriteGroup.currentSpeed=characters[sprite].speed
	spriteGroup.meleeAttackDamage=characters[sprite].meleeAttackDamage
	spriteGroup.meleeAttackDelay=characters[sprite].meleeAttackDelay
	spriteGroup.distanceAttackDelay=characters[sprite].distanceAttackDelay
	spriteGroup.distanceAttackDamage=characters[sprite].distanceAttackDamage
	spriteGroup.distanceAttackSpeedShot=characters[sprite].distanceAttackSpeedShot
	spriteGroup.maxAmmo = characters[sprite].maxAmmo
	spriteGroup.bleed = 0
	spriteGroup.ammo = spriteGroup.maxAmmo
	spriteGroup.name=sequencesName[sprite]
	-- FINISH STATS

	sceneGroup:insert(spriteGroup)
	return spriteGroup
end

function drawPlayer(sceneGroup,selectedSequence)

	local sprite = display.newSprite( sheet, selectedSequence )
	
	sprite:setSequence("down")
	sprite:play()

	sceneGroup:insert(sprite)
end


return _player
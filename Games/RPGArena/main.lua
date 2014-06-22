display.setStatusBar( display.HiddenStatusBar )

local composer = require( "composer" )


endGame = 0
initGame = 0
level = 0
spriteSelected = nil
currentMap = 0

composer.gold = 0
composer.savedPlayer = nil
composer.skillLevel=0


characters = {
		{   speed=9,
		    life=100,
		    armor=5,

		    melee="Daga",
		    meleeAttackDelay = 500, 
		    meleeAttackDamage = 1,
		    distanceAttackDelay = 300,
		    distanceAttackDamage = 1,
		    distanceAttackSpeedShot = 500,
		    maxAmmo = 30,
		    distance="Arco corto"
		},

		{   speed=6,
			life=150,
			  armor=5,
		    melee="Lanza corta",
			meleeAttackDelay = 1000,
			meleeAttackDamage = 2,
			distanceAttackDelay = 750,
			distanceAttackDamage = 3, 
			distanceAttackSpeedShot = 2000,
			maxAmmo = 20,
			distance="Arco medio"
		},

		{   speed=4,
			life=200,
			  armor=5,
		    melee="Espada larga",
			meleeAttackDelay = 2000,
			meleeAttackDamage = 3,
			distanceAttackDelay = 1250,
			distanceAttackDamage = 5,
			distanceAttackSpeedShot = 1000,
		    maxAmmo = 10,
			distance="Arco largo"
		 },
}

		lifeGroup = display.newGroup()
		goldGroup = display.newGroup()


        display.newRoundedRect(lifeGroup, 0, 0, 125, 25, 10 )
        lifeGroup[1].strokeWidth = 3
        lifeGroup[1]:setFillColor( 0,0,0,0)
        lifeGroup[1]:setStrokeColor( 0 )
        lifeGroup[1].anchorX=0
        lifeGroup[1].anchorY=0
        lifeGroup[1].x=30
        lifeGroup[1].y=35

        display.newRoundedRect(lifeGroup, 0, 0, 125, 25, 10 )
        lifeGroup[2].strokeWidth = 0
        lifeGroup[2]:setFillColor( 200,0,0 )
        lifeGroup[2]:setStrokeColor( 0 )
        lifeGroup[2].anchorX=0
        lifeGroup[2].anchorY=0
        lifeGroup[2].x=30
        lifeGroup[2].y=35
 		lifeGroup.alpha=0



        display.newRoundedRect(goldGroup, 0, 0, 160, 40, 10 )
        goldGroup[1]:setFillColor( 255)
   
        goldGroup[1].anchorX=0
        goldGroup[1].anchorY=0
        goldGroup[1].x=35
        goldGroup[1].y=75
        goldGroup[1].alpha=0.5
  


        display.newEmbossedText(goldGroup,composer.gold,lifeGroup.x,lifeGroup.y,nil,30)
    	goldGroup[2].strokeWidth=30
 		goldGroup[2]:setFillColor(0,0,0)
 		goldGroup[2]:setStrokeColor(0,0,0)
 		goldGroup[2].anchorX=0
 		goldGroup[2].anchorY=0
        goldGroup[2].x=40
        goldGroup[2].y=75+3
   
   

        local items = require "clases.items"
        items.newDropItem("gold",goldGroup,false)
  		goldGroup[3].anchorX=0
 		goldGroup[3].anchorY=0
 		goldGroup[3]:scale(0.8,0.8)
        goldGroup[3].y=75+goldGroup[2].contentHeight/2+3

        local interface = require ("clases.ui")
        interface.updateGold()


 		if composer.player then
         lifeGroup[2].width=composer.player.currentLife*125/composer.player.lifeGroup[2]
	   	
		end


local backgroundMusic = audio.loadStream( "sounds/music.mp3" )

--local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )



composer:gotoScene("intro")
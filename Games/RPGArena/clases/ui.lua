local _ui = {}
local composer = require ("composer")

function _ui.updateLife()

        lifeGroup.alpha=1
         lifeGroup[2].width=composer.player.currentLife*125/composer.player.life
        if  lifeGroup[2].width< 0 then
              lifeGroup[2].width=0
        end
  
       if  lifeGroup[3] == nil then
             lifeGroup[3] = display.newText(lifeGroup,composer.player.currentLife.."/"..composer.player.life,0,0,nil,20)  
       else
             lifeGroup[3].text=composer.player.currentLife.."/"..composer.player.life
       end
            lifeGroup[3].x=lifeGroup[1].x+lifeGroup[1].contentWidth/2
            lifeGroup[3].y=lifeGroup[1].y+lifeGroup[3].contentHeight/2


end

function _ui.updateGold()
   goldGroup.alpha=1
    goldGroup[2].text=composer.gold
    goldGroup[3].x=goldGroup[2].x+goldGroup[3].contentWidth/2+ goldGroup[2].contentWidth
  
end

function _ui.setLevel(group, level)


     
     	local level = display.newText("Level " .. level,display.contentWidth-100,35,nil,30)
     	level.y = 50

     	group:insert(level)	

end


function _ui.prepareNewLevel(group)

        local countDown = 5
     
        local level = display.newText(countDown,display.contentWidth-100,25,nil,50)
        level.y = display.contentHeight/2
        level.x = display.contentWidth/2

        timer.performWithDelay(1000,function()  countDown=countDown-1 level.text=countDown  end,4)
        group:insert(level) 

end

return _ui
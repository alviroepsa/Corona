
local _items = {}
local composer = require( "composer" )
local utils = require("clases.utils")


function _items.newDropItem(typeCoin,group,isHitable)

	local itemGroup = display.newGroup()
	local options = 
		{
			width = 32,
			height = 32,
			numFrames =5,
			sheetContentWidth = 160,
			sheetContentHeight = 32,
		}

	local sheet = graphics.newImageSheet( "images/items.png", options )

	local sequence ={ 
						{ name="bronze", start=1, count=1 },
	 					{ name="silver", start=2, count=1 },
	 					{ name="gold", start=3, count=1 },
	 					{ name="heart", start=4, count=1 },
	 					{ name="arrows", start=5, count=1 }
	 				}

	local coin = display.newSprite(itemGroup, sheet, sequence )
	coin:scale(2,2)
	
	coin:setSequence(typeCoin)
	
	if isHitable then
		itemGroup.timers = {}
		itemGroup.timers[#itemGroup.timers+1] = timer.performWithDelay(10,function() playerTouchItem(itemGroup, true) end,0)
	    itemGroup.timers[#itemGroup.timers+1] = timer.performWithDelay(7000,function() if itemGroup~=nil then utils.cleanGroup(itemGroup) end end,0)
	 end
	group:insert(itemGroup)

    return itemGroup
end

function _items.newJarron(typeCoin,group,isHitable)

	local itemGroup = display.newGroup()
	local options = 
		{
			width = 32,
			height = 32,
			numFrames = 4,
			sheetContentWidth = 128,
			sheetContentHeight = 32,
		}

	local sheet = graphics.newImageSheet( "images/items/jarron.png", options )

	local sequence ={ 
						{ name="jarron1", start=1, count=1 },
	 					{ name="jarron2", start=2, count=1 },
	 					{ name="jarron3", start=3, count=1 },
	 					{ name="jarron4", start=4, count=1 }
	 				}

	local item = display.newSprite(itemGroup, sheet, sequence )
	item:scale(2,2)
	
	item:setSequence(typeCoin)
	
	if isHitable then
		itemGroup.timers = {}
		itemGroup.timers[#itemGroup.timers+1] = timer.performWithDelay(10,function() playerTouchItem(itemGroup, true) end,0)
	    itemGroup.timers[#itemGroup.timers+1] = timer.performWithDelay(7000,function() if itemGroup~=nil then utils.cleanGroup(itemGroup) end end,0)
	 end
	group:insert(itemGroup)

    return itemGroup
end

return _items
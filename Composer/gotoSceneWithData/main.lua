-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer"

local options = {
    effect = "flip",
    time = 500,
    params = { destroyedShips = 50  }
}
composer.gotoScene( "gameScene", options )

-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer"
-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- load scenetemplate.lua
composer.gotoScene( "game" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local alert

local options = {
	to = "alviro@epsa.upv.es",
	subject ="title",
	body = "showPopup"
}
alert = native.showPopup( "mail",options)

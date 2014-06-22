----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local mapa = require("maps")

---------------------------------------------------------------------------------

-- Tamaño de cada cuadro del juego   = Ej. 32x32 
tamCuadrados=32

local board = display.newGroup()
local tileBackgroundSettings = { width = tamCuadrados, height = tamCuadrados, numFrames = 9, sheetContentWidth=96, sheetContentHeight=96 }

--local tileBackground = graphics.newImageSheet("img/tile_set.png", tileBackgroundSettings)
--local tileBackground = graphics.newImageSheet("img/tile_set_sinbordes.png", tileBackgroundSettings)
local tileBackground = graphics.newImageSheet("images/castle.png", tileBackgroundSettings)

local _tablero = {}
function _tablero.dibujarEscenario(boardGroup, wallsGroup,mapa)


		for i=1,display.contentWidth/32 do

			for j=1,display.contentHeight/32 do
				local tipoCasilla = 5
				if i==1 then
					if j==1 then
						tipoCasilla=1
					elseif j== display.contentHeight/32 then
						tipoCasilla=7
					else
						tipoCasilla=4
					end
				elseif i==display.contentWidth/32 then
					if j==1 then
						tipoCasilla=3
					elseif j== display.contentHeight/32 then
						tipoCasilla=9
					else
						tipoCasilla=6
					end
				elseif j==1 then
						tipoCasilla=2

				elseif j==display.contentHeight/32 then
						tipoCasilla=8
				end

				local casilla = display.newImage(tipoCasilla==5 and boardGroup or wallsGroup,tileBackground,tipoCasilla)

				casilla.y=(j-1)*tamCuadrados+tamCuadrados/2
				casilla.x=(i-1)*tamCuadrados+tamCuadrados/2
			
			end
		end
end

return _tablero
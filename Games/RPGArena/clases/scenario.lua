----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local mapa = require("clases.maps")

---------------------------------------------------------------------------------

-- Tamaño de cada cuadro del juego   = Ej. 32x32 
tamCuadrados=32

local board = display.newGroup()
local tileBackgroundSettings = { width = tamCuadrados, height = tamCuadrados, numFrames = 12, sheetContentWidth=96, sheetContentHeight=128 }
local tileTrampsSettings = { width = tamCuadrados, height = tamCuadrados, numFrames = 3, sheetContentWidth=32, sheetContentHeight=96 }

--local tileBackground = graphics.newImageSheet("img/tile_set.png", tileBackgroundSettings)
--local tileBackground = graphics.newImageSheet("img/tile_set_sinbordes.png", tileBackgroundSettings)
local tileBackground
local tileTramps = graphics.newImageSheet("images/maps/traps.png", tileTrampsSettings)

local _tablero = {}
function _tablero.dibujarEscenario(boardGroup, wallsGroup,mapa,typeSprite, numMap)

	local sheet = nil

	if typeSprite == "castle" or typeSprite == nil then
		sheet = "images/maps/castleNew.png"
    elseif typeSprite == "desert" then
    	sheet = "images/maps/desertNew.png"	
	elseif typeSprite == "grass" then
		sheet = "images/maps/grassNew.png"
	elseif typeSprite == "rock" then
		sheet = "images/maps/rockNew.png"
	end

    tileBackground = graphics.newImageSheet(sheet, tileBackgroundSettings)

local positions = {}
	currentMap = math.random(1,#mapCastle)
	local mapa = mapCastle[ numMap ~= nil and numMap or currentMap]
	for i=1,#mapa do
			for j=1,#mapa[i] do

				local tipoTerreno = mapa[i][j]
				if tipoTerreno == 5 then
					local rand = math.random(1,20)
					if rand==1 then
						tipoTerreno=12
					elseif rand==2 then
						tipoTerreno=10
					elseif rand==3 then
						tipoTerreno=11
					else 
						tipoTerreno=5
					end
				end
				
				local casilla
				

				if tipoTerreno==30 then
					if math.random(1,5) ==1 then
						positions[#positions+1] = {(i-1)*tamCuadrados+display.screenOriginY+20,(j-1)*tamCuadrados+20} 
					end
				end

				if tipoTerreno > 20 and tipoTerreno<25 then
 					casilla = display.newImage(board,tileTramps,tipoTerreno-20)

				else
 					casilla = display.newImage(board,tileBackground,tipoTerreno==30 and 5 or tipoTerreno)
				end

			
				casilla.setAnchorX=0
				casilla.setAnchorY=0
				
				casilla.y=(i-1)*tamCuadrados+display.screenOriginY+20
				casilla.x=(j-1)*tamCuadrados+20
				
				casilla.coordX=i
				casilla.coordY=j
				casilla.tipo = tipoTerreno
			--	casilla:addEventListener("tap",function() mostrarEdificios(1) end)
				boardGroup:insert(casilla)
			end
		end
		return positions
end

return _tablero
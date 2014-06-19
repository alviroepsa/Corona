-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local mapView

local latitudeText
local longitudeText

mapView=native.newMapView( display.contentWidth/2, display.contentHeight/2,300,300)

local function mapViewTapListener(event)
	if latitudeText~=nil then
		latitudeText:removeSelf()
	end
	latitudeText = display.newText(event.latitude,display.contentWidth/2,20,nil,12)

	if longitudeText~=nil then
		longitudeText:removeSelf()
	end
	longitudeText = display.newText(event.longitude,display.contentWidth/2,40,nil,12)
end
	

if (mapView) then
	mapView:addEventListener("mapLocation",mapViewTapListener)

	-- Madrid coords
	mapView:setCenter(40.41677540,-3.70379019999995,true)
end


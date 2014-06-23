-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


local function accelerometerlistener ( event )
    if event.isShake then
        print( "SHAKE")
    end

    print("Instant")
    print(  event.xInstant , event.yInstant , event.zInstant )
    
    print("Gravity")
    print(  event.xGravity , event.yGravity , event.zGravity )

    return true
end

Runtime:addEventListener( "accelerometer", accelerometerlistener  )
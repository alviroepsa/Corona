-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
   local json = require("json")
   local path = system.pathForFile( "userInfo.json", system.DocumentsDirectory )

   local file = io.open( path, "w" )
   
   io.close(file)



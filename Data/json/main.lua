-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local json = require("json")

local userInfo = {
  	 name = "Alfredo",
	 surname = "Vilaplana",
	 birthdate = "1/1/1980",
	 city = "Alcoy"
}   

local jsonFormat = json.encode(userInfo)
print("JSON FORMAT " .. jsonFormat)

local recoverUserInfo = json.decode(jsonFormat)
print("TABLE FORMAT " ..recoverUserInfo.name .. " " .. recoverUserInfo.surname)
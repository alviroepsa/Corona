-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local sqlite = require("sqlite3")

local path = system.pathForFile("data.db", system.DocumentsDirectory)

local data = sqlite.open(path)

data:exec("CREATE TABLE IF NOT EXISTS USER(id INTEGER PRIMARY KEY, name TEXT, points INTEGER); ")
data:exec("DELETE FROM USER")

for i = 1,10 do
	data:exec("INSERT INTO USER (name,points) VALUES('user"..i.."',"..math.random(0,100)..");")
end

for n in data:nrows("SELECT * FROM USER") do
	print(n.name .. " " .. n.points)
end

data:close()
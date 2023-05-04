----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")

----- Loaded Modules -----

local DataHandler = require(ServerScriptService.Server.DataHandler)
local MobHandler = require(ServerScriptService.Server.MobHandler)

DataHandler.Init()
MobHandler.Init()

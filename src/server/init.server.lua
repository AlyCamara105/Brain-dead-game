----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")

----- Loaded Modules -----

local DataHandler = require(ServerScriptService.Server.DataHandler)
local MobHandler = require(ServerScriptService.Server.MobHandler)
local LootPlanHandler = require(ServerScriptService.Server.LootPlanHandler)
local MarketplaceHandler = require(ServerScriptService.Server.MarketplaceHandler)

DataHandler.Init()
MarketplaceHandler.Init()
MobHandler.Init()
LootPlanHandler.Init()

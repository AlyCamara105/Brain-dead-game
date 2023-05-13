----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")

----- Loaded Modules -----

local DataHandler = require(ServerScriptService.Server.DataHandler)
local MobHandler = require(ServerScriptService.Server.MobHandler)
local LootPlanHandler = require(ServerScriptService.Server.LootPlanHandler)
local MarketplaceHandler = require(ServerScriptService.Server.MarketplaceHandler)
local SignalManager = require(ServerScriptService.Server.SignalManager)
local PlayerHandler = require(ServerScriptService.Server.PlayerHandler)

SignalManager.Init()
DataHandler.Init()
PlayerHandler.Init()
MarketplaceHandler.Init()
MobHandler.Init()
LootPlanHandler.Init()

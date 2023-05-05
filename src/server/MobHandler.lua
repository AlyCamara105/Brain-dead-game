local module = {}

----- Services -----

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Signal = require(ReplicatedStorage.Shared.Signal)
local SignalManager = require(ServerScriptService.Server.SignalManager)

----- Loaded Modules -----

local Zone = require(ReplicatedStorage.Shared.Zone)
local ServerData = require(ServerScriptService.Server.ServerData)

----- Private Variables -----

local Mobs = {}

----- Private Functions -----

local function AddMobTag(mobPlaceholder, mobTag)
	CollectionService:AddTag(mobPlaceholder, mobTag)
end

local function GetPlayerFromTags(itemTags)
	for _, tag in ipairs(itemTags) do
		if Players:FindFirstChild(tag) then
			return Players[tag]
		end
	end
	return nil
end

local function AddMobZone(mobPlaceholder, mobTag)
	local zone = Zone.new(mobPlaceholder)

	Mobs[mobTag] = { Zone = zone, MobPlaceholder = mobPlaceholder, MobStates = {} }

	zone.itemEntered:Connect(function(item)
		local itemTags = CollectionService:GetTags(item)
		local player = GetPlayerFromTags(itemTags)

		if player then
			local playerData = ServerData.PlayerDataMasters[player].Profile.Data
			local playerDamage = playerData.Damage
			local playerMobData = Mobs[mobTag].MobStates[player] or {Health = 100, PremiumCurrency = 10} -- Make a function that gets the relevant mob data

			local newMobHealth = playerMobData.Health - playerDamage
			if newMobHealth <= 0 then
				SignalManager["AwardPlayerPremiumCurrency"]:Fire(player, playerMobData.PremiumCurrency)
				-- Send the client an event for feedback
			else
				playerMobData.Health = newMobHealth
				-- Send the client an event for feedback
			end
		end
	end)
end

local function InitializeMobs(mobsFolder)
	-- For every area folder in the mobs folder
	for _, areaFolder in ipairs(mobsFolder:GetChildren()) do
		local mobArea = areaFolder.Name
		-- For every row folder in the mob folder
		for _, rowFolder in ipairs(areaFolder:GetChildren()) do
			local mobRow = rowFolder.Name
			-- For every mob in the row folder
			for mobNumber, mobPlaceholder in ipairs(rowFolder:GetChildren()) do
				local mobTag = mobArea .. "_" .. mobRow .. "_" .. mobNumber
				AddMobTag(mobPlaceholder, mobTag)
				AddMobZone(mobPlaceholder, mobTag)
			end
		end
	end
end

----- Public Functions -----

----- Initialization -----
module.Init = function()
	local mobsFolder = game.Workspace.Map.Mobs

	InitializeMobs(mobsFolder)
end

----- Signal Connections -----

return module

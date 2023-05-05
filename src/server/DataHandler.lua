local module = {}

----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local ProfileService = require(ServerScriptService.Server.ProfileService)
local ReplicaService = require(ServerScriptService.Server.ReplicaService)
local ServerData = require(ServerScriptService.Server.ServerData)
local Signal = require(ReplicatedStorage.Shared.Signal)
local SignalManager = require(ServerScriptService.Server.SignalManager)

----- Private Variables -----

local Players = game:GetService("Players")
local ProfileTemplate = {
	PowerUnit = 0,
	PremiumCurrency = 0,
	SpecialDrops = {},
	Pets = {},
	Rebirths = 0,
	Skins = {},
	Skills = {},
	Boosts = { PowerUnitBoost = 0, PremiumCurrencyBoost = 0, DamageBoost = 0 },
	RebirthPoints = 0,
	PvpCurrency = 0,
	DungeonRank = 0,
	DungeionLevel = 0,
	Transportation = {},
	Damage = 50,
}
local ProfileStore = ProfileService.GetProfileStore("PlayerData", ProfileTemplate)
local PlayerWriteLib = ReplicatedStorage.Shared.PlayerWriteLib
local TimeLastPowerUnitGiven = 0
local Ceil = math.ceil

----- Private Functions -----

local function PlayerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId) -- GDPR compliance
		profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
		profile:ListenToRelease(function()
			-- The profile could've been loaded on another Roblox server:
			ServerData.GetPlayerReplica(player):Destroy()
			ServerData.PlayerDataMasters[player] = nil
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			-- A profile has been successfully loaded:
			local replica = ReplicaService.NewReplica({
				ClassToken = ReplicaService.NewClassToken(player.Name .. player.UserId),
				Tags = { Player = player },
				Data = profile.Data,
				Replication = "All",
				WriteLib = PlayerWriteLib,
			})
			ServerData.PlayerDataMasters[player] = { Profile = profile, Replica = replica }
		else
			-- Player left before the profile loaded:
			profile:Release()
		end
	else
		-- The profile couldn't be loaded possibly due to other
		--   Roblox servers trying to load this profile at the same time:
		player:Kick()
	end
end

local function SetPremiumCurrency(replica, amount)
	if replica then
		replica:SetValue({ "PremiumCurrency" }, amount)
	end
end

-- Add a set damage function

local function SetRebirths(replica, amount)
	if replica then
		replica:SetValue({ "Rebirths" }, amount)
	end
end

local function SetPvpCurrency(replica, amount)
	if replica then
		replica:SetValue({ "PvpCurrency" }, amount)
	end
end

local function SetDungeonRank(replica, amount)
	if replica then
		replica:SetValue({ "DungeonRank" }, amount)
	end
end

local function SetDungeonLevel(replica, level)
	if replica then
		replica:SetValue({ "DungeonLevel" }, level)
	end
end

local function SetRebirthPoints(replica, points)
	if replica then
		replica:SetValue({ "RebirthPoints" }, points)
	end
end

local function SetSpecialDrops(replica, specialDrop, amount)
	if replica then
		replica:Write("SetSpecialDrops", specialDrop, amount)
	end
end

local function SetPets(replica, pet, amount)
	if replica then
		replica:Write("SetPets", pet, amount)
	end
end

local function SetSkins(replica, value)
	if replica then
		replica:ArrayInsert({ "Skins" }, value)
	end
end

local function SetSkills(replica, value)
	if replica then
		replica:ArrayInsert({ "Skills" }, value)
	end
end

local function SetTransportation(replica, value)
	if replica then
		replica:ArrayInsert({ "Transportation" }, value)
	end
end

local function SetPowerUnit(replica, newPower)
	if replica then
		replica:SetValue({ "PowerUnit" }, newPower)
	end
end

local function GetPowerUnitIncrement(premiumCurrency)
	return premiumCurrency + Ceil(premiumCurrency / 4) + 1
end

local function GetNewPowerUnit(premiumCurrency, oldPower)
	--[[
		Could optimize this by making the increment of power only update when the premium currency changes and having that increment
		saved somewhere to be added to the oldPower here, ideally not in the datastore as it could easily be calculated.
	]]
	return oldPower + GetPowerUnitIncrement(premiumCurrency)
end

local function SetPowerUnits()
	for _, master in pairs(ServerData.PlayerDataMasters) do
		if master.Profile:IsActive() then
			local replica = master.Replica
			SetPowerUnit(replica, GetNewPowerUnit(replica.Data.PremiumCurrency, replica.Data.PowerUnit))
		end
	end
end

----- Public Functions -----

----- Initialize -----
module.Init = function()
	-- In case Players have joined the server earlier than this function ran
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(PlayerAdded, player)
	end

	----- Connections -----
	Players.PlayerAdded:Connect(PlayerAdded)

	Players.PlayerRemoving:Connect(function(player)
		local profile = ServerData.GetPlayerProfile(player)
		if profile ~= nil then
			profile:Release()
		end
	end)

	RunService.Heartbeat:Connect(function()
		local currentTime = tick()
		local difference = currentTime - TimeLastPowerUnitGiven
		if difference >= 1 then
			TimeLastPowerUnitGiven = currentTime
			SetPowerUnits()
		end
	end)
end

----- Signal Connections -----
SignalManager["AwardPlayerPremiumCurrency"] = Signal.new()
SignalManager["AwardPlayerPremiumCurrency"]:Connect(function(player, premiumCurrency)
	print("Received an event to update a player's premium currency")
	local playerProfile = ServerData.GetPlayerProfile(player)
	if playerProfile then
		print("The player's profile exists!")
		local oldPremiumCurrency = playerProfile.Data.PremiumCurrency
		local newPremiumCurrency = oldPremiumCurrency + premiumCurrency
		SetPremiumCurrency(ServerData.GetPlayerReplica(player), newPremiumCurrency)
	end
end)

return module

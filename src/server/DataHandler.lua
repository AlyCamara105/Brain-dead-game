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
local RebirthInfo = require(ReplicatedStorage.Shared.RebirthInfo)
local PowerModeInfo = require(ReplicatedStorage.Shared.PowerModeInfo)

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
	Damage = 0,
	PowerModeLevel = 0,
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

local function GetBoostMultiplier(boost)
	return 1 + (boost / 100)
end

local function SetPowerModeLevel(replica, amount)
	if replica then
		replica:SetValue({ "PowerModeLevel" }, amount)
	end
end

local function SetPremiumCurrency(replica, amount)
	if replica then
		replica:SetValue({ "PremiumCurrency" }, amount)
	end
end

local function GetNewPremuimCurrency(oldPremiumCurrency, incrementPremiumCurrency, premiumCurrencyBoost)
	return oldPremiumCurrency + math.ceil(incrementPremiumCurrency * GetBoostMultiplier(premiumCurrencyBoost))
end

local function SetDamage(replica, amount)
	if replica then
		replica:SetValue({ "Damage" }, amount)
	end
end

local function GetNewDamage(powerUnit, damageBoost)
	return math.ceil(powerUnit * GetBoostMultiplier(damageBoost))
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

local function GetRebirthsIncrement()
	return 1
end

local function GetNewRebirth(oldRebirth)
	return oldRebirth + GetRebirthsIncrement()
end

local function SetRebirths(replica, amount)
	if replica then
		replica:SetValue({ "Rebirths" }, amount)
	end
end

local function GetRebirthPointsIncrement()
	return 1
end

local function SetRebirthPoints(replica, points)
	if replica then
		replica:SetValue({ "RebirthPoints" }, points)
	end
end

local function SetDamageBoost(replica, amount)
	if replica then
		replica:SetValue({ "Boosts", "DamageBoost" }, amount)
	end
end

local function SetPremiumCurrencyBoost(replica, amount)
	if replica then
		replica:SetValue({ "Boosts", "PremiumCurrencyBoost" }, amount)
	end
end

local function SetPowerUnitBoost(replica, amount)
	if replica then
		replica:SetValue({ "Boosts", "PowerUnitBoost" }, amount)
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

local function GetNewPowerUnit(premiumCurrency, oldPower, powerUnitBoost)
	--[[
		Could optimize this by making the increment of power only update when the premium currency changes and having that increment
		saved somewhere to be added to the oldPower here, ideally not in the datastore as it could easily be calculated.
	]]
	return oldPower + math.ceil(GetPowerUnitIncrement(premiumCurrency) * GetBoostMultiplier(powerUnitBoost))
end

local function SetPowerUnits()
	for _, master in pairs(ServerData.PlayerDataMasters) do
		if master.Profile:IsActive() then
			local replica = master.Replica
			local playerData = replica.Data
			SetPowerUnit(
				replica,
				GetNewPowerUnit(playerData.PremiumCurrency, playerData.PowerUnit, playerData.Boosts.PowerUnitBoost)
			)
			SetDamage(replica, GetNewDamage(playerData.PowerUnit, playerData.Boosts.DamageBoost))
		end
	end
end

local function ProcessRebirthRequest(playerReplica)
	local playerData = playerReplica.Data
	if RebirthInfo.CanRebirth(playerData.Rebirths, playerData.PremiumCurrency) then
		SetPremiumCurrency(playerReplica, 0)
		SetPowerUnit(playerReplica, 0)
		SetRebirths(playerReplica, GetNewRebirth(playerData.Rebirths))
		SetRebirthPoints(playerReplica, playerData.RebirthPoints + GetRebirthPointsIncrement())
		SetDamageBoost(playerReplica, playerData.Boosts.DamageBoost + RebirthInfo.GetRebirthDamageBoost(playerData.Rebirths))
		SetPowerUnitBoost(
			playerReplica,
			playerData.Boosts.PowerUnitBoost + RebirthInfo.GetRebirthPowerUnitBoost(playerData.Rebirths)
		)
	end
end

local function ProcessPowerUpRequest(playerReplica)
	local playerData = playerReplica.Data
	local oldPowerModeLevel = playerData.PowerModeLevel
	local playerSpecialDrops = playerData.SpecialDrops
	if PowerModeInfo.CanPowerUp(oldPowerModeLevel, playerSpecialDrops) then
		local newPowerModeLevelInfo = PowerModeInfo.PowerModeLevels[oldPowerModeLevel + 1]

		for drop, cost in pairs(newPowerModeLevelInfo.specialDrops) do
			SetSpecialDrops(playerReplica, drop, playerSpecialDrops[drop] - cost)
		end

		SetPremiumCurrencyBoost(playerReplica, playerData.Boosts.PremiumCurrencyBoost + newPowerModeLevelInfo.PremiumCurrency)
		SetPowerModeLevel(playerReplica, oldPowerModeLevel + 1)
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
SignalManager["GivePremiumCurrency"] = Signal.new()
SignalManager["GivePremiumCurrency"]:Connect(function(player, incrementPremiumCurrency)
	local replica = ServerData.GetPlayerReplica(player)
	if replica then
		local playerData = replica.Data
		SetPremiumCurrency(
			replica,
			GetNewPremuimCurrency(playerData.PremiumCurrency, incrementPremiumCurrency, playerData.Boosts.PremiumCurrencyBoost)
		)
	end
end)

return module

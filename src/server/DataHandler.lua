local module = {}

----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local ProfileService = require(ServerScriptService.Server.ProfileService)
local ReplicaService = require(ServerScriptService.Server.ReplicaService)

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
}
local ProfileStore = ProfileService.GetProfileStore("PlayerData", ProfileTemplate)
local PlayerWriteLib = ReplicatedStorage.Shared.PlayerWriteLib
local Masters = {}
local TimeLastPowerUnitGiven = 0

----- Private Functions -----

local function PlayerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId) -- GDPR compliance
		profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
		profile:ListenToRelease(function()
			-- The profile could've been loaded on another Roblox server:
			Masters[player].Replica:Destroy()
			Masters[player] = nil
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
			Masters[player] = { Profile = profile, Replica = replica }
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
	replica:SetValue({ "PremiumCurrency" }, amount)
end

local function SetRebirths(replica, amount)
	replica:SetValue({ "Rebirths" }, amount)
end

local function SetPvpCurrency(replica, amount)
	replica:SetValue({ "PvpCurrency" }, amount)
end

local function SetDungeonRank(replica, amount)
	replica:SetValue({ "DungeonRank" }, amount)
end

local function SetDungeonLevel(replica, level)
	replica:SetValue({ "DungeonLevel" }, level)
end

local function SetRebirthPoints(replica, points)
	replica:SetValue({ "RebirthPoints" }, points)
end

local function SetSpecialDrops(replica, specialDrop, amount)
	replica:Write("SetSpecialDrops", specialDrop, amount)
end

local function SetPets(replica, pet, amount)
	replica:Write("SetPets", pet, amount)
end

local function SetSkins(replica, value)
	replica:ArrayInsert({ "Skins" }, value)
end

local function SetSkills(replica, value)
	replica:ArrayInsert({ "Skills" }, value)
end

local function SetTransportation(replica, value)
	replica:ArrayInsert({ "Transportation" }, value)
end

local function SetPowerUnit(replica, newPower)
	replica:SetValue({ "PowerUnit" }, newPower)
end

local function GetNewPower(oldPower)
	return oldPower + 12
end

local function SetPowerUnits()
	for _, master in pairs(Masters) do
		if master.Profile:IsActive() then
			local replica = master.Replica
			SetPowerUnit(replica, GetNewPower(replica.Data.PowerUnit))
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
		local profile = Masters[player].Profile
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

return module

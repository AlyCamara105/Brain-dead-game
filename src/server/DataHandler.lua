local module = {}

----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")

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
local Profiles = {} -- [player] = profile
local Replicas = {} -- [player] = replica

----- Private Functions -----

local function PlayerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId) -- GDPR compliance
		profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)

		local playerReplica = ReplicaService.NewReplica({
			ClassToken = ReplicaService.NewClassToken(player.Name .. player.UserId),
			Tags = {},
			Data = profile.Data,
			Replication = "All",
		})
		Replicas[player] = playerReplica

		profile:ListenToRelease(function()
			Profiles[player] = nil
			-- The profile could've been loaded on another Roblox server:
			Replicas[player]:Destroy()
			Replicas[player] = nil
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			Profiles[player] = profile
			-- A profile has been successfully loaded:
			print(player.Name .. "'s profile has loaded successfully", profile.Data)
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
		local profile = Profiles[player]
		if profile ~= nil then
			profile:Release()
		end
	end)
end

return module

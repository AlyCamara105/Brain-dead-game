local module = {}

----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local ProfileService = require(ServerScriptService.Server.ProfileService)
local ReplicaService = require(ServerScriptService.Server.ReplicaService)
local ServerData = require(ServerScriptService.Server.ServerData)
local SignalManager = require(ServerScriptService.Server.SignalManager)
local RebirthInfo = require(ReplicatedStorage.Shared.RebirthInfo)
local PowerModeInfo = require(ReplicatedStorage.Shared.PowerModeInfo)
local PetsInfo = require(ReplicatedStorage.Shared.PetsInfo)
local CostumesInfo = require(ReplicatedStorage.Shared.CostumesInfo)
local TransportationInfo = require(ReplicatedStorage.Shared.TransportationInfo)
local SkillsInfo = require(ReplicatedStorage.Shared.SkillsInfo)
local LootPlanHandler = require(ServerScriptService.Server.LootPlanHandler)
local TeleportsInfo = require(ReplicatedStorage.Shared.TeleportInfo)
local CharacterHandler = require(ServerScriptService.Server.CharacterHandler)

----- Private Variables -----

local Players = game:GetService("Players")
local ProfileTemplate = {
	PowerUnit = 0,
	PremiumCurrency = 0,
	Damage = 0,
	SpecialDrops = {},
	Pets = {},
	PetCapsuleHatchAmount = 1,
	EquippedPets = {},
	MaxPetSlots = 25,
	MaxEquippedPets = 4,
	Transportation = {},
	EquippedTransport = "",
	PowerModeLevel = 0,
	Costumes = {},
	EquippedCostume = "",
	Skills = { "Rocket" },
	EquippedSkill = "Rocket",
	Boosts = {
		PowerUnitBoost = 0,
		PremiumCurrencyBoost = 0,
		DamageBoost = 0,
		SpeedBoost = 0,
		PetCapsuleBoost = 0,
	},
	Rebirths = 0,
	RebirthPoints = 0,
	PremiumCurrencyRebirthPoints = 0,
	PetSlotRebirthPoints = 0,
	Has10xMythicalPetLuck = false,
	VIP = false,
	--[[
	PvpCurrency = 0,
	DungeonRank = 0,
	DungeionLevel = 0,
	--]]
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

local function PlayerRemoving(player)
	local profile = ServerData.GetPlayerProfile(player)
	if profile ~= nil then
		profile:Release()
	end
end

--[[local function SetPvpCurrency(replica, amount)
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
end]]

local function SetMaxPetSlots(replica, amount)
	if replica then
		replica:SetValue({ "MaxPetSlots" }, amount)
	end
end

local function SetPremiumCurrencyRebirthPoints(replica, amount)
	if replica then
		replica:SetValue({ "PremiumCurrencyRebirthPoints" }, amount)
	end
end

local function SetPetSlotRebirthPoints(replica, amount)
	if replica then
		replica:SetValue({ "PetSlotRebirthPoints" }, amount)
	end
end

local function GetMultiplier(boost)
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
	return oldPremiumCurrency + math.ceil(incrementPremiumCurrency * GetMultiplier(premiumCurrencyBoost))
end

local function SetDamage(replica, amount)
	if replica then
		replica:SetValue({ "Damage" }, amount)
	end
end

local function GetNewDamage(powerUnit, damageBoost)
	return math.ceil(powerUnit * GetMultiplier(damageBoost))
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

local function SetSpeedBoost(replica, amount)
	if replica then
		replica:SetValue({ { "Boosts", "SpeedBoost" }, amount })
	end
end

local function SetSpecialDrops(replica, specialDrop, amount)
	if replica then
		replica:Write("SetSpecialDrops", specialDrop, amount)
	end
end

local function AddSpecialDrops(replica, specialDrop, amount)
	local data = replica.Data
	local oldSpecialDrop = data.SpecialDrops[specialDrop]
	if oldSpecialDrop then
		SetSpecialDrops(replica, specialDrop, oldSpecialDrop + amount)
	else
		SetSpecialDrops(replica, specialDrop, amount)
	end
end

local function GetPetCount(pets)
	local count = {}
	for _, pet in ipairs(pets) do
		if count[pet] then
			count[pet] += 1
		else
			count[pet] = 1
		end
	end
	return count
end

local function RemoveEquippedPet(replica, pet, amount)
	if replica then
		local function _removeEquippedPet()
			local petIndex = table.find(replica.Data.EquippedPets, pet)
			replica:ArrayRemove("EquippedPets", petIndex)
			SetDamageBoost(replica, replica.Data.Boosts.DamageBoost - PetsInfo.Pets[pet].DamageBoost)
		end
		if amount == math.huge then
			local petCount = GetPetCount(replica.Data.EquippedPets)
			for _ = 1, petCount[pet], 1 do
				_removeEquippedPet()
			end
		else
			for _ = 1, amount, 1 do
				_removeEquippedPet()
			end
		end
	end
end

local function EquipPet(replica, pet)
	if replica then
		replica:ArrayInsert("EquippedPets", pet)
		SetDamageBoost(replica, replica.Data.Boosts.DamageBoost + PetsInfo.Pets[pet].DamageBoost)
	end
end

local function SetPets(replica, pet, amount)
	if replica then
		replica:Write("SetPets", pet, amount)
	end
end

local function AddPet(replica, pet, amount)
	if replica then
		local oldPetAmount = replica.Data.Pets[pet]
		if oldPetAmount then
			SetPets(replica, pet, oldPetAmount + amount)
		else
			SetPets(replica, pet, amount)
		end
	end
end

local function AddCostume(replica, value)
	if replica then
		replica:ArrayInsert({ "Costumes" }, value)
	end
end

local function SetEquippedCostume(replica, value)
	if replica then
		replica:SetValue("EquippedCostume", value)
	end
end

local function UnequipCostume(replica)
	local data = replica.Data
	local oldCostume = data.EquippedCostume
	SetEquippedCostume(replica, "")
	SetPowerUnitBoost(replica, data.Boosts.PowerUnitBoost - CostumesInfo.Costumes[oldCostume].PowerUnitBoost)
end

local function EquipCostume(replica, costume)
	SetEquippedCostume(replica, costume)
	SetPowerUnitBoost(replica, replica.Data.Boosts.PowerUnitBoost + CostumesInfo.Costumes[costume].PowerUnitBoost)
end

local function AddSkill(replica, skill)
	if replica then
		replica:ArrayInsert({ "Skills" }, skill)
	end
end

local function SetEquippedSkill(replica, skill)
	if replica then
		replica:SetValue({ "EquippedSkill" }, skill)
	end
end

local function EquipSkill(replica, skill)
	SetEquippedSkill(replica, skill)
	SetDamageBoost(replica, replica.Data.Boosts.DamageBoost + SkillsInfo.Skills[skill].DamageBoost)
end

local function UnequipSkill(replica)
	local data = replica.Data
	SetDamageBoost(replica, data.Boosts.DamageBoost - SkillsInfo.Skills[data.EquippedSkill].DamageBoost)
end

local function AddTransportation(replica, value)
	if replica then
		replica:ArrayInsert({ "Transportation" }, value)
	end
end
local function SetEquippedTransport(replica, value)
	if replica then
		replica:SetValue({ "EquippedTransport" }, value)
	end
end

local function UnequipTransport(replica)
	local data = replica.Data
	local boosts = data.Boosts
	local oldTransport = data.EquippedTransport
	SetEquippedTransport(replica, "")
	SetSpeedBoost(replica, boosts.SpeedBoost - TransportationInfo.Transportation[oldTransport].SpeedBoost)
	CharacterHandler.SetCharacterWalkSpeed(replica.Tags.Player, GetMultiplier(boosts.SpeedBoost))
end

local function EquipTransport(replica, transport)
	local data = replica.Data
	local boosts = data.Boosts
	SetEquippedTransport(replica, transport)
	SetSpeedBoost(replica, boosts.SpeedBoost + TransportationInfo.Transportation[transport].SpeedBoost)
	CharacterHandler.SetCharacterWalkSpeed(replica.Tags.Player, GetMultiplier(boosts.SpeedBoost))
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
	return oldPower + math.ceil(GetPowerUnitIncrement(premiumCurrency) * GetMultiplier(powerUnitBoost))
end

local function ProcessRebirthRequest(replica)
	local playerData = replica.Data
	if RebirthInfo.CanRebirth(playerData.Rebirths, playerData.PremiumCurrency) then
		SetPremiumCurrency(replica, 0)
		SetPowerUnit(replica, 0)
		SetRebirths(replica, GetNewRebirth(playerData.Rebirths))
		SetRebirthPoints(replica, playerData.RebirthPoints + GetRebirthPointsIncrement())
		SetDamageBoost(replica, playerData.Boosts.DamageBoost + RebirthInfo.GetRebirthDamageBoost(playerData.Rebirths))
		SetPowerUnitBoost(replica, playerData.Boosts.PowerUnitBoost + RebirthInfo.GetRebirthPowerUnitBoost(playerData.Rebirths))
	end
end

local function ProcessPowerUpRequest(replica)
	local playerData = replica.Data
	local oldPowerModeLevel = playerData.PowerModeLevel
	local playerSpecialDrops = playerData.SpecialDrops
	if PowerModeInfo.CanPowerUp(oldPowerModeLevel, playerSpecialDrops) then
		local newPowerModeLevelInfo = PowerModeInfo.PowerModeLevels[oldPowerModeLevel + 1]

		for drop, cost in pairs(newPowerModeLevelInfo.specialDrops) do
			SetSpecialDrops(replica, drop, playerSpecialDrops[drop] - cost)
		end

		SetPremiumCurrencyBoost(replica, playerData.Boosts.PremiumCurrencyBoost + newPowerModeLevelInfo.PremiumCurrencyBoost)
		SetPowerModeLevel(replica, oldPowerModeLevel + 1)
	end
end

local function HasPet(pets, pet)
	return pets[pet] and pets[pet] > 0
end

local function ProcessEquipPetRequest(replica, pet)
	local data = replica.Data
	local pets = data.Pets
	if HasPet(pets, pet) then
		local equippedPets = data.EquippedPets
		if #equippedPets < data.MaxEquippedPets then
			local equippedPetCount = GetPetCount(equippedPets)[pet] or 0
			if equippedPetCount < pets[pet] then
				EquipPet(replica, pet)
			end
		end
	end
end

local function ProcessUnequipPetRequest(replica, pet)
	local data = replica.Data
	local pets = data.Pets
	if HasPet(pets, pet) then
		if table.find(data.EquippedPets, pet) then
			RemoveEquippedPet(replica, pet, 1)
		end
	end
end

local function ProcessDeletePetsRequest(replica, petsToDelete)
	local data = replica.Data
	local pets = data.Pets
	for pet, amountToDelete in pairs(petsToDelete) do
		if HasPet(pets, pet) then
			local petAmount = pets[pet]
			amountToDelete = math.clamp(amountToDelete, 0, petAmount)
			if amountToDelete == petAmount and table.find(data.EquippedPets, pet) then
				RemoveEquippedPet(replica, pet, math.huge)
			end
			SetPets(replica, pet, petAmount - amountToDelete)
		end
	end
end

local function ProcessFusePetRequest(replica, pet)
	local data = replica.Data
	local playerPets = data.Pets
	if HasPet(playerPets, pet) then
		local amountOfPet = playerPets[pet]
		if PetsInfo.CanFuse(pet, amountOfPet) then
			local pets = PetsInfo.Pets
			local petInfo = pets[pet]
			local fuseCost = petInfo.FuseCost
			if fuseCost == amountOfPet and table.find(data.EquippedPets, pet) then
				RemoveEquippedPet(replica, pet, math.huge)
			end
			SetPets(replica, pet, amountOfPet - fuseCost)
			AddPet(replica, petInfo.Fusion, 1)
		end
	end
end

local function HasRebirthPoints(replica)
	return replica.Data.RebirthPoints > 0
end

local function ProocessPremiumCurrencyRebirthPointsRequest(replica)
	local data = replica.Data
	if HasRebirthPoints(replica) then
		SetRebirthPoints(replica, data.RebirthPoints - 1)
		SetPremiumCurrencyRebirthPoints(replica, data.PremiumCurrencyRebirthPoints + 1)
		SetPremiumCurrencyBoost(replica, data.Boosts.PremiumCurrencyBoost + 5)
	end
end

local function HasCostume(replica, costume)
	return table.find(replica.Data.Costumes, costume)
end

local function ProcessPetSlotRebirthPointsRequest(replica)
	local data = replica.Data
	if HasRebirthPoints(replica) then
		SetRebirthPoints(replica, data.RebirthPoints - 1)
		SetPetSlotRebirthPoints(replica, data.PetSlotRebirthPoints + 1)
		SetMaxPetSlots(replica, data.MaxPetSlots + 1)
	end
end

local function ProcessBuyCostumeRequest(replica, costume)
	local data = replica.Data
	local oldPremiumCurrency = data.PremiumCurrency
	if not HasCostume(replica, costume) and CostumesInfo.CanBuyCostume(costume, data.Rebirths, oldPremiumCurrency) then
		SetPremiumCurrency(replica, oldPremiumCurrency - CostumesInfo.Costumes[costume].Cost)
		AddCostume(replica, costume)
	end
end

local function ProcessEquipCostumeRequest(replica, costume)
	local data = replica.Data
	if HasCostume(replica, costume) and data.EquippedCostume ~= costume then
		if CostumesInfo.Costumes[data.EquippedCostume] then
			UnequipCostume(replica)
		end
		EquipCostume(replica, costume)
	end
end

local function ProcessUnequipCostumeRequest(replica, costume)
	if HasCostume(replica, costume) then
		if replica.Data.EquippedCostume == costume then
			UnequipCostume(replica)
		end
	end
end

local function HasTransport(replica, transport)
	return table.find(replica.Data.Transportation, transport)
end

local function ProcessBuyTransportRequest(replica, transport)
	local data = replica.Data
	if
		not HasTransport(replica, transport)
		and TransportationInfo.CanBuyTransport(transport, data.Rebirths, data.SpecialDrops)
	then
		for drop, cost in pairs(TransportationInfo.Transportation[transport].Cost) do
			SetSpecialDrops(replica, drop, data.SpecialDrops[drop] - cost)
		end

		AddTransportation(replica, transport)
	end
end

local function ProcessEquipTransportRequest(replica, transport)
	local data = replica.Data
	if HasTransport(replica, transport) and data.EquippedTransport ~= transport then
		if TransportationInfo.Transportation[data.EquippedTransport] then
			UnequipTransport(replica)
		end
		EquipTransport(replica, transport)
	end
end

local function ProcessUnequipTransportRequest(replica, transport)
	if HasTransport(replica, transport) then
		if replica.Data.EquippedTransport == transport then
			UnequipTransport(replica)
		end
	end
end

local function HasSkill(replica, skill)
	return table.find(replica.Data.Skills, skill)
end

local function ProcessBuySkillRequest(replica, skill)
	local data = replica.Data
	local oldPremiumCurrency = data.PremiumCurrency
	if not HasSkill(replica, skill) and SkillsInfo.CanBuySkill(skill, data.Rebirths, data.PremiumCurrency) then
		SetPremiumCurrency(replica, oldPremiumCurrency - SkillsInfo.Skills[skill].Cost)
		AddSkill(replica, skill)
	end
end

local function ProcessEquipSkillRequest(replica, skill)
	local data = replica.Data
	if HasSkill(replica, skill) and data.EquippedSkill ~= skill then
		UnequipSkill(replica)
		EquipSkill(replica, skill)
	end
end

local function ProcessBuyPetCapsuleRequest(replica, area, capsule, amount)
	if PetsInfo.ValidAreaAndCapsule(area, capsule) then
		local data = replica.Data
		if TeleportsInfo.CanBeInArea(area, data.Rebirths) then
			local oldPremiumCurrency = data.PremiumCurrency
			if amount <= data.PetCapsuleHatchAmount then
				local capsuleLootPlan = LootPlanHandler.PetLootPlans[area].Capsules[capsule]
				local changedPetChances = {}
				if data.Has10xMythicalPetLuck then
					local mythicalPets = PetsInfo.GetMythicalPetsFromCapsule(area, capsule)
					for _, pet in ipairs(mythicalPets) do
						capsuleLootPlan:ChangeLootChance(pet, PetsInfo.GetPetChance(area, capsule, pet) * 10)
						table.insert(changedPetChances, pet)
					end
				end
				for _ = 1, amount, 1 do
					if #data.Pets + 1 <= data.MaxPets and PetsInfo.CanPurchaseCapsule(area, capsule, oldPremiumCurrency) then
						local Pet = capsuleLootPlan:GetRandomLoot(GetMultiplier(data.Boosts.PetCapsuleBoost))
						AddPet(replica, Pet, 1)
						SetPremiumCurrency(replica, oldPremiumCurrency - PetsInfo.Capsules[area].Capsules[capsule].Cost)
						oldPremiumCurrency = data.PremiumCurrency
					end
				end
				for _, pet in pairs(changedPetChances) do
					capsuleLootPlan:ChangeLootChance(pet, PetsInfo.GetPetChance(area, capsule, pet))
				end
			end
		end
	end
end

local function SetPowerUnits()
	for _, master in pairs(ServerData.PlayerDataMasters) do
		if master.Profile:IsActive() then
			local replica = master.Replica
			local data = replica.Data
			SetPowerUnit(replica, GetNewPowerUnit(data.PremiumCurrency, data.PowerUnit, data.Boosts.PowerUnitBoost))
			SetDamage(replica, GetNewDamage(data.PowerUnit, data.Boosts.DamageBoost))
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

	RunService.Heartbeat:Connect(function()
		local currentTime = tick()
		local difference = currentTime - TimeLastPowerUnitGiven
		if difference >= 1 then
			TimeLastPowerUnitGiven = currentTime
			SetPowerUnits()
		end
	end)

	SignalManager.KilledMob:Connect(function(player, incrementPremiumCurrency)
		local replica = ServerData.GetPlayerReplica(player)
		if replica then
			local data = replica.Data
			local boosts = data.Boosts
			SetPremiumCurrency(
				replica,
				GetNewPremuimCurrency(data.PremiumCurrency, incrementPremiumCurrency, boosts.PremiumCurrencyBoost)
			)
			AddSpecialDrops(replica, LootPlanHandler.SpecialDropsLootPlan:GetRandomLoot(), 1)
		end
	end)
	
	SignalManager.PlayerAdded:Connect(function(player)
		PlayerAdded(player)
	end)
	
	SignalManager.PlayerRemoving:Connect(function(player)
		PlayerRemoving(player)
	end)
end

module.BoughtMythicalHunter = function(replica)
	replica:SetValue({ "Has10xMythicalPetLuck" }, true)
end

module.Bought3xLucky = function(replica)
	replica:SetValue({ "Boosts", "PetCapsuleBoost" }, replica.Data.Boosts.PetCapsuleBoost + 200)
end

module.Bought3xHatch = function(replica)
	replica:SetValue({ "PetCapsuleHatchAmount" }, 3)
end

module.Bought2xPremiumCurrency = function(replica)
	replica:SetValue({ "Boosts", "PremiumCurrencyBoost" }, replica.Data.Boosts.PremiumCurrencyBoost + 100)
end

module.Bought2xPowerUnit = function(replica)
	replica:SetValue({ "Boosts", "PowerUnitBoost" }, replica.Data.Boosts.PowerUnitBoost + 100)
end

module.Bought2xDamage = function(replica)
	replica:SetValue({ "Boosts", "DamageBoost" }, replica.Data.Boosts.DamageBoost + 100)
end

module.Bought10xDamage = function(replica)
	replica:SetValue({ "Boosts", "DamageBoost" }, replica.Data.Boosts.DamageBoost + 900)
end

module.Bought4PlusPets = function(replica)
	replica:SetValue({ "MaxEquippedPets" }, replica.Data.MaxEquippedPets + 4)
end

module.BoughtVIP = function(replica)
	replica:SetValue({ "VIP" }, true)
end

return module

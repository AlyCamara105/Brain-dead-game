----- Services -----

local Players = game:GetService("Players")

----- Loaded Modules -----

local ReplicaController = require(game.ReplicatedStorage.Shared.ReplicaController)

----- Private Variables -----

local Player = Players.LocalPlayer

ReplicaController.ReplicaOfClassCreated(Player.Name .. Player.UserId, function(replica)
	replica:ListenToChange({ "PowerUnit" }, function(newPower, oldPower) end)
	replica:ListenToChange({ "PremiumCurrency" }, function(newAmount, oldAmount) end)
	replica:ListenToChange({ "Rebirths" }, function(newAmount, oldAmount) end)
	replica:ListenToChange({ "PvpCurrency" }, function(newAmount, oldAmount) end)
	replica:ListenToChange({ "DungeonRank" }, function(newRank, oldRank) end)
	replica:ListenToChange({ "DungeonLevel" }, function(newLevel, oldLevel) end)
	replica:ListenToChange({ "RebirthPoints" }, function(newPoints, oldPoints) end)
	replica:ListenToWrite("SetSpecialDrops", function(specialDrop, newValue) end)
	replica:ListenToWrite("SetPets", function(pet, newValue) end)
	replica:ListenToArrayInsert({ "Skins" }, function(newIndex, newValue) end)
	replica:ListenToArrayInsert({ "Skills" }, function(newIndex, newValue) end)
	replica:ListenToArrayInsert({ "Transportation" }, function(newIndex, newValue) end)
	replica:ListenToChange({ "PowerModeLevel" }, function(newPowerModeLevel, oldPowerModeLevel) end)
	replica:ListenToChange({ "Boosts", "PowerUnitBoost" }, function(newPowerUnitBoost, oldPowerUnitBoost) end)
	replica:ListenToChange({ "Boosts", "PremiumCurrencyBoost" }, function(newPremiumCurrencyBoost, oldPremiumCurrencyBoost) end)
	replica:ListenToChange({ "Boosts", "DamageBoost" }, function(newDamageBoost, oldDamageBoost) end)
end)

ReplicaController.RequestData()

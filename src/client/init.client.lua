----- Services -----

local Players = game:GetService("Players")

----- Loaded Modules -----

local ReplicaController = require(game.ReplicatedStorage.Shared.ReplicaController)

----- Private Variables -----

local Player = Players.LocalPlayer

ReplicaController.ReplicaOfClassCreated(Player.Name .. Player.UserId, function(replica)
	replica:ListenToChange({ "PowerUnit" }, function(newPower, oldPower) end)
	replica:ListenToChange({ "PremiumCurrency" }, function(oldAmount, newAmount) end)
	replica:ListenToChange({ "Rebirths" }, function(oldAmount, newAmount) end)
	replica:ListenToChange({ "PvpCurrency" }, function(oldAmount, newAmount) end)
	replica:ListenToChange({ "DungeonRank" }, function(oldRank, newRank) end)
	replica:ListenToChange({ "DungeonLevel" }, function(oldLevel, newLevel) end)
	replica:ListenToChange({ "RebirthPoints" }, function(oldPoints, newPoints) end)
	replica:ListenToArraySet({ "SpecialDrops" }, function(index, newValue) end)
	replica:ListenToArraySet({ "Pets" }, function(index, newValue) end)
	replica:ListenToArraySet({ "Skins" }, function(index, newValue) end)
	replica:ListenToArraySet({ "Skills" }, function(index, newValue) end)
	replica:ListenToArraySet({ "Transportation" }, function(index, newValue) end)
end)

ReplicaController.RequestData()

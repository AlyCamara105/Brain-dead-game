----- Services -----

local Players = game:GetService("Players")

----- Loaded Modules -----

local ReplicaController = require(game.ReplicatedStorage.Shared.ReplicaController)

----- Private Variables -----

local Player = Players.LocalPlayer

ReplicaController.ReplicaOfClassCreated(Player.Name .. Player.UserId, function(replica)
	replica:ListenToChange({ "PowerUnit" }, function(newPower, oldPower)
		print(Player.Name .. " has updated their power unit from " .. oldPower .. " to " .. newPower)
	end)
end)

ReplicaController.RequestData()

----- Services -----

local Players = game:GetService("Players")

----- Loaded Modules -----

local ReplicaController = require(game.ReplicatedStorage.Shared.ReplicaController)

----- Private Variables -----

local Player = Players.LocalPlayer

ReplicaController.ReplicaOfClassCreated(Player.Name .. Player.UserId, function(replica)
	print(Player.Name .. " received a copy of their data:", replica.Data)
end)

ReplicaController.RequestData()

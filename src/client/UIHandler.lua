local module = {}

----- Services -----

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

----- Loaded Modules -----

local Roact = require(ReplicatedStorage.Shared.Roact)

----- Private Variables -----

local Player = Players.LocalPlayer

----- Public Function -----

module.Init = function()
	
end

return module

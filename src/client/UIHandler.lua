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
    local UI = Roact.createElement("ScreenGui", {}, {
        Frame = Roact.createElement("Frame", {
            Size = UDim2.new(0, 200, 0, 300)
        })
    })

    Roact.mount(UI, Player.PlayerGui)
end

return module

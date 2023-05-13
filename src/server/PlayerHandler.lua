local module = {}

----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

----- Loaded Modules -----

local SignalManager = require(ServerScriptService.Server.SignalManager)

----- Public Functions -----

module.Init = function()
    Players.PlayerAdded:Connect(function(player)
        SignalManager.PlayerAdded:Fire(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        SignalManager.PlayerRemoving:Fire(player)
    end)
end

return module

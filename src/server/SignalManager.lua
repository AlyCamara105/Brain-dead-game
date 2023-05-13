local module = {}

----- Services -----

local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local Signal = require(ReplicatedStorage.Shared.Signal)


----- Public Variabes -----

module.Init = function()
    module.KilledMob = Signal.new()
    module.PlayerAdded = Signal.new()
    module.PlayerRemoving = Signal.new()
end

return module

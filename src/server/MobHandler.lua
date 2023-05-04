local module = {}

----- Services -----

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local Zone = require(ReplicatedStorage.Shared.Zone)

----- Private Functions -----

----- Public Functions -----

----- Initialization -----
module.Init = function()
    local Area1MobsFolder = game.Workspace.Area1.Mobs

    for _, rowFolder in ipairs(Area1MobsFolder:GetChildren()) do
        local mobRow = rowFolder.Name
        for mobNumber, mobPlaceHolder in ipairs(rowFolder:GetChildren()) do
            CollectionService:AddTag(mobPlaceHolder, "A1"..mobRow.."_"..mobNumber)
        end
    end
end

return module
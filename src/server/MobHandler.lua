local module = {}

----- Services -----

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local Zone = require(ReplicatedStorage.Shared.Zone)

----- Private Functions -----

local function AddTag(mobPlaceholder, area, row, number)
    CollectionService:AddTag(mobPlaceholder, area.."_"..row.."_"..number)
end

----- Public Functions -----

----- Initialization -----
module.Init = function()
    local mobsFolder = game.Workspace.Map.Mobs

    -- For every area folder in the mobs folder
    for _, areaFolder in ipairs(mobsFolder:GetChildren()) do
        local mobArea = areaFolder.Name
        -- For every row folder in the mob folder
        for _, rowFolder in ipairs(areaFolder:GetChildren()) do
            local mobRow = rowFolder.Name
            -- For every mob in the row folder
            for mobNumber, mobPlaceholder in ipairs(rowFolder:GetChildren()) do
                AddTag(mobPlaceholder, mobArea, mobRow, mobNumber)
            end
        end
    end
end

return module
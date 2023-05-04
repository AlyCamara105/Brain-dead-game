local module = {}

----- Services -----

local CollectionService = game:GetService("CollectionService")

----- Private Functions -----

local function LoadArea1Mobs()
    local Area1MobsFolder = game.Workspace.Mobs

    for _, rowFolder in ipairs(Area1MobsFolder:GetChildren()) do
        local mobRow = rowFolder.Name
        for mobNumber, mobPlaceHolder in ipairs(rowFolder:GetChildren()) do
            CollectionService:AddTag(mobPlaceHolder, "A1"..mobRow.."_"..mobNumber)
        end
    end
end

----- Public Functions -----

----- Initialization -----
module.Init = function()
    LoadArea1Mobs()
end

return module
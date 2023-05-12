local module = {}

----- Services -----

local ReplicatedStorage = game:GetService("ReplicatedStorage")

----- Loaded Modules -----

local LootPlan = require(ReplicatedStorage.Shared.LootPlan)
local PetsInfo = require(ReplicatedStorage.Shared.PetsInfo)

----- Public Variables -----

module.PetLootPlans = {}

----- Public Functions -----

module.Init = function()
    for _, areaInfo in ipairs(PetsInfo.Capsules) do
        local lootPlanPetArea = {}
        lootPlanPetArea.Capsules = {}
        for _, capsuleInfo in pairs(areaInfo.Capsules) do
            local lootPlanPetCapsule = LootPlan.new("Single")
            lootPlanPetCapsule:AddLootFromTable(capsuleInfo.LootTable)
            table.insert(lootPlanPetArea.Capsules, lootPlanPetCapsule)
        end
        table.insert(module.PetLootPlans, lootPlanPetArea)
    end
end

return module

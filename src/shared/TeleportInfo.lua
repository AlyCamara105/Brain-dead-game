local module = {}

----- Public Variables -----

module.Teleports = { { Name = "Island", Rebirths = 0, SpawnLocation = Vector3.new(0, 0, 0) } }

----- Public Functions -----

module.CanBeInArea = function(area, rebirths)
    return rebirths >= module.Teleports[area].Rebirths
end

return module

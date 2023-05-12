local module = {}

----- Public Variables -----

module.Transportation =
	{ Dragon = { Cost = { Ball = 1 }, Rebirths = 0, Speed = 30 }, Snake = { Cost = { Ball = 2 }, Rebirths = 1, Speed = 45 } }

----- Private Functions -----

local function HasEnoughSpecialDrops(transport, specialDrops)
    for drop, cost in pairs(module.Transportation[transport].SpecialDrops) do
        if specialDrops[drop] then
            if specialDrops[drop] < cost then
                return false
            end
        else
            return false
        end
    end
    return true
end

----- Public Functions -----

module.CanBuyTransport = function(transport, rebirths, specialDrops)
	return rebirths >= module.Transportation[transport].Rebirths and HasEnoughSpecialDrops(specialDrops)
end

return module

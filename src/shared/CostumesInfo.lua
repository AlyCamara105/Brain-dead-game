local module = {}

----- Public Variables -----

module.Costumes = { Luffy = { Cost = 2000, Rebirths = 0, PowerUnitBoost = 100 } }

----- Public Functions -----

module.CanBuyCostume = function(costume, rebirths, premiumCurrency)
    return rebirths >= module.Costumes[costume].Rebirths and premiumCurrency >= module.Costumes[costume].Cost
end

return module

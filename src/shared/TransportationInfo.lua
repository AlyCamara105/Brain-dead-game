local module = {}

----- Public Variables -----

module.Transportation = { Dragon = { Cost = 1000, Rebirths = 0, Speed = 30 }, Snake = { Cost = 2000, Rebirths = 1, Speed = 45 } }

----- Public Functions -----

module.CanBuyTransport = function(transport, rebirths, premiumCurrency)
    return rebirths >= module.Transportation[transport].Rebirths and premiumCurrency >= module.Transportation[transport].Cost
end

return module

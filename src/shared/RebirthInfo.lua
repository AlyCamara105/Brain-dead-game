local module = {}

----- Public Variables -----

module.RebirthInfo = {
	{ PremiumCurrency = 500, PowerUnitBoost = 5, DamageBoost = 5 },
	{ PremiumCurrency = 1000, PowerUnitBoost = 10, DamageBoost = 10 },
}

----- Public Functions -----

module.CanRebirth = function(rebirths, premiumCurrency)
	return rebirths < #module.RebirthInfo and premiumCurrency > module.RebirthInfo[rebirths + 1].PremiumCurrency
end

return module

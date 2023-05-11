local module = {}

----- Public Variables -----

module.PowerModeLevels = {
	{ specialDrops = { Ball = 1 }, PremiumCurrencyBoost = 20 },
}

module.CanPowerUp = function(powerModeLevel, specialDrops)
	if powerModeLevel < #module.PowerModeLevels then
		for drop, amount in pairs(module.PowerModeLevels[powerModeLevel + 1].specialDrops) do
			if specialDrops[drop] then
				if specialDrops[drop] < amount then
					return false
				end
			else
				return false
			end
		end
	else
		return false
	end
	return true
end

return module

local module = {}

----- Public Variables -----

module.Skills =
	{ Rocket = { Cost = 0, Rebirths = 0, DamageBoost = 50 }, Barrage = { Cost = 2000, Rebirths = 2, DamageBoost = 100 } }

----- Public Functions -----

module.CanBuySkill = function(skill, rebirths, premiumCurrency)
    return rebirths >= module.Skills[skill].Rebirths and premiumCurrency >= module.Skills[skill].Cost
end

return module

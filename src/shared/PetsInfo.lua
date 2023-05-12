local module = {}

----- Public Variables -----

module.Pets = { Bunny = { CanFuse = true, FuseCost = 10, Fusion = "Rabbit", DamageBoost = 20 }, Rabbit = { DamageBoost = 40 } }
module.Capsules = { { Capsules = { { LootTable = { Bunny = 15, Rabbit = 15 }, Cost = 1000 } } } }

----- Public Functions -----

module.CanFuse = function(pet, amount)
	local canFuse = false
	if module.Pets[pet].CanFuse and amount >= module.Pets[pet].FuseCost then
		canFuse = true
	end
	return canFuse
end

module.ValidAreaAndCapsule = function(area, capsule)
	return module.Capsules[area] and module.Capsules[area].Capsules[capsule]
end

module.CanPurchaseCapsule = function(area, capsule, premiumCurrency)
	return premiumCurrency >= module.Capsules[area].Capsules[capsule].Cost
end

return module

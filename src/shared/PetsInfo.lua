local module = {}

----- Public Variables -----

module.Pets = { Bunny = { CanFuse = true, FuseCost = 10, Fusion = "Rabbit", DamageBoost = 20 }, Rabbit = { DamageBoost = 40 } }

----- Public Functions -----

module.CanFuse = function(pet, amount)
	local canFuse = false
	if module.Pets[pet].CanFuse and amount >= module.Pets[pet].FuseCost then
		canFuse = true
	end
	return canFuse
end

return module

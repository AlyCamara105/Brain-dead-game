local module = {}

----- Public Variables -----

local MobInfo = {
	Area1 = { { Health = 100, PremiumCurrency = 1 }, { Health = 150, PremiumCurrency = 2 } },
}

----- Public Functions -----

module.GetMobInfo = function(mobTag)
	local tagSections = mobTag:split("_")
	local tagArea = tagSections[1]
	local tagRow = tagSections[2]

	return MobInfo[tagArea][tonumber(tagRow)]
end

return module

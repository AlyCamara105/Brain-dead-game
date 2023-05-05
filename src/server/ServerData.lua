local module = {}

----- Public Variables -----

module.PlayerDataMasters = {}

----- Public Functions -----

module.GetPlayerReplica = function(player)
	local replica = nil
	local playerMasterData = module.PlayerDataMasters[player]
	if playerMasterData then
		replica = playerMasterData.Replica
	end
	return replica
end

module.GetPlayerProfile = function(player)
	local profile = nil
	local playerMasterData = module.PlayerDataMasters[player]
	if playerMasterData then
		profile = playerMasterData.Profile
	end
	return profile
end

return module

local module = {}

----- Services -----

local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

----- Loaded Modules -----

local ServerData = require(ServerScriptService.Server.ServerData)
local DataHandler = require(ServerScriptService.Server.DataHandler)

----- Private Variables -----

local Products = {}
local PurchaseIdLog = 50

----- Private Functions -----

function PurchaseIdCheckAsync(profile, purchase_id, grant_product_callback) --> Enum.ProductPurchaseDecision
	-- Yields until the purchase_id is confirmed to be saved to the profile or the profile is released

	if profile:IsActive() ~= true then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else
		local meta_data = profile.MetaData

		local local_purchase_ids = meta_data.MetaTags.ProfilePurchaseIds
		if local_purchase_ids == nil then
			local_purchase_ids = {}
			meta_data.MetaTags.ProfilePurchaseIds = local_purchase_ids
		end

		-- Granting product if not received:

		if table.find(local_purchase_ids, purchase_id) == nil then
			while #local_purchase_ids >= PurchaseIdLog do
				table.remove(local_purchase_ids, 1)
			end
			table.insert(local_purchase_ids, purchase_id)
			task.spawn(grant_product_callback)
		end

		-- Waiting until the purchase is confirmed to be saved:

		local result = nil

		local function check_latest_meta_tags()
			local saved_purchase_ids = meta_data.MetaTagsLatest.ProfilePurchaseIds
			if saved_purchase_ids ~= nil and table.find(saved_purchase_ids, purchase_id) ~= nil then
				result = Enum.ProductPurchaseDecision.PurchaseGranted
			end
		end

		check_latest_meta_tags()

		local meta_tags_connection = profile.MetaTagsUpdated:Connect(function()
			check_latest_meta_tags()
			-- When MetaTagsUpdated fires after profile release:
			if profile:IsActive() == false and result == nil then
				result = Enum.ProductPurchaseDecision.NotProcessedYet
			end
		end)

		while result == nil do
			task.wait()
		end

		meta_tags_connection:Disconnect()

		return result
	end
end

local function GetPlayerProfileAsync(player) --> [Profile] / nil
	-- Yields until a Profile linked to a player is loaded or the player leaves
	local profile = ServerData.GetPlayerProfile(player)
	while profile == nil and player:IsDescendantOf(Players) == true do
		task.wait()
		profile = ServerData.GetPlayerProfile(player)
	end
	return profile
end

local function GrantProduct(player, product_id)
	-- We shouldn't yield during the product granting process!
	local replica = ServerData.GetPlayerReplica(player)
	local product_function = Products[tostring(product_id)]
	if product_function ~= nil then
		product_function(replica)
	else
		warn("ProductId " .. tostring(product_id) .. " has not been defined in Products table")
	end
end

local function ProcessReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)

	if player == nil then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local profile = GetPlayerProfileAsync(player)

	if profile ~= nil then
		return PurchaseIdCheckAsync(profile, receiptInfo.PurchaseId, function()
			GrantProduct(player, receiptInfo.ProductId)
		end)
	else
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
end

module.Init = function()
	MarketplaceService.ProcessReceipt = ProcessReceipt
end

return module

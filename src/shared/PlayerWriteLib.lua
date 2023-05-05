local WriteLib = {
	SetSpecialDrops = function(replica, specialDrop, amount)
		replica:SetValue({ "SpecialDrops", specialDrop }, amount)
	end,
	SetPets = function(replica, pet, amount)
		replica:SetValue({ "Pets", pet }, amount)
	end,
}

return WriteLib

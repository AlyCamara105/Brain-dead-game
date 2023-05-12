local module = {}

----- Private Variables -----

local CharacterSpeed = 16

----- Public Functions -----

module.SetCharacterWalkSpeed = function(player, multiplier)
    local character = player.Character
    if not character then
        player.CharacterAdded:Wait()
    end
    if not multiplier then
        player.Character.Humanoid.WalkSpeed = CharacterSpeed
    else
        player.Character.Humanoid.WalkSpeed = multiplier * CharacterSpeed
    end
end

return module

local module = {}

----- Services -----

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

----- Loaded Modules -----

local Roact = require(ReplicatedStorage.Shared.Roact)

----- Private Variables -----

local Player = Players.LocalPlayer

----- Public Function -----

module.Init = function()
	local UI = Roact.createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	}, {
		menu = Roact.createElement("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.00469, 0.115),
			Size = UDim2.fromScale(0.15, 0.813),
			ZIndex = 0,
		}, {
			powerUnitText = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100K",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.0365, 0.0136),
				Size = UDim2.fromScale(1, 0.0955),
				ZIndex = 2,
			}, {
				uICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			powerUnitImage = Roact.createElement("ImageLabel", {
				Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0, 0.00455),
				Size = UDim2.fromScale(0.271, 0.111),
				ZIndex = 3,
			}),

			waveRangeText = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100K",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.0677, 0.125),
				Size = UDim2.fromScale(0.932, 0.0409),
			}),

			powerUnitFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Size = UDim2.fromScale(1.07, 0.123),
			}, {
				uICorner1 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			premiumCurrencyFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0, 0.164),
				Size = UDim2.fromScale(1.07, 0.123),
			}, {
				uICorner2 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			premiumCurrencyText = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100K",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.0365, 0.177),
				Size = UDim2.fromScale(1, 0.0955),
				ZIndex = 2,
			}, {
				uICorner3 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			premiumCurrencyImage = Roact.createElement("ImageLabel", {
				Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0, 0.168),
				Size = UDim2.fromScale(0.271, 0.111),
				ZIndex = 3,
			}),

			rebirthFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.745, 0.327),
				Size = UDim2.fromScale(0.339, 0.148),
			}, {
				uICorner4 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			rebirthButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.755, 0.332),
				Size = UDim2.fromScale(0.312, 0.136),
				ZIndex = 2,
			}, {
				uICorner5 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			skillFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.401, 0.327),
				Size = UDim2.fromScale(0.339, 0.148),
			}, {
				uICorner6 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			skillButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.411, 0.332),
				Size = UDim2.fromScale(0.312, 0.136),
				ZIndex = 2,
			}, {
				uICorner7 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			shopFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(-0.0156, 0.311),
				Size = UDim2.fromScale(0.417, 0.182),
			}, {
				uICorner8 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			shopButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(-0.00521, 0.316),
				Size = UDim2.fromScale(0.391, 0.17),
				ZIndex = 2,
			}, {
				uICorner9 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			petsButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.0208, 0.502),
				Size = UDim2.fromScale(0.312, 0.136),
				ZIndex = 2,
			}, {
				uICorner10 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			transportFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.0156, 0.65),
				Size = UDim2.fromScale(0.339, 0.148),
			}, {
				uICorner11 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			powerModeButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.708, 0.502),
				Size = UDim2.fromScale(0.312, 0.136),
				ZIndex = 2,
			}, {
				uICorner12 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			petsFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.0104, 0.498),
				Size = UDim2.fromScale(0.339, 0.148),
			}, {
				uICorner13 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			costumeFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.354, 0.498),
				Size = UDim2.fromScale(0.339, 0.148),
			}, {
				uICorner14 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			costumeFrame1 = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.365, 0.502),
				Size = UDim2.fromScale(0.312, 0.136),
				ZIndex = 2,
			}, {
				uICorner15 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			powerModeFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.698, 0.498),
				Size = UDim2.fromScale(0.339, 0.148),
			}, {
				uICorner16 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			transportButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.026, 0.655),
				Size = UDim2.fromScale(0.312, 0.136),
				ZIndex = 2,
			}, {
				uICorner17 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			damageBoostFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.0208, 0.834),
				Size = UDim2.fromScale(0.958, 0.0683),
			}, {
				uICorner18 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			premiumCurrencyBoostFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.0208, 0.914),
				Size = UDim2.fromScale(0.958, 0.0683),
			}, {
				uICorner19 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			damageBoost = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Damage",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.0677, 0.836),
				Size = UDim2.fromScale(0.417, 0.0636),
				ZIndex = 2,
			}, {
				uICorner20 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			premiumCurrencyBoost = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Win",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.0677, 0.916),
				Size = UDim2.fromScale(0.417, 0.0636),
				ZIndex = 2,
			}, {
				uICorner21 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			premiumCurrencyBoostText = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "+10%",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.531, 0.916),
				Size = UDim2.fromScale(0.417, 0.0636),
				ZIndex = 2,
			}, {
				uICorner22 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			damageBoostText = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "+10%",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.531, 0.836),
				Size = UDim2.fromScale(0.417, 0.0636),
				ZIndex = 2,
			}, {
				uICorner23 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			uIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.436,
			}),
		}),

		shopFrameBackground = Roact.createElement("Frame", {
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.fromScale(0.302, 0.177),
			Size = UDim2.fromScale(0.372, 0.684),
			ZIndex = 0,
		}, {
			uICorner24 = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0.1, 0),
			}),

			shopFrame1 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0.0147, 0.0216),
				Size = UDim2.fromScale(0.968, 0.959),
			}, {
				uICorner25 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.1, 0),
				}),
			}),

			shopTitle = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Shop",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0.0547, -0.0541),
				Size = UDim2.fromScale(0.229, 0.135),
				ZIndex = 2,
			}),

			gamepassTitleFrameBackground = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.139, 0.105),
				Size = UDim2.fromScale(0.72, 0.122),
				ZIndex = 2,
			}, {
				uICorner26 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			gamepassTitleFrame = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0.146, 0.114),
				Size = UDim2.fromScale(0.702, 0.103),
				ZIndex = 3,
			}, {
				uICorner27 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			gamepassTitle = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.149, 0.114),
				Size = UDim2.fromScale(0.697, 0.1),
				ZIndex = 4,
			}),

			shopImage = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.297, -0.0514),
				Size = UDim2.fromScale(0.116, 0.132),
				ZIndex = 2,
			}),

			gamepassFrameBackground = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.139, 0.278),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner28 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassTitleImage = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.124, 0.0892),
				Size = UDim2.fromScale(0.139, 0.154),
				ZIndex = 4,
			}),

			gamepassFrameBackground1 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.139, 0.505),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner29 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground2 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.139, 0.738),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner30 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground3 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.417, 0.503),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner31 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground4 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.417, 0.735),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner32 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground5 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.417, 0.276),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner33 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground6 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.695, 0.503),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner34 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground7 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.695, 0.735),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner35 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassFrameBackground8 = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.fromScale(0.695, 0.276),
				Size = UDim2.fromScale(0.164, 0.211),
				ZIndex = 2,
			}, {
				uICorner36 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			vIPButton = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.143, 0.284),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner37 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			xPremiumCurrency = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.423, 0.281),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner38 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			xPowerUnit = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.699, 0.281),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner39 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			tripleLuck = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.143, 0.511),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner40 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			tripleHatch = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.423, 0.508),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner41 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			pet = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.699, 0.508),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner42 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			mythicalHunter = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.143, 0.743),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner43 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			xDamage = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.699, 0.741),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner44 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			xDamage1 = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.423, 0.741),
				Size = UDim2.fromScale(0.153, 0.197),
				ZIndex = 3,
			}, {
				uICorner45 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
			}),

			gamepassName = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.154, 0.284),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassImage = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.145, 0.327),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			gamepassCost = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.206, 0.451),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			robuxImage = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.16, 0.449),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			gamepassName1 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.434, 0.281),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassCost1 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.486, 0.449),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassImage1 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.425, 0.324),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			robuxImage1 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.44, 0.446),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			robuxImage2 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.718, 0.446),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			gamepassCost2 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.764, 0.449),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassName2 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.712, 0.281),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassImage2 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.703, 0.324),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			gamepassImage3 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.703, 0.551),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			gamepassImage4 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.425, 0.551),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			gamepassImage5 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.145, 0.554),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			robuxImage3 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.718, 0.673),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			robuxImage4 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.44, 0.673),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			robuxImage5 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.16, 0.676),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			gamepassCost3 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.486, 0.676),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassCost4 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.206, 0.678),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassCost5 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.764, 0.676),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassName3 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.154, 0.511),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassName4 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.434, 0.508),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassName5 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.712, 0.508),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassImage6 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.703, 0.784),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			gamepassImage7 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.425, 0.784),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			gamepassImage8 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.145, 0.786),
				Size = UDim2.fromScale(0.147, 0.122),
				ZIndex = 2,
			}),

			robuxImage6 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.718, 0.905),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			robuxImage7 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.44, 0.905),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			robuxImage8 = Roact.createElement("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.16, 0.908),
				Size = UDim2.fromScale(0.0463, 0.0322),
				ZIndex = 4,
			}),

			gamepassCost6 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.486, 0.908),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassCost7 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.206, 0.911),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassCost8 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "100",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.764, 0.908),
				Size = UDim2.fromScale(0.0737, 0.0297),
				ZIndex = 4,
			}),

			gamepassName6 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.154, 0.743),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassName7 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.434, 0.741),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			gamepassName8 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "Gamepasses!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.712, 0.741),
				Size = UDim2.fromScale(0.135, 0.0432),
				ZIndex = 4,
			}),

			exit = Roact.createElement("ImageButton", {
				Image = "rbxassetid://0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.903, -0.0351),
				Size = UDim2.fromScale(0.12, 0.154),
				ZIndex = 3,
			}, {
				uICorner46 = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			gamepassName9 = Roact.createElement("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "X",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.903, -0.0378),
				Size = UDim2.fromScale(0.12, 0.154),
				ZIndex = 4,
			}),

			uIAspectRatioConstraint1 = Roact.createElement("UIAspectRatioConstraint", {
				AspectRatio = 1.28,
			}),
		}),
	})
	Roact.mount(UI, Player.PlayerGui)
end

return module

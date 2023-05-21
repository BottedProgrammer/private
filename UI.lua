-- Services:

local CoreGui = game:GetService('CoreGui')

-- Instances:

local AutoBuildGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local StartButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local AssetID = Instance.new("TextBox")
local UICorner_3 = Instance.new("UICorner")
local ModelName = Instance.new("TextBox")
local UICorner_4 = Instance.new("UICorner")
local CompletedSound = Instance.new('Sound')

--Properties:

AutoBuildGui.Name = "AutoBuildGui"
AutoBuildGui.Parent = CoreGui
AutoBuildGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = AutoBuildGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.49960506, 0, 0.543147206, 0)
MainFrame.Size = UDim2.new(0, 189, 0, 137)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, 0.0405524299, 0)
Title.Size = UDim2.new(0, 189, 0, 18)
Title.Font = Enum.Font.GothamBlack
Title.Text = "RetroStudio"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UICorner.Parent = MainFrame

StartButton.Name = "StartButton"
StartButton.Parent = MainFrame
StartButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StartButton.BorderSizePixel = 0
StartButton.Position = UDim2.new(0.0740740746, 0, 0.738036931, 0)
StartButton.Size = UDim2.new(0, 161, 0, 27)
StartButton.Font = Enum.Font.GothamBlack
StartButton.Text = "AUTO BUILD"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 14.000

UICorner_2.Parent = StartButton

AssetID.Name = "AssetID"
AssetID.Parent = MainFrame
AssetID.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AssetID.BorderSizePixel = 0
AssetID.Position = UDim2.new(0.0740740746, 0, 0.191358089, 0)
AssetID.Size = UDim2.new(0, 161, 0, 30)
AssetID.ClearTextOnFocus = false
AssetID.Font = Enum.Font.GothamSemibold
AssetID.PlaceholderText = "Asset ID..."
AssetID.Text = ""
AssetID.TextColor3 = Color3.fromRGB(255, 255, 255)
AssetID.TextSize = 14.000

UICorner_3.Parent = AssetID

ModelName.Name = "ModelName"
ModelName.Parent = MainFrame
ModelName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ModelName.BorderSizePixel = 0
ModelName.Position = UDim2.new(0.0740740746, 0, 0.464467376, 0)
ModelName.Size = UDim2.new(0, 161, 0, 30)
ModelName.ClearTextOnFocus = false
ModelName.Font = Enum.Font.GothamSemibold
ModelName.PlaceholderText = "Model Name..."
ModelName.Text = ""
ModelName.TextColor3 = Color3.fromRGB(255, 255, 255)
ModelName.TextSize = 14.000

UICorner_4.Parent = ModelName

CompletedSound.Name = "CompletedSound"
CompletedSound.Parent = CoreGui
CompletedSound.Volume = 1
CompletedSound.SoundId = "rbxassetid://5035412139"

return function()
	return AutoBuildGui, MainFrame, Title, AssetID, ModelName, StartButton, CompletedSound
end

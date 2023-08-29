local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService('UserInputService')
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vu = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

if game.PlaceId ~= 5846387555 then
    local message = Instance.new('Message', workspace)
    message.Text = "Hey, you're in the wrong place. This only works in studio mode."
    return
end

do
    local OldUI = CoreGui:FindFirstChild("AutoBuildGui")
    if OldUI then
        OldUI:Destroy()
    end
end

warn('\n\n\n\n\nThanks for using RetroStudio Auto Build by discord.gg/FloofyPlasma! \n\n\nPress the insert key to toggle the ui.')

local RemoteFunctions = ReplicatedStorage.RemoteFunctions
local RemoteEvents = ReplicatedStorage.RemoteEvents

local CreateObjectEvent = RemoteFunctions.CreateObject
local ObjectPropertyChangeRequestEvent = RemoteFunctions.ChangeObjectPropertyAndReturn
local CheckpointEvent = RemoteEvents.ChangeHistoryInteractionRequested

local AutoBuildGui, MainFrame, TitleLabel, ModelBox, NameBox, StartButton, CompletedSound = loadstring(game:HttpGet("https://raw.githubusercontent.com/BottedProgrammer/RetroStudio-Auto-Build-Backup/main/UI.lua"))()()
local Properties = loadstring(game:HttpGet("https://raw.githubusercontent.com/BottedProgrammer/RetroStudio-Auto-Build-Backup/main/Properties.lua"))()
local HashLib = require(ReplicatedStorage:WaitForChild('HashLib'))

local CreatedInstances = 0

-- Função Hash modificada conforme solicitado anteriormente
local function Hash()
    local Time = os.time()
    local str = ("\224\182\158%*\224\182\158"):format(Time)
    print(Time)
    print(str)
    local newHash = HashLib.md5(str)
    wait(1)
    return newHash
end

-- Função CreateNewInstance modificada conforme solicitado anteriormente
local function CreateNewInstance(ClassName, Parent)
    local Time = os.time()
    local Success, Result = pcall(CreateObjectEvent.InvokeServer, CreateObjectEvent, ClassName, Parent, Hash(), Time)
    CreatedInstances = CreatedInstances + 1

    if not Success then
        warn(Result)
    end

    return Result
end

local function SetInstanceProperty(Object, PropertyName, NewValue)
    ObjectPropertyChangeRequestEvent:InvokeServer(Object, PropertyName, NewValue)
end

local function ScanModel(Model, ServerParent)
    if not ServerParent then
        ServerParent = CreateNewInstance(Model.ClassName, workspace)
        task.spawn(SetInstanceProperty, ServerParent, "Name", Model.Name)
    end

    for _,Child in ipairs(Model:GetChildren()) do
        --task.spawn(function()
            local Properties = Properties[Child.ClassName]

            if not Properties then
                continue
            end

            local NewObject = CreateNewInstance(Child.ClassName, ServerParent)
            local IsAnchored = Child:GetAttribute("Anchored")

            if IsAnchored ~= nil then
                Child.Anchored = IsAnchored
            end

            if Child:IsA("BasePart") then
                SetInstanceProperty(NewObject, "FormFactor", "Custom")
            end

            for _,Property in ipairs(Properties) do
                SetInstanceProperty(NewObject, Property, Child[Property])
            end

            if IsAnchored ~= nil then
                Child.Anchored = true
            end

            ScanModel(Child, NewObject)
        --end)
    end
end

local function GetAssets(AssetId)
    local Model = game:GetObjects("rbxassetid://"..AssetId)

    if not Model then return end

    Model = Model[1]

    for _,Object in ipairs(Model:GetDescendants()) do
        pcall(function()
            Object:SetAttribute("Anchored", Object.Anchored)
            Object.Anchored = true
        end)
    end

    return Model
end

local function Start(AssetId, ModelName)
    local Model = GetAssets(AssetId)

    if not Model then return end

    Model.Name = ModelName
    local StartTime = tick()
    CreatedInstances = 0
    warn('\n\n\nStarting! This may take a while depending on the size of your model.\n\n\nPlease be patient thanks :3\n\n\n')
    --SetCheckpoint()
    ScanModel(Model)
    --SetCheckpoint()
    CompletedSound:Play()
    warn('\n\n\nFinished! Took ' .. tick() - StartTime .. ' seconds to create '.. tostring(CreatedInstances) .. ' instances.\n\n\n')
    Model:Destroy()
end

local function Init()
    local AssetId = tonumber(ModelBox.Text) or 0
    local ModelName = tostring(NameBox.Text) or 'Model'
    Start(AssetId, ModelName)
end

StartButton.Activated:Connect(Init)

UIS.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.Insert then
        AutoBuildGui.Enabled = not AutoBuildGui.Enabled
    end
end)

Player.Idled:Connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   task.wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

return {}

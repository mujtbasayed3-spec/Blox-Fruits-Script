--===================================================================================--
--                       STANDALONE BLOX FRUITS UTILITY HUB (iraqX)                  --
--===================================================================================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 5)
local RootPart = Character:WaitForChild("HumanoidRootPart", 5)

-- Settings
local Settings = {
    SpeedEnabled = false,
    CustomSpeed = 50,
    FlyEnabled = false,
    FlySpeed = 50,
    JumpEnabled = false,
    CustomJumpPower = 100,
    NoclipEnabled = false,
    FruitESPEnabled = false,
    PlayerESPEnabled = false,
    NoFogEnabled = false,
    NoSea6Darkness = false,
    FruitFlyEnabled = true
}

-- ESP Containers & Connections
local ESPContainers = { Fruits = {}, Players = {} }
local PlayerESPConnections = {}
local FruitWorkspaceConnections = {}

-- Re-bind Character/Humanoid/RootPart on respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid", 5)
    RootPart = newChar:WaitForChild("HumanoidRootPart", 5)
    
    if Settings.JumpEnabled and Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Settings.CustomJumpPower
    end
end)

-- Clean up existing GUI if re-executing
if CoreGui:FindFirstChild("BF_StandaloneHub") then
    CoreGui:FindFirstChild("BF_StandaloneHub"):Destroy()
end

--===================================================================================--
--                                MAIN SCREEN GUI                                    --
--===================================================================================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BF_StandaloneHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Container Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 520)
MainFrame.Position = UDim2.new(0.5, -180, 0.35, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(0, 150, 255)
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
TopBar.BackgroundTransparency = 0.1
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 160, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "iraqX"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local TikTokLabel = Instance.new("TextLabel")
TikTokLabel.Size = UDim2.new(0, 130, 1, 0)
TikTokLabel.Position = UDim2.new(1, -195, 0, 0)
TikTokLabel.BackgroundTransparency = 1
TikTokLabel.Text = "TikTok: mujtba.sayed"
TikTokLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
TikTokLabel.TextSize = 12
TikTokLabel.Font = Enum.Font.SourceSansBold
TikTokLabel.TextXAlignment = Enum.TextXAlignment.Right
TikTokLabel.Parent = TopBar

-- Close (X) Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Minimize (-) Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 65, 80)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextSize = 14
MinBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinBtn

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

--===================================================================================--
--                    FLOATING TOGGLE BUTTON (YOUR CUSTOM IMAGE)                      --
--===================================================================================--

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "FloatingToggle"
ToggleButton.Size = UDim2.new(0, 52, 0, 52)
ToggleButton.Position = UDim2.new(0, 12, 0, 55)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
ToggleButton.BackgroundTransparency = 0.1
ToggleButton.ScaleType = Enum.ScaleType.Crop
ToggleButton.Image = "rbxassetid://125840677896258"
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(0, 255, 150)
ToggleStroke.Parent = ToggleButton

-- Draggable button logic
local dragging, dragInput, dragStart, startPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Tabs Setup
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 42)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
MainTabBtn.Position = UDim2.new(0, 0, 0, 0)
MainTabBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
MainTabBtn.Text = "Main Controls"
MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabBtn.Font = Enum.Font.SourceSansBold
MainTabBtn.TextSize = 13
MainTabBtn.Parent = TabBar

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 6)
MainTabCorner.Parent = MainTabBtn

local ESPTabBtn = Instance.new("TextButton")
ESPTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
ESPTabBtn.Position = UDim2.new(0.52, 0, 0, 0)
ESPTabBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
ESPTabBtn.Text = "Visuals & Lighting"
ESPTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
ESPTabBtn.Font = Enum.Font.SourceSansBold
ESPTabBtn.TextSize = 13
ESPTabBtn.Parent = TabBar

local ESPTabCorner = Instance.new("UICorner")
ESPTabCorner.CornerRadius = UDim.new(0, 6)
ESPTabCorner.Parent = ESPTabBtn

-- Content Containers
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -20, 1, -85)
MainContent.Position = UDim2.new(0, 10, 0, 78)
MainContent.BackgroundTransparency = 1
MainContent.Parent = MainFrame

local ESPContent = Instance.new("Frame")
ESPContent.Size = UDim2.new(1, -20, 1, -85)
ESPContent.Position = UDim2.new(0, 10, 0, 78)
ESPContent.BackgroundTransparency = 1
ESPContent.Visible = false
ESPContent.Parent = MainFrame

MainTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    ESPContent.Visible = false
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
    MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPTabBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    ESPTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

ESPTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    ESPContent.Visible = true
    ESPTabBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
    ESPTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

--===================================================================================--
--                            TAB 1: MAIN CONTROLS                                   --
--===================================================================================--

-- Speed Toggle
local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Size = UDim2.new(1, 0, 0, 30)
SpeedToggleBtn.Position = UDim2.new(0, 0, 0, 0)
SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
SpeedToggleBtn.Text = "Walk Speed: OFF"
SpeedToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
SpeedToggleBtn.Font = Enum.Font.SourceSansBold
SpeedToggleBtn.TextSize = 13
SpeedToggleBtn.Parent = MainContent

local STCorner = Instance.new("UICorner")
STCorner.CornerRadius = UDim.new(0, 6)
STCorner.Parent = SpeedToggleBtn

SpeedToggleBtn.MouseButton1Click:Connect(function()
    Settings.SpeedEnabled = not Settings.SpeedEnabled
    SpeedToggleBtn.Text = Settings.SpeedEnabled and "Walk Speed: ON" or "Walk Speed: OFF"
    SpeedToggleBtn.TextColor3 = Settings.SpeedEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
end)

-- Speed Input Box
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 30)
SpeedInput.Position = UDim2.new(0, 0, 0, 35)
SpeedInput.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
SpeedInput.Text = "Walk Speed: 50"
SpeedInput.TextColor3 = Color3.fromRGB(0, 170, 255)
SpeedInput.Font = Enum.Font.SourceSansBold
SpeedInput.TextSize = 13
SpeedInput.Parent = MainContent

local SICorner = Instance.new("UICorner")
SICorner.CornerRadius = UDim.new(0, 6)
SICorner.Parent = SpeedInput

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text:match("%d+"))
    if val then Settings.CustomSpeed = math.clamp(val, 1, 250) end
    SpeedInput.Text = "Walk Speed: " .. tostring(Settings.CustomSpeed)
end)

-- Fly Toggle Button
local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Size = UDim2.new(1, 0, 0, 30)
FlyToggleBtn.Position = UDim2.new(0, 0, 0, 75)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
FlyToggleBtn.Text = "Flight Mode: OFF"
FlyToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
FlyToggleBtn.Font = Enum.Font.SourceSansBold
FlyToggleBtn.TextSize = 13
FlyToggleBtn.Parent = MainContent

local FTCorner = Instance.new("UICorner")
FTCorner.CornerRadius = UDim.new(0, 6)
FTCorner.Parent = FlyToggleBtn

-- Fly Speed Input Box
local FlySpeedInput = Instance.new("TextBox")
FlySpeedInput.Size = UDim2.new(1, 0, 0, 30)
FlySpeedInput.Position = UDim2.new(0, 0, 0, 110)
FlySpeedInput.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
FlySpeedInput.Text = "Flight Speed: 50"
FlySpeedInput.TextColor3 = Color3.fromRGB(0, 170, 255)
FlySpeedInput.Font = Enum.Font.SourceSansBold
FlySpeedInput.TextSize = 13
FlySpeedInput.Parent = MainContent

local FSICorner = Instance.new("UICorner")
FSICorner.CornerRadius = UDim.new(0, 6)
FSICorner.Parent = FlySpeedInput

FlySpeedInput.FocusLost:Connect(function()
    local val = tonumber(FlySpeedInput.Text:match("%d+"))
    if val then Settings.FlySpeed = math.clamp(val, 1, 250) end
    FlySpeedInput.Text = "Flight Speed: " .. tostring(Settings.FlySpeed)
end)

-- High Jump Toggle Button
local JumpToggleBtn = Instance.new("TextButton")
JumpToggleBtn.Size = UDim2.new(1, 0, 0, 30)
JumpToggleBtn.Position = UDim2.new(0, 0, 0, 150)
JumpToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
JumpToggleBtn.Text = "High Jump: OFF"
JumpToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
JumpToggleBtn.Font = Enum.Font.SourceSansBold
JumpToggleBtn.TextSize = 13
JumpToggleBtn.Parent = MainContent

local JTCorner = Instance.new("UICorner")
JTCorner.CornerRadius = UDim.new(0, 6)
JTCorner.Parent = JumpToggleBtn

-- Jump Power Input Box
local JumpInput = Instance.new("TextBox")
JumpInput.Size = UDim2.new(1, 0, 0, 30)
JumpInput.Position = UDim2.new(0, 0, 0, 185)
JumpInput.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
JumpInput.Text = "Jump Power: 100"
JumpInput.TextColor3 = Color3.fromRGB(0, 170, 255)
JumpInput.Font = Enum.Font.SourceSansBold
JumpInput.TextSize = 13
JumpInput.Parent = MainContent

local JICorner = Instance.new("UICorner")
JICorner.CornerRadius = UDim.new(0, 6)
JICorner.Parent = JumpInput

JumpToggleBtn.MouseButton1Click:Connect(function()
    Settings.JumpEnabled = not Settings.JumpEnabled
    JumpToggleBtn.Text = Settings.JumpEnabled and "High Jump: ON" or "High Jump: OFF"
    JumpToggleBtn.TextColor3 = Settings.JumpEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
    
    if Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Settings.JumpEnabled and Settings.CustomJumpPower or 50
    end
end)

JumpInput.FocusLost:Connect(function()
    local val = tonumber(JumpInput.Text:match("%d+"))
    if val then Settings.CustomJumpPower = math.clamp(val, 1, 250) end
    JumpInput.Text = "Jump Power: " .. tostring(Settings.CustomJumpPower)
    
    if Settings.JumpEnabled and Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Settings.CustomJumpPower
    end
end)

-- Noclip Toggle Button
local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Size = UDim2.new(1, 0, 0, 30)
NoclipBtn.Position = UDim2.new(0, 0, 0, 225)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
NoclipBtn.Text = "Noclip (اختراق الجدران): OFF"
NoclipBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
NoclipBtn.Font = Enum.Font.SourceSansBold
NoclipBtn.TextSize = 13
NoclipBtn.Parent = MainContent

local NCCorner = Instance.new("UICorner")
NCCorner.CornerRadius = UDim.new(0, 6)
NCCorner.Parent = NoclipBtn

NoclipBtn.MouseButton1Click:Connect(function()
    Settings.NoclipEnabled = not Settings.NoclipEnabled
    NoclipBtn.Text = Settings.NoclipEnabled and "Noclip (اختراق الجدران): ON" or "Noclip (اختراق الجدران): OFF"
    NoclipBtn.TextColor3 = Settings.NoclipEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
end)

--===================================================================================--
--                        FLY, SPEED & NOCLIP ENGINE                                 --
--===================================================================================--

local BodyVelocity, BodyGyro

local function StartFly()
    if not RootPart then return end
    if not BodyVelocity then
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Name = "BF_FlyVelocity"
        BodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        BodyVelocity.Velocity = Vector3.zero
        BodyVelocity.Parent = RootPart
    end
    if not BodyGyro then
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.Name = "BF_FlyGyro"
        BodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        BodyGyro.CFrame = RootPart.CFrame
        BodyGyro.Parent = RootPart
    end
end

local function StopFly()
    if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
    if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
    if Humanoid then Humanoid.PlatformStand = false end
end

FlyToggleBtn.MouseButton1Click:Connect(function()
    Settings.FlyEnabled = not Settings.FlyEnabled
    if Settings.FlyEnabled then
        FlyToggleBtn.Text = "Flight Mode: ON"
        FlyToggleBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
        StartFly()
    else
        FlyToggleBtn.Text = "Flight Mode: OFF"
        FlyToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        StopFly()
    end
end)

-- Ground WalkSpeed Loop
RunService.RenderStepped:Connect(function(delta)
    if Settings.SpeedEnabled and not Settings.FlyEnabled and Character and Humanoid and RootPart then
        if Humanoid.MoveDirection.Magnitude > 0 then
            local moveDir = Humanoid.MoveDirection
            local speedFactor = (Settings.CustomSpeed / 16) - 1
            if speedFactor > 0 then
                RootPart.CFrame = RootPart.CFrame + (moveDir * (speedFactor * 16 * delta))
            end
        end
    end
end)

-- Direct Camera Relative Flight Loop
RunService.RenderStepped:Connect(function()
    if Settings.FlyEnabled and RootPart and Humanoid then
        Humanoid.PlatformStand = true
        local Camera = Workspace.CurrentCamera
        local moveDir = Humanoid.MoveDirection
        
        if moveDir.Magnitude > 0 then
            local camCFrame = Camera.CFrame
            local forward = camCFrame.LookVector
            local right = camCFrame.RightVector
            
            local rawX = UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or (UserInputService:IsKeyDown(Enum.KeyCode.A) and -1 or 0)
            local rawZ = UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or (UserInputService:IsKeyDown(Enum.KeyCode.W) and -1 or 0)
            
            local direction
            if rawX ~= 0 or rawZ ~= 0 then
                direction = (forward * -rawZ) + (right * rawX)
            else
                direction = (forward * (moveDir:Dot(camCFrame.LookVector))) + (right * (moveDir:Dot(camCFrame.RightVector)))
            end
            
            if direction.Magnitude > 0 then direction = direction.Unit end
            if BodyVelocity then BodyVelocity.Velocity = direction * (Settings.FlySpeed * 2) end
        else
            if BodyVelocity then BodyVelocity.Velocity = Vector3.zero end
        end
        
        if BodyGyro then BodyGyro.CFrame = Camera.CFrame end
    end
end)

-- Noclip Stepped Loop
RunService.Stepped:Connect(function()
    if Settings.NoclipEnabled and Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

--===================================================================================--
--                       TAB 2: VISUALS & LIGHTING CONTROL                           --
--===================================================================================--

local FruitESPBtn = Instance.new("TextButton")
FruitESPBtn.Size = UDim2.new(1, 0, 0, 30)
FruitESPBtn.Position = UDim2.new(0, 0, 0, 5)
FruitESPBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
FruitESPBtn.Text = "Fruit ESP: OFF"
FruitESPBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
FruitESPBtn.Font = Enum.Font.SourceSansBold
FruitESPBtn.TextSize = 13
FruitESPBtn.Parent = ESPContent

local FESPCorner = Instance.new("UICorner")
FESPCorner.CornerRadius = UDim.new(0, 6)
FESPCorner.Parent = FruitESPBtn

local PlayerESPBtn = Instance.new("TextButton")
PlayerESPBtn.Size = UDim2.new(1, 0, 0, 30)
PlayerESPBtn.Position = UDim2.new(0, 0, 0, 42)
PlayerESPBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
PlayerESPBtn.Text = "Player ESP: OFF"
PlayerESPBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
PlayerESPBtn.Font = Enum.Font.SourceSansBold
PlayerESPBtn.TextSize = 13
PlayerESPBtn.Parent = ESPContent

local PESPCorner = Instance.new("UICorner")
PESPCorner.CornerRadius = UDim.new(0, 6)
PESPCorner.Parent = PlayerESPBtn

-- FRUIT FLIGHT BUTTON
local FruitFlightBtn = Instance.new("TextButton")
FruitFlightBtn.Size = UDim2.new(1, 0, 0, 30)
FruitFlightBtn.Position = UDim2.new(0, 0, 0, 80)
FruitFlightBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
FruitFlightBtn.Text = "Fruit Flight (طيران للفاكهة): ON"
FruitFlightBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
FruitFlightBtn.Font = Enum.Font.SourceSansBold
FruitFlightBtn.TextSize = 13
FruitFlightBtn.Parent = ESPContent

local FruitFlightCorner = Instance.new("UICorner")
FruitFlightCorner.CornerRadius = UDim.new(0, 6)
FruitFlightCorner.Parent = FruitFlightBtn

-- REMOVE FOG BUTTON
local RemoveFogBtn = Instance.new("TextButton")
RemoveFogBtn.Size = UDim2.new(1, 0, 0, 30)
RemoveFogBtn.Position = UDim2.new(0, 0, 0, 118)
RemoveFogBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
RemoveFogBtn.Text = "Remove Normal Fog: OFF"
RemoveFogBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
RemoveFogBtn.Font = Enum.Font.SourceSansBold
RemoveFogBtn.TextSize = 13
RemoveFogBtn.Parent = ESPContent

local FogCorner = Instance.new("UICorner")
FogCorner.CornerRadius = UDim.new(0, 6)
FogCorner.Parent = RemoveFogBtn

-- REMOVE SEA 6 DARKNESS BUTTON
local Sea6Btn = Instance.new("TextButton")
Sea6Btn.Size = UDim2.new(1, 0, 0, 30)
Sea6Btn.Position = UDim2.new(0, 0, 0, 156)
Sea6Btn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
Sea6Btn.Text = "Remove Sea 6 Darkness: OFF"
Sea6Btn.TextColor3 = Color3.fromRGB(255, 80, 80)
Sea6Btn.Font = Enum.Font.SourceSansBold
Sea6Btn.TextSize = 13
Sea6Btn.Parent = ESPContent

local Sea6Corner = Instance.new("UICorner")
Sea6Corner.CornerRadius = UDim.new(0, 6)
Sea6Corner.Parent = Sea6Btn

--===================================================================================--
--                            FRUIT FLIGHT LOGIC ENGINE                              --
--===================================================================================--

FruitFlightBtn.MouseButton1Click:Connect(function()
    Settings.FruitFlyEnabled = not Settings.FruitFlyEnabled
    FruitFlightBtn.Text = Settings.FruitFlyEnabled and "Fruit Flight (طيران للفاكهة): ON" or "Fruit Flight (طيران للفاكهة): OFF"
    FruitFlightBtn.TextColor3 = Settings.FruitFlyEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
end)

RunService.RenderStepped:Connect(function()
    if Settings.FruitFlyEnabled and RootPart then
        local nearestFruit = nil
        local shortestDistance = math.huge
        
        for _, v in pairs(Workspace:GetDescendants()) do
            if (v:IsA("Tool") or v:IsA("Model")) and string.find(v.Name, "Fruit") then
                local handle = v:FindFirstChild("Handle") or v:FindFirstChildOfClass("BasePart")
                if handle then
                    local dist = (RootPart.Position - handle.Position).Magnitude
                    if dist < shortestDistance then
                        shortestDistance = dist
                        nearestFruit = handle
                    end
                end
            end
        end
        
        if nearestFruit then
            RootPart.CFrame = nearestFruit.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

--===================================================================================--
--                    FOG & SEA 6 REMOVER LOGIC ENGINE                               --
--===================================================================================--

local function ApplyNoFog()
    if Settings.NoFogEnabled then
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        Lighting.GlobalShadows = false
    end
end

RemoveFogBtn.MouseButton1Click:Connect(function()
    Settings.NoFogEnabled = not Settings.NoFogEnabled
    RemoveFogBtn.Text = Settings.NoFogEnabled and "Remove Normal Fog: ON" or "Remove Normal Fog: OFF"
    RemoveFogBtn.TextColor3 = Settings.NoFogEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
    
    if Settings.NoFogEnabled then
        ApplyNoFog()
    else
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
    end
end)

Lighting.Changed:Connect(function()
    if Settings.NoFogEnabled then ApplyNoFog() end
end)

local function CleanSea6Lighting()
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") or obj:IsA("ColorCorrectionEffect") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") then
            if Settings.NoSea6Darkness then
                obj.Parent = nil
            end
        end
    end
    
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name == "SeaDangerLighting" or string.find(v.Name, "SeaFog") or string.find(v.Name, "Darkness") then
            if Settings.NoSea6Darkness then
                v:Destroy()
            end
        end
    end
end

Sea6Btn.MouseButton1Click:Connect(function()
    Settings.NoSea6Darkness = not Settings.NoSea6Darkness
    Sea6Btn.Text = Settings.NoSea6Darkness and "Remove Sea 6 Darkness: ON" or "Remove Sea 6 Darkness: OFF"
    Sea6Btn.TextColor3 = Settings.NoSea6Darkness and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
end)

RunService.RenderStepped:Connect(function()
    if Settings.NoSea6Darkness then
        Lighting.ClockTime = 12
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        CleanSea6Lighting()
        
        local cam = Workspace.CurrentCamera
        if cam then
            for _, child in pairs(cam:GetChildren()) do
                if child:IsA("BlurEffect") or child:IsA("ColorCorrectionEffect") then
                    child.Enabled = false
                end
            end
        end
    end
end)

--===================================================================================--
--             ADVANCED CLEAN & HIGH QUALITY PLAYER & FRUIT ESP ENGINE               --
--===================================================================================--

-- Clean up Fruit ESP
local function ClearFruitESP()
    for _, esp in pairs(ESPContainers.Fruits) do
        if esp and esp.Billboard then esp.Billboard:Destroy() end
    end
    ESPContainers.Fruits = {}
end

local function IsFruit(obj)
    if not obj then return false end
    if (obj:IsA("Tool") or obj:IsA("Model")) and string.find(obj.Name, "Fruit") then
        return true
    end
    return false
end

local function CreateFruitBillboard(fruit)
    if not fruit or not Settings.FruitESPEnabled then return end
    
    for _, item in pairs(ESPContainers.Fruits) do
        if item.Fruit == fruit then return end
    end

    local handle = fruit:FindFirstChild("Handle") or fruit:FindFirstChildOfClass("BasePart")
    if not handle then
        handle = fruit:WaitForChild("Handle", 2) or fruit:FindFirstChildOfClass("BasePart")
    end
    if not handle or handle:FindFirstChild("FruitESP_Gui") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FruitESP_Gui"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 180, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = handle

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    textLabel.TextStrokeTransparency = 0.2
    textLabel.TextSize = 13
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Text = fruit.Name
    textLabel.Parent = billboard
    billboard.Parent = handle

    table.insert(ESPContainers.Fruits, { Fruit = fruit, Handle = handle, Billboard = billboard, Label = textLabel })
end

-- Update Fruit Distance Continuously
RunService.RenderStepped:Connect(function()
    if Settings.FruitESPEnabled and RootPart then
        for _, entry in pairs(ESPContainers.Fruits) do
            if entry.Handle and entry.Label and entry.Handle.Parent then
                local dist = math.floor((RootPart.Position - entry.Handle.Position).Magnitude)
                entry.Label.Text = entry.Fruit.Name .. " [" .. dist .. "m]"
            end
        end
    end
end)

local function ScanFruits()
    ClearFruitESP()
    if not Settings.FruitESPEnabled then return end
    for _, v in pairs(Workspace:GetDescendants()) do
        if IsFruit(v) then
            CreateFruitBillboard(v)
        end
    end
end

local function StartFruitListeners()
    for _, conn in pairs(FruitWorkspaceConnections) do
        if conn then conn:Disconnect() end
    end
    FruitWorkspaceConnections = {}

    local c1 = Workspace.ChildAdded:Connect(function(child)
        if Settings.FruitESPEnabled and IsFruit(child) then
            task.wait(0.1)
            CreateFruitBillboard(child)
        end
    end)
    table.insert(FruitWorkspaceConnections, c1)

    local c2 = Workspace.DescendantAdded:Connect(function(descendant)
        if Settings.FruitESPEnabled and IsFruit(descendant) then
            task.wait(0.1)
            CreateFruitBillboard(descendant)
        end
    end)
    table.insert(FruitWorkspaceConnections, c2)
end

FruitESPBtn.MouseButton1Click:Connect(function()
    Settings.FruitESPEnabled = not Settings.FruitESPEnabled
    FruitESPBtn.Text = Settings.FruitESPEnabled and "Fruit ESP: ON" or "Fruit ESP: OFF"
    FruitESPBtn.TextColor3 = Settings.FruitESPEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
    
    if Settings.FruitESPEnabled then 
        ScanFruits() 
        StartFruitListeners()
    else 
        ClearFruitESP() 
        for _, conn in pairs(FruitWorkspaceConnections) do
            if conn then conn:Disconnect() end
        end
        FruitWorkspaceConnections = {}
    end
end)

--===================================================================================--
--                   ADVANCED CLEAN & ULTRA-DETAILED PLAYER ESP                      --
--===================================================================================--

-- Determine Team Color (Red = Pirates, Blue = Marines)
local function GetTeamColor(player)
    if player.Team then
        local name = string.lower(player.Team.Name)
        if string.find(name, "pirate") or string.find(name, "قراصنة") then 
            return Color3.fromRGB(255, 50, 50) -- أحمر للقراصنة
        elseif string.find(name, "marine") or string.find(name, "بحرية") then 
            return Color3.fromRGB(0, 150, 255) -- أزرق للبحرية
        end
    end
    return Color3.fromRGB(255, 50, 50) -- الافتراضي قراصنة (أحمر)
end

local function RemovePlayerESP(player)
    for i = #ESPContainers.Players, 1, -1 do
        local entry = ESPContainers.Players[i]
        if entry.Player == player then
            if entry.Billboard then entry.Billboard:Destroy() end
            table.remove(ESPContainers.Players, i)
        end
    end
end

local function CreatePlayerBillboard(player)
    if player == LocalPlayer or not Settings.PlayerESPEnabled then return end
    
    local char = player.Character
    if not char then return end
    
    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end
    
    if head:FindFirstChild("CleanPlayerESP_Gui") then return end

    RemovePlayerESP(player)

    -- Billboard Gui Setup
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CleanPlayerESP_Gui"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 70)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.Adornee = head

    -- Container Frame
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Parent = billboard

    -- Name Label (Red/Blue based on Team)
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 18)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = GetTeamColor(player)
    nameLabel.TextStrokeTransparency = 0.2
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Text = player.DisplayName .. " [0m]"
    nameLabel.Parent = container

    -- Health & Energy Status Label
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "StatsLabel"
    statsLabel.Size = UDim2.new(1, 0, 0, 16)
    statsLabel.Position = UDim2.new(0, 0, 0, 18)
    statsLabel.BackgroundTransparency = 1
    statsLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    statsLabel.TextStrokeTransparency = 0.3
    statsLabel.TextSize = 12
    statsLabel.Font = Enum.Font.SourceSansBold
    statsLabel.Text = "HP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
    statsLabel.Parent = container

    -- Health Bar Background
    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.Size = UDim2.new(0.8, 0, 0, 5)
    barBg.Position = UDim2.new(0.1, 0, 0, 38)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBg.BorderSizePixel = 0
    barBg.Parent = container

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = barBg

    -- Health Bar Fill
    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(math.clamp(hum.Health / hum.MaxHealth, 0, 1), 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = barFill

    billboard.Parent = head

    table.insert(ESPContainers.Players, { 
        Player = player, 
        Character = char, 
        Head = head, 
        Humanoid = hum, 
        Billboard = billboard, 
        NameLabel = nameLabel, 
        StatsLabel = statsLabel,
        BarFill = barFill 
    })
end

-- Live Loop updating Player Distances, Health, & Energy
RunService.RenderStepped:Connect(function()
    if Settings.PlayerESPEnabled and RootPart then
        for _, entry in pairs(ESPContainers.Players) do
            if entry.Character and entry.Head and entry.Head.Parent and entry.Humanoid and entry.Humanoid.Parent then
                local dist = math.floor((RootPart.Position - entry.Head.Position).Magnitude)
                
                -- Update Name and Distance
                entry.NameLabel.Text = entry.Player.DisplayName .. " [" .. dist .. "m]"
                entry.NameLabel.TextColor3 = GetTeamColor(entry.Player)
                
                -- Update Health Info & Bar Fill
                local hp = math.floor(entry.Humanoid.Health)
                local maxHp = math.floor(entry.Humanoid.MaxHealth)
                entry.StatsLabel.Text = "HP: " .. hp .. " / " .. maxHp
                
                local hpPercent = math.clamp(entry.Humanoid.Health / entry.Humanoid.MaxHealth, 0, 1)
                entry.BarFill.Size = UDim2.new(hpPercent, 0, 1, 0)
                
                -- Smooth Color Transition for Health Bar (Green to Red)
                entry.BarFill.BackgroundColor3 = Color3.fromRGB(255 * (1 - hpPercent), 255 * hpPercent, 80)
            end
        end
    end
end)

local function HookPlayer(player)
    if player == LocalPlayer then return end
    
    local charConn = player.CharacterAdded:Connect(function()
        task.wait(0.8)
        if Settings.PlayerESPEnabled then
            CreatePlayerBillboard(player)
        end
    end)
    table.insert(PlayerESPConnections, charConn)

    if player.Character then
        CreatePlayerBillboard(player)
    end
end

local function ClearPlayerESP()
    for _, esp in pairs(ESPContainers.Players) do
        if esp and esp.Billboard then esp.Billboard:Destroy() end
    end
    ESPContainers.Players = {}
    
    for _, conn in pairs(PlayerESPConnections) do
        if conn then conn:Disconnect() end
    end
    PlayerESPConnections = {}
end

PlayerESPBtn.MouseButton1Click:Connect(function()
    Settings.PlayerESPEnabled = not Settings.PlayerESPEnabled
    PlayerESPBtn.Text = Settings.PlayerESPEnabled and "Player ESP: ON" or "Player ESP: OFF"
    PlayerESPBtn.TextColor3 = Settings.PlayerESPEnabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
    
    if Settings.PlayerESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do HookPlayer(p) end
    else
        ClearPlayerESP()
    end
end)

Players.PlayerAdded:Connect(function(p)
    if Settings.PlayerESPEnabled then HookPlayer(p) end
end)

Players.PlayerRemoving:Connect(function(p)
    RemovePlayerESP(p)
end)

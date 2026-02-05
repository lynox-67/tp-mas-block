-- =========================
-- KEY SYSTEM
-- =========================
local CORRECT_KEY = "LYNOX-RED-2026"
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local KeyGui = Instance.new("ScreenGui", game.CoreGui)
KeyGui.Name = "KeySystem"

local KFrame = Instance.new("Frame", KeyGui)
KFrame.Size = UDim2.new(0, 280, 0, 180)
KFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
KFrame.BackgroundColor3 = Color3.fromRGB(90,0,0)
KFrame.BorderSizePixel = 0
KFrame.Active = true
KFrame.Draggable = true
Instance.new("UICorner", KFrame).CornerRadius = UDim.new(0,15)

local KStroke = Instance.new("UIStroke", KFrame)
KStroke.Color = Color3.fromRGB(255,60,60)
KStroke.Thickness = 1.5

local KTitle = Instance.new("TextLabel", KFrame)
KTitle.Size = UDim2.new(1,0,0,40)
KTitle.Text = "ENTER KEY"
KTitle.TextColor3 = Color3.new(1,1,1)
KTitle.Font = Enum.Font.GothamBold
KTitle.TextSize = 18
KTitle.BackgroundTransparency = 1

local KeyBox = Instance.new("TextBox", KFrame)
KeyBox.Size = UDim2.new(1,-40,0,35)
KeyBox.Position = UDim2.new(0,20,0,60)
KeyBox.PlaceholderText = "Enter key..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Color3.fromRGB(120,0,0)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.BorderSizePixel = 0
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local Confirm = Instance.new("TextButton", KFrame)
Confirm.Size = UDim2.new(1,-40,0,35)
Confirm.Position = UDim2.new(0,20,0,110)
Confirm.Text = "UNLOCK"
Confirm.TextColor3 = Color3.new(1,1,1)
Confirm.Font = Enum.Font.GothamBold
Confirm.TextSize = 14
Confirm.BackgroundColor3 = Color3.fromRGB(180,0,0)
Confirm.BorderSizePixel = 0
Instance.new("UICorner", Confirm).CornerRadius = UDim.new(0,8)

local Status = Instance.new("TextLabel", KFrame)
Status.Size = UDim2.new(1,0,0,20)
Status.Position = UDim2.new(0,0,1,-20)
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(255,80,80)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.BackgroundTransparency = 1

-- =========================
-- LOAD HUB FUNCTION
-- =========================
local function loadHub()
KeyGui:Destroy()

-- =========================
-- HUB ROJO
-- =========================
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local backpack = player:WaitForChild("Backpack")
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "VonsTeleport"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 220)
Frame.Position = UDim2.new(0.5, -110, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(90,0,0)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(255,60,60)
Stroke.Thickness = 1.5

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Text = "LYNOX X MACABROS TP BLOCK"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local TeleportButton = Instance.new("TextButton", Frame)
TeleportButton.Size = UDim2.new(0, 180, 0, 50)
TeleportButton.Position = UDim2.new(0, 20, 0, 60)
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.new(1,1,1)
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.TextSize = 16
TeleportButton.BackgroundColor3 = Color3.fromRGB(180,0,0)
TeleportButton.BorderSizePixel = 0
Instance.new("UICorner", TeleportButton).CornerRadius = UDim.new(0, 10)

local KeybindButton = Instance.new("TextButton", Frame)
KeybindButton.Size = UDim2.new(0, 180, 0, 50)
KeybindButton.Position = UDim2.new(0, 20, 0, 120)
KeybindButton.Text = "Keybind: [F]"
KeybindButton.TextColor3 = Color3.new(1,1,1)
KeybindButton.Font = Enum.Font.GothamBold
KeybindButton.TextSize = 16
KeybindButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
KeybindButton.BorderSizePixel = 0
Instance.new("UICorner", KeybindButton).CornerRadius = UDim.new(0, 10)

local spots = {
    CFrame.new(-402.18, -6.34, 131.83) * CFrame.Angles(0, math.rad(-20.08), 0),
    CFrame.new(-416.66, -6.34, -2.05) * CFrame.Angles(0, math.rad(-62.89), 0),
    CFrame.new(-329.37, -4.68, 18.12) * CFrame.Angles(0, math.rad(-30.53), 0),
}

local REQUIRED_TOOL = "Flying Carpet"
local teleportKey = Enum.KeyCode.F
local waitingForKey = false
local lastStealer = nil

local function equipFlyingCarpet()
    local tool = char:FindFirstChild(REQUIRED_TOOL) or backpack:FindFirstChild(REQUIRED_TOOL)
    if not tool then return false end
    humanoid:EquipTool(tool)
    while char:FindFirstChildOfClass("Tool") ~= tool do task.wait() end
    return true
end

local function block(plr)
    if not plr or plr == player then return end
    pcall(function()
        StarterGui:SetCore("PromptBlockPlayer", plr)
    end)
end

local function teleportAll()
    if not equipFlyingCarpet() then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then lastStealer = plr break end
    end
    for _, spot in ipairs(spots) do
        hrp.CFrame = spot
        task.wait(0.12)
    end
    if lastStealer then block(lastStealer) end
end

TeleportButton.MouseButton1Click:Connect(teleportAll)

KeybindButton.MouseButton1Click:Connect(function()
    KeybindButton.Text = "Press a key..."
    waitingForKey = true
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if waitingForKey and input.UserInputType == Enum.UserInputType.Keyboard then
        teleportKey = input.KeyCode
        KeybindButton.Text = "Keybind: ["..teleportKey.Name.."]"
        waitingForKey = false
    elseif input.KeyCode == teleportKey then
        teleportAll()
    end
end)
end

-- =========================
-- KEY CHECK
-- =========================
Confirm.MouseButton1Click:Connect(function()
    if KeyBox.Text == CORRECT_KEY then
        Status.TextColor3 = Color3.fromRGB(80,255,120)
        Status.Text = "ACCESS GRANTED"
        task.wait(0.4)
        loadHub()
    else
        Status.TextColor3 = Color3.fromRGB(255,80,80)
        Status.Text = "INVALID KEY"
    end
end)

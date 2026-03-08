-- =============================================
--      FLOATING TOGGLE BUTTON (SH)
-- =============================================
local VirtualInputManager = game:GetService("VirtualInputManager")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SH_MobileToggle"
ScreenGui.Parent = game:GetService("CoreGui") -- Tetap ada meski mati/reset
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 15, 0.5, 0) -- Posisi kiri tengah
ToggleButton.Text = "SH"
ToggleButton.TextColor3 = Color3.fromRGB(0, 170, 255) -- Warna Biru StarHub
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.GothamBold

-- Membuat Button Bulat & Bergaris
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Parent = ToggleButton

-- Fitur Drag (Bisa digeser di Layar)
local dragging, dragInput, dragStart, startPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Trigger untuk Buka/Tutup Menu Linoria (Simulasi Key END)
ToggleButton.MouseButton1Click:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.End, false, game)
    task.wait(0.01)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.End, false, game)
end)

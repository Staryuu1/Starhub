-- =============================================
--      CLEAN FLOATING TOGGLE (SH)
-- =============================================
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Gunakan pcall untuk menghindari error jika ScreenGui sudah ada
local success, err = pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("SH_MobileToggle") then
        game:GetService("CoreGui").SH_MobileToggle:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SH_MobileToggle"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Size = UDim2.new(0, 50, 0, 50) -- Ukuran sedikit lebih kecil agar compact
ToggleButton.Position = UDim2.new(0, 15, 0.5, 0)
ToggleButton.Text = "SH"
ToggleButton.TextColor3 = Color3.fromRGB(0, 170, 255)
ToggleButton.TextSize = 18 -- Ukuran teks pas
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = true

-- Membuat Button Bulat
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

-- Stroke Tipis (Hanya untuk Outline, bukan untuk mempertebal tulisan)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1.5 -- Tipis saja agar elegan
UIStroke.Color = Color3.fromRGB(60, 60, 60) -- Warna abu-abu gelap agar tidak nabrak teks
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border -- Stroke hanya di pinggir Button, bukan di Teks
UIStroke.Parent = ToggleButton

-- Fitur Draggable (Bisa digeser)
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

-- Trigger untuk Buka/Tutup Menu (Key END)
ToggleButton.MouseButton1Click:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.End, false, game)
    task.wait(0.01)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.End, false, game)
end)

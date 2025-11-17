--// SERVICIOS
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

--// GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

-- BOTÓN PRINCIPAL
local open = Instance.new("ImageButton", gui)
open.Size = UDim2.new(0,130,0,50)
open.Position = UDim2.new(0.05,0,0.25,0)
open.Image = "rbxassetid://8045196294"

local lbl = Instance.new("TextLabel", open)
lbl.BackgroundTransparency = 1
lbl.Size = UDim2.new(1,0,1,0)
lbl.Text = "SEBAS HUB"
lbl.Font = Enum.Font.GothamBold
lbl.TextColor3 = Color3.fromRGB(255,255,0)
lbl.TextScaled = true

-- BOTÓN MOVIBLE
do
    local drag, start, pos
    open.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            start = i.Position
            pos = open.Position
        end
    end)
    open.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - start
            open.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
        end
    end)
end

-- VENTANA
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,150)
frame.Position = UDim2.new(0.15,0,0.25,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
Instance.new("UICorner", frame)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,0,40)
txt.Text = "SEBAS HUB"
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(255,255,0)
txt.Font = Enum.Font.GothamBold
txt.TextScaled = true

-- VENTANA MOVIBLE
do
    local drag, start, pos
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            start = i.Position
            pos = frame.Position
        end
    end)
    frame.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - start
            frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
        end
    end)
end

-- ABRIR/CERRAR
open.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- BOTÓN CONGELAR PARA LOS DEMÁS
local freeze = Instance.new("TextButton", frame)
freeze.Size = UDim2.new(0,200,0,60)
freeze.Position = UDim2.new(0.5,-100,0.55,-30)
freeze.Text = "Freezar Reputación"
freeze.BackgroundColor3 = Color3.fromRGB(70,70,70)
freeze.TextColor3 = Color3.fromRGB(255,255,255)
freeze.Font = Enum.Font.GothamBold
freeze.TextScaled = true
Instance.new("UICorner", freeze)

---------------------------------------------------------
-- FUNCIÓN PRINCIPAL: PARAR REPLICACIÓN
---------------------------------------------------------

local frozen = false
local savedCFrame

freeze.MouseButton1Click:Connect(function()

    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not frozen then
        frozen = true
        freeze.Text = "DESFREEZE"

        -- Guarda posición exacta
        savedCFrame = root.CFrame

        -- Congelar tu posición para los demás
        task.spawn(function()
            while frozen do
                -- Tú te mueves, pero tu posición enviada al servidor será SIEMPRE la misma
                root.CFrame = savedCFrame
                task.wait(0.1)
            end
        end)

    else
        frozen = false
        freeze.Text = "Freezar Reputación"
    end
end)

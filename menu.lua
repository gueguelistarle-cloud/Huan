-- PURPLE MENU • celular e PC

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PASSWORD = "xitomesmovaichorar?"

local PURPLE = Color3.fromRGB(170, 90, 255)
local DARK = Color3.fromRGB(12, 10, 18)
local PANEL = Color3.fromRGB(30, 24, 42)
local WHITE = Color3.fromRGB(245, 240, 255)

local options = {
    ESP = true,
    Box = true,
    Skeleton = true,
    Names = true,
    Aim = false,
    TeamCheck = true,
    FOV = 180,
    Smoothness = 0.18
}

local parent = (gethui and gethui()) or player:WaitForChild("PlayerGui")

local old = parent:FindFirstChild("PurpleUniversal")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "PurpleUniversal"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = parent

local function rounded(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = object
end

local function outline(object)
    local s = Instance.new("UIStroke")
    s.Color = PURPLE
    s.Thickness = 1.5
    s.Parent = object
end

local function makeLabel(parentObject, text, size, position, textSize)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size
    label.Position = position
    label.Text = text
    label.TextColor3 = WHITE
    label.TextSize = textSize or 14
    label.Font = Enum.Font.Gotham
    label.Parent = parentObject
    return label
end

local function makeButton(parentObject, text, size, position)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = PANEL
    button.TextColor3 = WHITE
    button.Text = text
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = parentObject
    rounded(button)
    return button
end

-- Tela de senha

local login = Instance.new("Frame")
login.Size = UDim2.fromOffset(300, 190)
login.AnchorPoint = Vector2.new(0.5, 0.5)
login.Position = UDim2.fromScale(0.5, 0.5)
login.BackgroundColor3 = DARK
login.Parent = gui
rounded(login, 12)
outline(login)

local loginTitle = makeLabel(
    login, "PURPLE • ACESSO",
    UDim2.new(1, 0, 0, 45),
    UDim2.fromOffset(0, 5), 20
)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextColor3 = PURPLE

local password = Instance.new("TextBox")
password.Size = UDim2.new(1, -40, 0, 38)
password.Position = UDim2.fromOffset(20, 55)
password.BackgroundColor3 = PANEL
password.TextColor3 = WHITE
password.PlaceholderText = "Digite a senha"
password.PlaceholderColor3 = Color3.fromRGB(160, 150, 175)
password.Text = ""
password.ClearTextOnFocus = false
password.Font = Enum.Font.Gotham
password.TextSize = 14
password.Parent = login
rounded(password)

local enter = makeButton(
    login, "ENTRAR",
    UDim2.new(1, -40, 0, 36),
    UDim2.fromOffset(20, 103)
)
enter.BackgroundColor3 = Color3.fromRGB(110, 45, 190)

local status = makeLabel(
    login, "",
    UDim2.new(1, 0, 0, 25),
    UDim2.fromOffset(0, 148), 12
)
status.TextColor3 = Color3.fromRGB(255, 100, 130)

-- Menu

local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(310, 390)
menu.AnchorPoint = Vector2.new(0.5, 0.5)
menu.Position = UDim2.fromScale(0.5, 0.5)
menu.BackgroundColor3 = DARK
menu.Visible = false
menu.Active = true
menu.Draggable = true
menu.Parent = gui
rounded(menu, 12)
outline(menu)

local title = makeLabel(
    menu, "PURPLE • MENU",
    UDim2.new(1, -50, 0, 38),
    UDim2.fromOffset(15, 5), 19
)
title.Font = Enum.Font.GothamBlack
title.TextColor3 = PURPLE
title.TextXAlignment = Enum.TextXAlignment.Left

local close = makeButton(
    menu, "X",
    UDim2.fromOffset(30, 30),
    UDim2.new(1, -38, 0, 8)
)
close.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

local info = makeLabel(
    menu, "Arraste o menu • Segure MIRA para mirar",
    UDim2.new(1, -20, 0, 20),
    UDim2.fromOffset(10, 40), 11
)
info.TextColor3 = Color3.fromRGB(175, 165, 190)

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -24, 1, -72)
list.Position = UDim2.fromOffset(12, 65)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
list.ScrollBarImageColor3 = PURPLE
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.CanvasSize = UDim2.new()
list.Parent = menu

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local function addToggle(text, key)
    local b = makeButton(list, "", UDim2.new(1, -6, 0, 35), UDim2.new())

    local function refresh()
        b.Text = text .. ": " .. (options[key] and "LIGADO" or "DESLIGADO")
        b.TextColor3 = options[key] and PURPLE or WHITE
    end

    b.MouseButton1Click:Connect(function()
        options[key] = not options[key]
        refresh()
    end)

    refresh()
end

addToggle("ESP", "ESP")
addToggle("ESP caixa", "Box")
addToggle("ESP esqueleto", "Skeleton")
addToggle("Nomes", "Names")
addToggle("Aimbot", "Aim")
addToggle("Ignorar mesma equipe", "TeamCheck")

local fovValues = {100, 180, 280, 400}
local fovIndex = 2
local fovButton = makeButton(list, "", UDim2.new(1, -6, 0, 35), UDim2.new())

local function updateFov()
    fovButton.Text = "FOV da mira: " .. options.FOV
end

fovButton.MouseButton1Click:Connect(function()
    fovIndex = fovIndex % #fovValues + 1
    options.FOV = fovValues[fovIndex]
    updateFov()
end)
updateFov()

local smoothValues = {0.08, 0.18, 0.35}
local smoothNames = {"Suave", "Médio", "Rápido"}
local smoothIndex = 2
local smoothButton = makeButton(list, "", UDim2.new(1, -6, 0, 35), UDim2.new())

local function updateSmooth()
    smoothButton.Text = "Velocidade: " .. smoothNames[smoothIndex]
end

smoothButton.MouseButton1Click:Connect(function()
    smoothIndex = smoothIndex % #smoothValues + 1
    options.Smoothness = smoothValues[smoothIndex]
    updateSmooth()
end)
updateSmooth()

-- Botões para celular

local menuButton = makeButton(
    gui, "MENU",
    UDim2.fromOffset(70, 38),
    UDim2.new(0, 10, 0.5, -20)
)
menuButton.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
menuButton.Visible = false
outline(menuButton)

local aimButton = makeButton(
    gui, "SEGURE\nMIRA",
    UDim2.fromOffset(75, 50),
    UDim2.new(1, -85, 0.5, -25)
)
aimButton.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
aimButton.Visible = false
outline(aimButton)

local authenticated = false
local aiming = false

menuButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

aimButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        aiming = true
    end
end)

aimButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        aiming = false
    end
end)

UIS.InputBegan:Connect(function(input, processed)
    if not processed and authenticated
        and input.KeyCode == Enum.KeyCode.RightShift then
        menu.Visible = not menu.Visible
    end
end)

enter.MouseButton1Click:Connect(function()
    if password.Text == PASSWORD then
        authenticated = true
        password.Text = ""
        login.Visible = false
        menu.Visible = true
        menuButton.Visible = true
        aimButton.Visible = UIS.TouchEnabled
    else
        status.Text = "Senha incorreta."
        password.Text = ""
    end
end)

-- ESP

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundTransparency = 1
overlay.Parent = gui

local visuals = {}

local R15 = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

local R6 = {
    {"Head", "Torso"},
    {"Torso", "Left Arm"},
    {"Torso", "Right Arm"},
    {"Torso", "Left Leg"},
    {"Torso", "Right Leg"}
}

local function createVisual(target)
    if target == player or visuals[target] then
        return
    end

    local folder = Instance.new("Folder")
    folder.Name = target.Name
    folder.Parent = overlay

    local box = Instance.new("Frame")
    box.BackgroundTransparency = 1
    box.Visible = false
    box.Parent = folder
    outline(box)

    local name = makeLabel(
        folder, target.DisplayName,
        UDim2.fromOffset(200, 20),
        UDim2.new(), 13
    )
    name.AnchorPoint = Vector2.new(0.5, 1)
    name.TextStrokeTransparency = 0.3
    name.Visible = false

    local lines = {}
    for i = 1, #R15 do
        local line = Instance.new("Frame")
        line.BorderSizePixel = 0
        line.BackgroundColor3 = PURPLE
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Visible = false
        line.Parent = folder
        lines[i] = line
    end

    visuals[target] = {
        folder = folder,
        box = box,
        name = name,
        lines = lines
    }
end

local function hide(data)
    data.box.Visible = false
    data.name.Visible = false
    for _, line in ipairs(data.lines) do
        line.Visible = false
    end
end

local function valid(target)
    if target == player then
        return false
    end

    if options.TeamCheck and player.Team ~= nil
        and target.Team == player.Team then
        return false
    end

    local character = target.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    return character ~= nil and humanoid ~= nil and humanoid.Health > 0
end

local function project(camera, position)
    local point, onScreen = camera:WorldToViewportPoint(position)
    return Vector2.new(point.X, point.Y), onScreen and point.Z > 0
end

local function drawLine(line, a, b)
    local delta = b - a
    line.Position = UDim2.fromOffset((a.X + b.X) / 2, (a.Y + b.Y) / 2)
    line.Size = UDim2.fromOffset(delta.Magnitude, 2)
    line.Rotation = math.deg(math.atan2(delta.Y, delta.X))
    line.Visible = true
end

local function updateVisual(camera, target, data)
    hide(data)

    if not authenticated or not options.ESP or not valid(target) then
        return
    end

    local character = target.Character
    local head = character:FindFirstChild("Head")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not head or not root then
        return
    end

    local top, topVisible = project(camera, head.Position + Vector3.new(0, 0.7, 0))
    local bottom, bottomVisible = project(camera, root.Position - Vector3.new(0, 3, 0))

    if not topVisible or not bottomVisible then
        return
    end

    local height = math.abs(bottom.Y - top.Y)
    local width = height * 0.55
    local centerX = (top.X + bottom.X) / 2
    local topY = math.min(top.Y, bottom.Y)

    if options.Box then
        data.box.Position = UDim2.fromOffset(centerX - width / 2, topY)
        data.box.Size = UDim2.fromOffset(width, height)
        data.box.Visible = true
    end

    if options.Names then
        data.name.Position = UDim2.fromOffset(centerX, topY - 3)
        data.name.Visible = true
    end

    if options.Skeleton then
        local bones = character:FindFirstChild("UpperTorso") and R15 or R6
        for i, bone in ipairs(bones) do
            local a = character:FindFirstChild(bone[1])
            local b = character:FindFirstChild(bone[2])

            if a and b then
                local p1, visible1 = project(camera, a.Position)
                local p2, visible2 = project(camera, b.Position)
                if visible1 and visible2 then
                    drawLine(data.lines[i], p1, p2)
                end
            end
        end
    end
end

for _, target in ipairs(Players:GetPlayers()) do
    createVisual(target)
end

local addedConnection = Players.PlayerAdded:Connect(createVisual)

local removedConnection = Players.PlayerRemoving:Connect(function(target)
    local data = visuals[target]
    if data then
        data.folder:Destroy()
        visuals[target] = nil
    end
end)

local renderConnection
renderConnection = RunService.RenderStepped:Connect(function()
    if not gui.Parent then
        renderConnection:Disconnect()
        addedConnection:Disconnect()
        removedConnection:Disconnect()
        return
    end

    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    for target, data in pairs(visuals) do
        updateVisual(camera, target, data)
    end

    if not authenticated or not options.Aim then
        return
    end

    local rightMouse = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    if not aiming and not rightMouse then
        return
    end

    local center
    if aiming and UIS.TouchEnabled then
        center = camera.ViewportSize / 2
    else
        center = UIS:GetMouseLocation()
    end

    local bestHead = nil
    local bestDistance = options.FOV

    for _, target in ipairs(Players:GetPlayers()) do
        if valid(target) then
            local head = target.Character:FindFirstChild("Head")
            if head then
                local screenPoint, visible = project(camera, head.Position)
                local distance = (screenPoint - center).Magnitude

                if visible and distance < bestDistance then
                    bestDistance = distance
                    bestHead = head
                end
            end
        end
    end

    if bestHead then
        local desired = CFrame.lookAt(camera.CFrame.Position, bestHead.Position)
        camera.CFrame = camera.CFrame:Lerp(desired, options.Smoothness)
    end
end)

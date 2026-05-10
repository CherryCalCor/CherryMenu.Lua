-- Cherry Menu V12 [Rollback & Full Restore]
-- Base: V6 [TP Update] + Fixed ESP/More/Visuals
-- Credits: MonliteLLT, CherryCalcor, Grenki_Waves, top10064

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("CherryMenuV12") then CoreGui.CherryMenuV12:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CherryMenuV12"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Функция уведомлений
local function Notify(text)
    spawn(function()
        local NotifFrame = Instance.new("Frame", ScreenGui)
        local UICorner = Instance.new("UICorner", NotifFrame)
        local NotifText = Instance.new("TextLabel", NotifFrame)
        NotifFrame.Size = UDim2.new(0, 220, 0, 45)
        NotifFrame.Position = UDim2.new(1, 20, 0.8, 0)
        NotifFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        NotifFrame.BackgroundTransparency = 0.2
        NotifFrame.ZIndex = 1000
        UICorner.CornerRadius = UDim.new(0, 10)
        NotifText.Size = UDim2.new(1, -10, 1, 0)
        NotifText.Position = UDim2.new(0, 10, 0, 0)
        NotifText.BackgroundTransparency = 1
        NotifText.Text = text
        NotifText.TextColor3 = Color3.new(1, 1, 1)
        NotifText.Font = Enum.Font.GothamBold
        NotifText.TextSize = 13
        NotifText.TextXAlignment = Enum.TextXAlignment.Left
        NotifFrame:TweenPosition(UDim2.new(1, -240, 0.8, 0), "Out", "Back", 0.4, true)
        task.wait(2.5)
        NotifFrame:TweenPosition(UDim2.new(1, 20, 0.8, 0), "In", "Back", 0.4, true)
        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

-- Функция перетаскивания (только за Header)
local function MakeDraggable(frame, handle)
    local dragging, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function() dragging = false end)
end

-- ЗАГРУЗОЧНЫЙ ЭКРАН
local Loading = Instance.new("Frame", ScreenGui)
Loading.Size = UDim2.new(0, 280, 0, 130); Loading.Position = UDim2.new(0.5, -140, 0.5, -65)
Loading.BackgroundColor3 = Color3.fromRGB(15, 0, 0); Loading.BackgroundTransparency = 0.3
Loading.ZIndex = 100
Instance.new("UICorner", Loading).CornerRadius = UDim.new(0, 15)
local LText = Instance.new("TextLabel", Loading)
LText.Size = UDim2.new(1, 0, 1, 0); LText.BackgroundTransparency = 1; LText.ZIndex = 101
LText.Text = "Cherry V12\nRestoring All Features..."; LText.TextColor3 = Color3.fromRGB(255, 0, 0); LText.Font = Enum.Font.GothamBold; LText.TextSize = 20

-- ГЛАВНОЕ МЕНЮ
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 300); MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18); MainFrame.BackgroundTransparency = 0.2
MainFrame.Visible = false; MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 45); Header.BackgroundTransparency = 1; Header.ZIndex = 20
MakeDraggable(MainFrame, Header)

local Title = Instance.new("TextLabel", Header)
Title.Text = "CherryMenu"; Title.TextColor3 = Color3.fromRGB(255, 0, 0); Title.Font = Enum.Font.GothamBold; Title.TextSize = 20
Title.Position = UDim2.new(0, 15, 0, 0); Title.Size = UDim2.new(0, 120, 1, 0); Title.BackgroundTransparency = 1; Title.ZIndex = 21

-- Управление (Закрыть/Свернуть)
local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 30, 0, 30); Close.Position = UDim2.new(1, -40, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0); Close.Text = "X"; Close.TextColor3 = Color3.new(1,1,1); Close.ZIndex = 25
Instance.new("UICorner", Close); Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Size = UDim2.new(0, 125, 1, -110); Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundTransparency = 1; Sidebar.ScrollBarThickness = 0; Sidebar.ZIndex = 15
local Layout = Instance.new("UIListLayout", Sidebar); Layout.Padding = UDim.new(0, 6)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -155, 1, -60); Container.Position = UDim2.new(0, 145, 0, 50)
Container.BackgroundTransparency = 1; Container.ZIndex = 15

-- ПРОФИЛЬ
local ProfileCorner = Instance.new("Frame", MainFrame)
ProfileCorner.Size = UDim2.new(0, 135, 0, 50); ProfileCorner.Position = UDim2.new(0, 5, 1, -55)
ProfileCorner.BackgroundTransparency = 1; ProfileCorner.ZIndex = 16
local Pfp = Instance.new("ImageLabel", ProfileCorner)
Pfp.Size = UDim2.new(0, 40, 0, 40); Pfp.Position = UDim2.new(0, 5, 0.5, -20); Pfp.ZIndex = 17
Instance.new("UICorner", Pfp).CornerRadius = UDim.new(1, 0)
pcall(function() Pfp.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100) end)
local Greeting = Instance.new("TextLabel", ProfileCorner)
Greeting.Size = UDim2.new(1, -55, 1, 0); Greeting.Position = UDim2.new(0, 50, 0, 0); Greeting.BackgroundTransparency = 1; Greeting.RichText = true; Greeting.Text = "Hello,<br/><font color='#FF0000'><b>" .. (Player.DisplayName or Player.Name) .. "</b></font>"; Greeting.TextColor3 = Color3.new(1, 1, 1); Greeting.Font = Enum.Font.GothamBold; Greeting.TextSize = 12; Greeting.ZIndex = 17; Greeting.TextXAlignment = Enum.TextXAlignment.Left

-- Сворачивание
local isMin = false
local Min = Instance.new("TextButton", Header)
Min.Size = UDim2.new(0, 30, 0, 30); Min.Position = UDim2.new(1, -75, 0, 7)
Min.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Min.Text = "-"; Min.TextColor3 = Color3.new(1,1,1); Min.ZIndex = 25
Instance.new("UICorner", Min)
Min.MouseButton1Click:Connect(function()
    isMin = not isMin
    Sidebar.Visible = not isMin; Container.Visible = not isMin; ProfileCorner.Visible = not isMin
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = isMin and UDim2.new(0, 450, 0, 45) or UDim2.new(0, 450, 0, 300)}):Play()
end)

-- Хелпер-функции для UI
local function CreateTab(name, isDefault)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = isDefault or false
    Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = Enum.AutomaticSize.Y; Page.ZIndex = 20
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)
    local TabBtn = Instance.new("TextButton", Sidebar); TabBtn.Size = UDim2.new(0.95, 0, 0, 35); TabBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    TabBtn.Text = name; TabBtn.TextColor3 = Color3.new(1,1,1); TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 13; TabBtn.ZIndex = 20; Instance.new("UICorner", TabBtn)
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
        Page.Visible = true
    end)
    return Page
end

local function CreateSlider(parent, text, min, max, def, callback)
    local SFrame = Instance.new("Frame", parent); SFrame.Size = UDim2.new(0.95, 0, 0, 50); SFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25); SFrame.ZIndex = 21
    Instance.new("UICorner", SFrame)
    local T = Instance.new("TextLabel", SFrame); T.Size = UDim2.new(1, 0, 0, 20); T.Text = text .. ": " .. def; T.TextColor3 = Color3.new(1,1,1); T.BackgroundTransparency = 1; T.ZIndex = 22
    local Bar = Instance.new("Frame", SFrame); Bar.Size = UDim2.new(0.8, 0, 0, 6); Bar.Position = UDim2.new(0.1, 0, 0.7, 0); Bar.BackgroundColor3 = Color3.fromRGB(50, 0, 0); Bar.ZIndex = 22
    local Fill = Instance.new("Frame", Bar); Fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); Fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0); Fill.ZIndex = 23
    local active = false
    local function Update()
        local pos = math.clamp((UserInputService:GetMouseLocation().X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(pos, 0, 1, 0); local val = math.floor(min + (max - min) * pos); T.Text = text .. ": " .. val; callback(val)
    end
    Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then active = true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then active = false end end)
    RunService.RenderStepped:Connect(function() if active then Update() end end)
end

local function CreateBtn(parent, text, cb)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0.95, 0, 0, 35); b.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    b.Text = text; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold; b.ZIndex = 30; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() cb(b) end)
    return b
end

-- ================= РАЗДЕЛЫ =================

local DevPage = CreateTab("Developers", true)
local DevLabel = Instance.new("TextLabel", DevPage)
DevLabel.Size = UDim2.new(1, 0, 0, 70); DevLabel.BackgroundTransparency = 1; DevLabel.TextColor3 = Color3.new(1,1,1); DevLabel.ZIndex = 31
DevLabel.Text = "Idea: MonliteLLT\nGUI: CherryCalcor\nFunctions: Grenki_Waves / top10064"

-- РАЗДЕЛ MOVEMENT / TP
local MovePage = CreateTab("Movement / TP")
CreateSlider(MovePage, "WalkSpeed", 16, 500, 16, function(v) if Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.WalkSpeed = v end end)
CreateSlider(MovePage, "JumpPower", 50, 500, 50, function(v) if Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.UseJumpPower = true; Player.Character.Humanoid.JumpPower = v end end)

-- PLAYER TELEPORT LIST
local PlayerListFrame = Instance.new("Frame", ScreenGui)
PlayerListFrame.Size = UDim2.new(0, 200, 0, 250); PlayerListFrame.Position = UDim2.new(0.5, 235, 0.5, -125)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); PlayerListFrame.Visible = false; PlayerListFrame.ZIndex = 50
Instance.new("UICorner", PlayerListFrame)
MakeDraggable(PlayerListFrame, PlayerListFrame)

local ListClose = Instance.new("TextButton", PlayerListFrame)
ListClose.Size = UDim2.new(0, 20, 0, 20); ListClose.Position = UDim2.new(1, -25, 0, 5); ListClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0); ListClose.Text = "X"; ListClose.ZIndex = 51; Instance.new("UICorner", ListClose); ListClose.MouseButton1Click:Connect(function() PlayerListFrame.Visible = false end)

local ListScroll = Instance.new("ScrollingFrame", PlayerListFrame)
ListScroll.Size = UDim2.new(1, -10, 1, -40); ListScroll.Position = UDim2.new(0, 5, 0, 35); ListScroll.BackgroundTransparency = 1; ListScroll.ZIndex = 51; ListScroll.CanvasSize = UDim2.new(0,0,0,0); ListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y; Instance.new("UIListLayout", ListScroll).Padding = UDim.new(0, 5)

CreateBtn(MovePage, "Player Teleport List", function()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
    if PlayerListFrame.Visible then
        for _, v in pairs(ListScroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Player then
                local pf = Instance.new("Frame", ListScroll); pf.Size = UDim2.new(1, 0, 0, 30); pf.BackgroundTransparency = 1; pf.ZIndex = 52
                local pn = Instance.new("TextLabel", pf); pn.Size = UDim2.new(0.7, 0, 1, 0); pn.Text = p.DisplayName; pn.TextColor3 = Color3.new(1,1,1); pn.BackgroundTransparency = 1; pn.ZIndex = 53; pn.TextXAlignment = Enum.TextXAlignment.Left
                local pt = Instance.new("TextButton", pf); pt.Size = UDim2.new(0.25, 0, 0.8, 0); pt.Position = UDim2.new(0.7, 0, 0.1, 0); pt.Text = "TP"; pt.BackgroundColor3 = Color3.fromRGB(150,0,0); pt.ZIndex = 53
                Instance.new("UICorner", pt); pt.MouseButton1Click:Connect(function() Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end)
            end
        end
    end
end)

CreateBtn(MovePage, "Fly GUI V3", function()
    if game.CoreGui:FindFirstChild("main") then
        game.CoreGui.main:Destroy()
    end

    local main = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local up = Instance.new("TextButton")
    local down = Instance.new("TextButton")
    local onof = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    local plus = Instance.new("TextButton")
    local speed = Instance.new("TextLabel")
    local mine = Instance.new("TextButton")
    local closebutton = Instance.new("TextButton")
    local mini = Instance.new("TextButton")
    local mini2 = Instance.new("TextButton")

    main.Name = "main"
    main.Parent = CoreGui
    main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    main.ResetOnSpawn = false

    Frame.Parent = main
    Frame.BackgroundColor3 = Color3.fromRGB(163,255,137)
    Frame.BorderColor3 = Color3.fromRGB(103,221,213)
    Frame.Position = UDim2.new(0.1,0,0.38,0)
    Frame.Size = UDim2.new(0,190,0,57)

    up.Parent = Frame
    up.BackgroundColor3 = Color3.fromRGB(79,255,152)
    up.Size = UDim2.new(0,44,0,28)
    up.Text = "UP"

    down.Parent = Frame
    down.BackgroundColor3 = Color3.fromRGB(215,255,121)
    down.Position = UDim2.new(0,0,0.49,0)
    down.Size = UDim2.new(0,44,0,28)
    down.Text = "DOWN"

    onof.Parent = Frame
    onof.BackgroundColor3 = Color3.fromRGB(255,249,74)
    onof.Position = UDim2.new(0.70,0,0.49,0)
    onof.Size = UDim2.new(0,56,0,28)
    onof.Text = "fly"

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(242,60,255)
    TextLabel.Position = UDim2.new(0.47,0,0,0)
    TextLabel.Size = UDim2.new(0,100,0,28)
    TextLabel.Text = "FLY GUI V3"
    TextLabel.TextScaled = true

    plus.Parent = Frame
    plus.BackgroundColor3 = Color3.fromRGB(133,145,255)
    plus.Position = UDim2.new(0.23,0,0,0)
    plus.Size = UDim2.new(0,45,0,28)
    plus.Text = "+"

    speed.Parent = Frame
    speed.BackgroundColor3 = Color3.fromRGB(255,85,0)
    speed.Position = UDim2.new(0.47,0,0.49,0)
    speed.Size = UDim2.new(0,44,0,28)
    speed.Text = "1"

    mine.Parent = Frame
    mine.BackgroundColor3 = Color3.fromRGB(123,255,247)
    mine.Position = UDim2.new(0.23,0,0.49,0)
    mine.Size = UDim2.new(0,45,0,29)
    mine.Text = "-"

    closebutton.Name = "Close"
    closebutton.Parent = Frame
    closebutton.BackgroundColor3 = Color3.fromRGB(225,25,0)
    closebutton.Size = UDim2.new(0,45,0,28)
    closebutton.Text = "X"
    closebutton.TextSize = 30
    closebutton.Position = UDim2.new(0,0,-1,27)

    mini.Parent = Frame
    mini.BackgroundColor3 = Color3.fromRGB(192,150,230)
    mini.Size = UDim2.new(0,45,0,28)
    mini.Text = "-"
    mini.TextSize = 40
    mini.Position = UDim2.new(0,44,-1,27)

    mini2.Parent = Frame
    mini2.BackgroundColor3 = Color3.fromRGB(192,150,230)
    mini2.Size = UDim2.new(0,45,0,28)
    mini2.Text = "+"
    mini2.TextSize = 40
    mini2.Position = UDim2.new(0,44,-1,57)
    mini2.Visible = false

    Frame.Active = true
    Frame.Draggable = true

    local speeds = 1
    local fly = false
    local UIS = game:GetService("UserInputService")
    local RS = game:GetService("RunService")

    local bv
    local bg

    local function StopFly()
        fly = false

        if bv then bv:Destroy() end
        if bg then bg:Destroy() end

        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end

    local function StartFly()
        local char = Player.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")

        if not hrp or not hum then return end

        fly = true
        hum.PlatformStand = true

        bg = Instance.new("BodyGyro", hrp)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9,9e9,9e9)

        bv = Instance.new("BodyVelocity", hrp)
        bv.maxForce = Vector3.new(9e9,9e9,9e9)

        RS.RenderStepped:Connect(function()
            if not fly then return end

            hum.PlatformStand = true
            bg.CFrame = Camera.CFrame

            local vel = Vector3.zero

            if UIS:IsKeyDown(Enum.KeyCode.W) then
                vel += Camera.CFrame.LookVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.S) then
                vel -= Camera.CFrame.LookVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.A) then
                vel -= Camera.CFrame.RightVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.D) then
                vel += Camera.CFrame.RightVector
            end

            bv.Velocity = vel * (speeds * 25)
        end)
    end

    onof.MouseButton1Click:Connect(function()
        if fly then
            StopFly()
            Notify("Fly OFF")
        else
            StartFly()
            Notify("Fly ON")
        end
    end)

    plus.MouseButton1Click:Connect(function()
        speeds += 1
        speed.Text = tostring(speeds)
    end)

    mine.MouseButton1Click:Connect(function()
        if speeds > 1 then
            speeds -= 1
            speed.Text = tostring(speeds)
        end
    end)

    up.MouseButton1Click:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,5,0)
        end
    end)

    down.MouseButton1Click:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,-5,0)
        end
    end)

    closebutton.MouseButton1Click:Connect(function()
        StopFly()
        main:Destroy()
    end)

    mini.MouseButton1Click:Connect(function()
        up.Visible = false
        down.Visible = false
        onof.Visible = false
        plus.Visible = false
        speed.Visible = false
        mine.Visible = false
        mini.Visible = false
        mini2.Visible = true
        Frame.BackgroundTransparency = 1
    end)

    mini2.MouseButton1Click:Connect(function()
        up.Visible = true
        down.Visible = true
        onof.Visible = true
        plus.Visible = true
        speed.Visible = true
        mine.Visible = true
        mini.Visible = true
        mini2.Visible = false
        Frame.BackgroundTransparency = 0
    end)

    Notify("Fly GUI Loaded")
end)

local ESPPage = CreateTab("ESP")
-- РАЗДЕЛ ESP (ON/OFF)

local namesEspEnabled = false
local highlightsEnabled = false

-- NAME ESP
CreateBtn(ESPPage, "Names ESP: OFF", function(self)
    namesEspEnabled = not namesEspEnabled
    self.Text = namesEspEnabled and "Names ESP: ON" or "Names ESP: OFF"

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then

            local old = v.Character.Head:FindFirstChild("CherryNameESP")
            if old then
                old:Destroy()
            end

            if namesEspEnabled then
                local b = Instance.new("BillboardGui")
                b.Name = "CherryNameESP"
                b.Parent = v.Character.Head
                b.Size = UDim2.new(0,100,0,50)
                b.AlwaysOnTop = true
                b.ExtentsOffset = Vector3.new(0,2,0)

                local l = Instance.new("TextLabel")
                l.Parent = b
                l.Size = UDim2.new(1,0,1,0)
                l.BackgroundTransparency = 1
                l.Text = v.Name
                l.TextColor3 = Color3.new(1,0,0)
                l.Font = Enum.Font.GothamBold
                l.TextScaled = true
            end
        end
    end

    Notify("Names ESP " .. (namesEspEnabled and "ON" or "OFF"))
end)

-- CS2 HIGHLIGHT
CreateBtn(ESPPage, "CS2 Highlight: OFF", function(self)
    highlightsEnabled = not highlightsEnabled
    self.Text = highlightsEnabled and "CS2 Highlight: ON" or "CS2 Highlight: OFF"

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= Player and v.Character then

            local old = v.Character:FindFirstChild("CherryHighlight")
            if old then
                old:Destroy()
            end

            if highlightsEnabled then
                local hl = Instance.new("Highlight")
                hl.Name = "CherryHighlight"
                hl.Parent = v.Character
                hl.FillColor = Color3.new(1,0,0)
                hl.FillTransparency = 0.5
                hl.OutlineColor = Color3.new(1,1,1)
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    end

    Notify("CS2 Highlight " .. (highlightsEnabled and "ON" or "OFF"))
end)

-- SPECTATE SYSTEM
local SpectateFrame = Instance.new("Frame", ScreenGui)
SpectateFrame.Size = UDim2.new(0, 200, 0, 250)
SpectateFrame.Position = UDim2.new(0.5, 235, 0.5, 140)
SpectateFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpectateFrame.Visible = false
SpectateFrame.ZIndex = 50
Instance.new("UICorner", SpectateFrame)

MakeDraggable(SpectateFrame, SpectateFrame)

local SpectateClose = Instance.new("TextButton", SpectateFrame)
SpectateClose.Size = UDim2.new(0, 20, 0, 20)
SpectateClose.Position = UDim2.new(1, -25, 0, 5)
SpectateClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
SpectateClose.Text = "X"
SpectateClose.TextColor3 = Color3.new(1,1,1)
SpectateClose.ZIndex = 51
Instance.new("UICorner", SpectateClose)

SpectateClose.MouseButton1Click:Connect(function()
    SpectateFrame.Visible = false
end)

local SpectateScroll = Instance.new("ScrollingFrame", SpectateFrame)
SpectateScroll.Size = UDim2.new(1, -10, 1, -40)
SpectateScroll.Position = UDim2.new(0, 5, 0, 35)
SpectateScroll.BackgroundTransparency = 1
SpectateScroll.ScrollBarThickness = 0
SpectateScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SpectateScroll.ZIndex = 51

Instance.new("UIListLayout", SpectateScroll).Padding = UDim.new(0, 5)

local spectating = false
local currentTarget = nil

CreateBtn(ESPPage, "Spectate Player List", function()
    SpectateFrame.Visible = not SpectateFrame.Visible

    if SpectateFrame.Visible then
        for _, v in pairs(SpectateScroll:GetChildren()) do
            if v:IsA("Frame") then
                v:Destroy()
            end
        end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Player then
                local pf = Instance.new("Frame", SpectateScroll)
                pf.Size = UDim2.new(1, 0, 0, 30)
                pf.BackgroundTransparency = 1

                local pn = Instance.new("TextLabel", pf)
                pn.Size = UDim2.new(0.6, 0, 1, 0)
                pn.BackgroundTransparency = 1
                pn.Text = p.DisplayName
                pn.TextColor3 = Color3.new(1,1,1)
                pn.Font = Enum.Font.GothamBold
                pn.TextXAlignment = Enum.TextXAlignment.Left

                local sp = Instance.new("TextButton", pf)
                sp.Size = UDim2.new(0.35, 0, 0.8, 0)
                sp.Position = UDim2.new(0.63, 0, 0.1, 0)
                sp.BackgroundColor3 = Color3.fromRGB(150,0,0)
                sp.Text = "Watch"
                sp.TextColor3 = Color3.new(1,1,1)
                sp.Font = Enum.Font.GothamBold

                Instance.new("UICorner", sp)

                sp.MouseButton1Click:Connect(function()
                    if p.Character and p.Character:FindFirstChild("Humanoid") then
                        spectating = true
                        currentTarget = p
                        Camera.CameraSubject = p.Character.Humanoid
                        Notify("Watching: " .. p.Name)
                    end
                end)
            end
        end
    end
end)

CreateBtn(ESPPage, "Stop Spectate", function()
    spectating = false
    currentTarget = nil

    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = Player.Character.Humanoid
    end

    Notify("Spectate OFF")
end)

Players.PlayerRemoving:Connect(function(p)
    if currentTarget == p then
        spectating = false
        currentTarget = nil

        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = Player.Character.Humanoid
        end

        Notify("Player left game")
    end
end)

-- РАЗДЕЛ MORE (ВОССТАНОВЛЕН)
local MorePage = CreateTab("More")
local noclip = false
CreateBtn(MorePage, "Noclip: OFF", function(self)
    noclip = not noclip; self.Text = noclip and "Noclip: ON" or "Noclip: OFF"
    Notify("Noclip " .. (noclip and "ON" or "OFF"))
end)
RunService.Stepped:Connect(function()
    if noclip and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

local freecam = false
CreateBtn(MorePage, "Free Cam: OFF", function(self)
    freecam = not freecam; self.Text = freecam and "Free Cam: ON" or "Free Cam: OFF"
    Camera.CameraType = freecam and Enum.CameraType.Scriptable or Enum.CameraType.Custom
    Notify("Free Cam " .. (freecam and "ON" or "OFF"))
end)

CreateBtn(MorePage, "Anti-AFK", function()
    Player.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
    Notify("Anti-AFK ON")
end)

-- REJOIN
CreateBtn(MorePage, "Rejoin Server", function()
    Notify("Rejoining...")
    
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, Player)
end)

-- SERVER HOP
CreateBtn(MorePage, "Join Another Server", function()
    Notify("Searching server...")

    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")

    local servers = {}
    local req = game:HttpGet(
        "https://games.roblox.com/v1/games/" ..
        game.PlaceId ..
        "/servers/Public?sortOrder=Asc&limit=100"
    )

    local data = HttpService:JSONDecode(req)

    for _, server in pairs(data.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end

    if #servers > 0 then
        local randomServer = servers[math.random(1, #servers)]

        Notify("Joining new server...")
        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,
            randomServer,
            Player
        )
    else
        Notify("No available servers found")
    end
end)

CreateBtn(MorePage, "Boost FPS", function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic; v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
    end
    Notify("FPS Boosted")
end)

-- NVIDIA STYLE FPS OVERLAY
local overlayEnabled = false
local overlayGui = nil
local overlayLoop = nil

CreateBtn(MorePage, "FPS Overlay: OFF", function(self)

    overlayEnabled = not overlayEnabled
    self.Text = overlayEnabled and "FPS Overlay: ON" or "FPS Overlay: OFF"

    if overlayEnabled then

        overlayGui = Instance.new("ScreenGui")
        overlayGui.Name = "CherryOverlay"
        overlayGui.Parent = CoreGui
        overlayGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local frame = Instance.new("Frame", overlayGui)
        frame.Size = UDim2.new(0, 220, 0, 110)
        frame.Position = UDim2.new(0, 15, 0, 15)
        frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
        frame.BackgroundTransparency = 0.25
        frame.BorderSizePixel = 0
        frame.ZIndex = 999

        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1,0,0,22)
        title.BackgroundTransparency = 1
        title.Text = "NVIDIA PERFORMANCE"
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        title.TextColor3 = Color3.fromRGB(0,255,120)

        local stats = Instance.new("TextLabel", frame)
        stats.Size = UDim2.new(1,-10,1,-25)
        stats.Position = UDim2.new(0,5,0,25)
        stats.BackgroundTransparency = 1
        stats.TextXAlignment = Enum.TextXAlignment.Left
        stats.TextYAlignment = Enum.TextYAlignment.Top
        stats.Font = Enum.Font.Code
        stats.TextSize = 14
        stats.RichText = true
        stats.TextColor3 = Color3.new(1,1,1)

        local StatsService = game:GetService("Stats")

        local fps = 0

        RunService.RenderStepped:Connect(function()
            fps += 1
        end)

        overlayLoop = task.spawn(function()

            while overlayEnabled and overlayGui do

                task.wait(1)

                local ping = math.floor(
                    StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
                )

                -- ПСЕВДО НАГРУЗКА
                local gpuLoad = math.random(35,99)
                local cpuLoad = math.random(20,85)

                -- ПСЕВДО ТЕМПЕРАТУРЫ
                local gpuTemp = math.random(45,80)
                local cpuTemp = math.random(40,75)

                stats.Text =
                    "<font color='#00ff88'>FPS:</font> " .. fps ..
                    "\n<font color='#00ff88'>PING:</font> " .. ping .. " ms" ..
                    "\n<font color='#00ff88'>GPU:</font> " .. gpuLoad .. "%" ..
                    "  [" .. gpuTemp .. "°C]" ..
                    "\n<font color='#00ff88'>CPU:</font> " .. cpuLoad .. "%" ..
                    "  [" .. cpuTemp .. "°C]"

                fps = 0
            end
        end)

        Notify("FPS Overlay Enabled")

    else

        if overlayGui then
            overlayGui:Destroy()
            overlayGui = nil
        end

        Notify("FPS Overlay Disabled")
    end
end)

-- РАЗДЕЛ INFORMATION
local InfoPage = CreateTab("Information")

local FPSLabel = Instance.new("TextLabel", InfoPage)
FPSLabel.Size = UDim2.new(0.95, 0, 0, 35)
FPSLabel.BackgroundColor3 = Color3.fromRGB(25,25,25)
FPSLabel.TextColor3 = Color3.new(1,1,1)
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 14
FPSLabel.Text = "FPS: 0"
FPSLabel.ZIndex = 30
Instance.new("UICorner", FPSLabel)

local PingLabel = Instance.new("TextLabel", InfoPage)
PingLabel.Size = UDim2.new(0.95, 0, 0, 35)
PingLabel.BackgroundColor3 = Color3.fromRGB(25,25,25)
PingLabel.TextColor3 = Color3.new(1,1,1)
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 14
PingLabel.Text = "Ping: 0 ms"
PingLabel.ZIndex = 30
Instance.new("UICorner", PingLabel)

local TimeLabel = Instance.new("TextLabel", InfoPage)
TimeLabel.Size = UDim2.new(0.95, 0, 0, 35)
TimeLabel.BackgroundColor3 = Color3.fromRGB(25,25,25)
TimeLabel.TextColor3 = Color3.new(1,1,1)
TimeLabel.Font = Enum.Font.GothamBold
TimeLabel.TextSize = 14
TimeLabel.Text = "Server Time: 0s"
TimeLabel.ZIndex = 30
Instance.new("UICorner", TimeLabel)

-- ОБНОВЛЕНИЕ INFORMATION
local Stats = game:GetService("Stats")
local startTick = tick()

task.spawn(function()
    local fps = 0
    local last = tick()

    RunService.RenderStepped:Connect(function()
        fps += 1
    end)

    while true do
        task.wait(1)

        FPSLabel.Text = "FPS: " .. tostring(fps)

        fps = 0

        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        PingLabel.Text = "Ping: " .. tostring(ping) .. " ms"

        local elapsed = math.floor(tick() - startTick)

        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60

        TimeLabel.Text = string.format(
            "Server Time: %02d:%02d:%02d",
            hours,
            minutes,
            seconds
        )
    end
end)

-- FUNNY TAB
local FunnyPage = CreateTab("Funny")

local stalking = false
local stalkTarget = nil
local stalkConnection = nil

-- ОКНО СПИСКА ИГРОКОВ
local StalkFrame = Instance.new("Frame", ScreenGui)
StalkFrame.Size = UDim2.new(0, 220, 0, 260)
StalkFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
StalkFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
StalkFrame.Visible = false
StalkFrame.ZIndex = 60
Instance.new("UICorner", StalkFrame)

MakeDraggable(StalkFrame, StalkFrame)

local StalkClose = Instance.new("TextButton", StalkFrame)
StalkClose.Size = UDim2.new(0, 22, 0, 22)
StalkClose.Position = UDim2.new(1, -27, 0, 5)
StalkClose.BackgroundColor3 = Color3.fromRGB(200,0,0)
StalkClose.Text = "X"
StalkClose.TextColor3 = Color3.new(1,1,1)
StalkClose.ZIndex = 61
Instance.new("UICorner", StalkClose)

StalkClose.MouseButton1Click:Connect(function()
    StalkFrame.Visible = false
end)

local StalkScroll = Instance.new("ScrollingFrame", StalkFrame)
StalkScroll.Size = UDim2.new(1, -10, 1, -40)
StalkScroll.Position = UDim2.new(0, 5, 0, 35)
StalkScroll.BackgroundTransparency = 1
StalkScroll.ScrollBarThickness = 0
StalkScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
StalkScroll.ZIndex = 61

Instance.new("UIListLayout", StalkScroll).Padding = UDim.new(0,5)

-- КНОПКА ОТКРЫТИЯ STALK MENU
CreateBtn(FunnyPage, "Stalk Mode", function()

    StalkFrame.Visible = not StalkFrame.Visible

    if StalkFrame.Visible then

        for _, v in pairs(StalkScroll:GetChildren()) do
            if v:IsA("Frame") then
                v:Destroy()
            end
        end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Player then

                local pf = Instance.new("Frame", StalkScroll)
                pf.Size = UDim2.new(1,0,0,35)
                pf.BackgroundTransparency = 1

                local name = Instance.new("TextLabel", pf)
                name.Size = UDim2.new(0.55,0,1,0)
                name.BackgroundTransparency = 1
                name.Text = p.DisplayName
                name.TextColor3 = Color3.new(1,1,1)
                name.Font = Enum.Font.GothamBold
                name.TextXAlignment = Enum.TextXAlignment.Left

                local stalkBtn = Instance.new("TextButton", pf)
                stalkBtn.Size = UDim2.new(0.4,0,0.8,0)
                stalkBtn.Position = UDim2.new(0.58,0,0.1,0)
                stalkBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
                stalkBtn.Text = "STALK"
                stalkBtn.TextColor3 = Color3.new(1,1,1)
                stalkBtn.Font = Enum.Font.GothamBold
                Instance.new("UICorner", stalkBtn)

                stalkBtn.MouseButton1Click:Connect(function()

                    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
                        Notify("Player unavailable")
                        return
                    end

                    local myChar = Player.Character
                    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then
                        return
                    end

                    stalking = true
                    stalkTarget = p

                    -- TP К ИГРОКУ
                    myChar.HumanoidRootPart.CFrame =
                        p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

                    -- УДАЛЯЕМ СТАРОЕ СОЕДИНЕНИЕ
                    if stalkConnection then
                        stalkConnection:Disconnect()
                    end

                    -- ПОСТОЯННОЕ СЛЕДОВАНИЕ
                    stalkConnection = RunService.RenderStepped:Connect(function()

                        if stalking and stalkTarget then

                            local targetChar = stalkTarget.Character
                            local myCharacter = Player.Character

                            if targetChar
                            and myCharacter
                            and targetChar:FindFirstChild("HumanoidRootPart")
                            and myCharacter:FindFirstChild("HumanoidRootPart") then

                                myCharacter.HumanoidRootPart.CFrame =
                                    targetChar.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

                                -- АВТО НАБЛЮДЕНИЕ
                                if targetChar:FindFirstChild("Humanoid") then
                                    Camera.CameraSubject = targetChar.Humanoid
                                end
                            end
                        end
                    end)

                    Notify("Stalking: " .. p.Name)
                end)
            end
        end
    end
end)

-- ОСТАНОВКА STALK MODE
CreateBtn(FunnyPage, "Stop Stalk", function()

    stalking = false
    stalkTarget = nil

    if stalkConnection then
        stalkConnection:Disconnect()
        stalkConnection = nil
    end

    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = Player.Character.Humanoid
    end

    Notify("Stalk OFF")
end)

-- ЕСЛИ ИГРОК ВЫШЕЛ
Players.PlayerRemoving:Connect(function(p)

    if stalkTarget == p then

        stalking = false
        stalkTarget = nil

        if stalkConnection then
            stalkConnection:Disconnect()
            stalkConnection = nil
        end

        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = Player.Character.Humanoid
        end

        Notify("Target left game")
    end
end)

-- ЗАПУСК
task.wait(3.5)
TweenService:Create(Loading, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(LText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
task.wait(0.5)
Loading:Destroy()
MainFrame.Visible = true
Notify("Welcome, " .. Player.Name .. "!")

-- ================================================================
-- VizHub Custom UI - Blackhawk Rescue Mission 5
-- Секции в боковой панели (как вкладки)
-- ================================================================

-- ==================== НАСТРОЙКИ ====================
local CONFIG = {
    WindowTitle  = "VizHub - Internal | BRM5",
    WindowWidth  = 700,
    WindowHeight = 900,
    ToggleKey    = Enum.KeyCode.RightShift,
    AccentColor  = Color3.fromRGB(88, 101, 242),
    BgColor      = Color3.fromRGB(20, 20, 25),
    PanelColor   = Color3.fromRGB(28, 28, 34),
    TextColor    = Color3.fromRGB(240, 240, 240),
    SubTextColor = Color3.fromRGB(150, 150, 160),
}

-- ==================== СЕРВИСЫ ====================
local Lighting         = game:GetService("Lighting")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local LocalPlayer      = Players.LocalPlayer

-- ==================== КОРНЕВОЙ GUI ====================
local parentGui = (gethui and gethui()) or game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VizHub_CustomUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
pcall(function() ScreenGui.Parent = parentGui end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end
-- ================================================================
--                    ВСТУПЛЕНИЕ (INTRO)
-- ================================================================
local Intro = {}

local introScreen = Instance.new("Frame")
introScreen.Name = "IntroScreen"
introScreen.Size = UDim2.new(1, 0, 1, 0)
introScreen.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
introScreen.BorderSizePixel = 0
introScreen.ZIndex = 1000
introScreen.Parent = ScreenGui

-- Затемняющий градиент (атмосфера)
local introGradient = Instance.new("UIGradient")
introGradient.Rotation = 90
introGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 8)),
}
introGradient.Parent = introScreen

-- Центральный контейнер
local introContainer = Instance.new("Frame")
introContainer.Size = UDim2.new(0, 420, 0, 220)
introContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
introContainer.AnchorPoint = Vector2.new(0.5, 0.5)
introContainer.BackgroundTransparency = 1
introContainer.ZIndex = 1001
introContainer.Parent = introScreen

-- Логотип (VizHub)
local introLogo = Instance.new("TextLabel")
introLogo.Size = UDim2.new(1, 0, 0, 90)
introLogo.Position = UDim2.new(0, 0, 0, 0)
introLogo.BackgroundTransparency = 1
introLogo.Text = "VizHub"
introLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
introLogo.Font = Enum.Font.GothamBlack
introLogo.TextSize = 68
introLogo.ZIndex = 1002
introLogo.Parent = introContainer

local introLogoStroke = Instance.new("UIStroke")
introLogoStroke.Color = CONFIG.AccentColor
introLogoStroke.Thickness = 2
introLogoStroke.Transparency = 0.4
introLogoStroke.Parent = introLogo

-- Подзаголовок
local introSub = Instance.new("TextLabel")
introSub.Size = UDim2.new(1, 0, 0, 24)
introSub.Position = UDim2.new(0, 0, 0, 90)
introSub.BackgroundTransparency = 1
introSub.Text = "Blackhawk Rescue Mission 5"
introSub.TextColor3 = CONFIG.SubTextColor
introSub.Font = Enum.Font.GothamMedium
introSub.TextSize = 14
introSub.ZIndex = 1002
introSub.Parent = introContainer

-- Разделитель
local introLine = Instance.new("Frame")
introLine.Size = UDim2.new(0, 0, 0, 1)
introLine.Position = UDim2.new(0.5, 0, 0, 125)
introLine.AnchorPoint = Vector2.new(0.5, 0)
introLine.BackgroundColor3 = CONFIG.AccentColor
introLine.BorderSizePixel = 0
introLine.ZIndex = 1002
introLine.Parent = introContainer

-- Статус-текст
local introStatus = Instance.new("TextLabel")
introStatus.Size = UDim2.new(1, 0, 0, 18)
introStatus.Position = UDim2.new(0, 0, 0, 140)
introStatus.BackgroundTransparency = 1
introStatus.Text = "Initializing modules..."
introStatus.TextColor3 = CONFIG.SubTextColor
introStatus.Font = Enum.Font.Code
introStatus.TextSize = 12
introStatus.ZIndex = 1002
introStatus.Parent = introContainer

-- Прогресс-бар
local introBarBg = Instance.new("Frame")
introBarBg.Size = UDim2.new(0, 320, 0, 6)
introBarBg.Position = UDim2.new(0.5, 0, 0, 175)
introBarBg.AnchorPoint = Vector2.new(0.5, 0)
introBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
introBarBg.BorderSizePixel = 0
introBarBg.ZIndex = 1002
introBarBg.Parent = introContainer

local introBarBgCorner = Instance.new("UICorner")
introBarBgCorner.CornerRadius = UDim.new(1, 0)
introBarBgCorner.Parent = introBarBg

local introBarFill = Instance.new("Frame")
introBarFill.Size = UDim2.new(0, 0, 1, 0)
introBarFill.BackgroundColor3 = CONFIG.AccentColor
introBarFill.BorderSizePixel = 0
introBarFill.ZIndex = 1003
introBarFill.Parent = introBarBg

local introBarFillCorner = Instance.new("UICorner")
introBarFillCorner.CornerRadius = UDim.new(1, 0)
introBarFillCorner.Parent = introBarFill

-- Процент загрузки
local introPercent = Instance.new("TextLabel")
introPercent.Size = UDim2.new(1, 0, 0, 16)
introPercent.Position = UDim2.new(0, 0, 0, 190)
introPercent.BackgroundTransparency = 1
introPercent.Text = "0%"
introPercent.TextColor3 = CONFIG.AccentColor
introPercent.Font = Enum.Font.GothamBold
introPercent.TextSize = 11
introPercent.ZIndex = 1002
introPercent.Parent = introContainer

-- Пульсация логотипа
task.spawn(function()
    while introScreen and introScreen.Parent do
        TweenService:Create(introLogoStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.1,
        }):Play()
        task.wait(1.2)
        if not introScreen or not introScreen.Parent then break end
        TweenService:Create(introLogoStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.7,
        }):Play()
        task.wait(1.2)
    end
end)

-- Анимация появления
introContainer.Position = UDim2.new(0.5, 0, 0.5, 20)
introLogo.TextTransparency = 1
introSub.TextTransparency = 1

TweenService:Create(introContainer, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0),
}):Play()

TweenService:Create(introLogo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 0,
}):Play()

task.wait(0.3)
TweenService:Create(introSub, TweenInfo.new(0.6), { TextTransparency = 0 }):Play()

-- Раскрытие разделительной линии
TweenService:Create(introLine, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 0, 1),
}):Play()

-- Массив этапов загрузки
local introStages = {
    {pct = 20, text = "Loading modules..."},
    {pct = 45, text = "Scanning workspace..."},
    {pct = 65, text = "Initializing bot registry..."},
    {pct = 85, text = "Preparing UI..."},
    {pct = 100, text = "Ready"},
}

-- Проигрываем этапы
for _, stage in ipairs(introStages) do
    TweenService:Create(introBarFill, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(stage.pct / 100, 0, 1, 0),
    }):Play()

    TweenService:Create(introPercent, TweenInfo.new(0.2), {
        TextTransparency = 1,
    }):Play()
    task.wait(0.15)
    introStatus.Text = stage.text
    introPercent.Text = stage.pct .. "%"
    TweenService:Create(introPercent, TweenInfo.new(0.2), {
        TextTransparency = 0,
    }):Play()
    task.wait(0.4)
end

-- Небольшая пауза, чтобы юзер увидел 100%
task.wait(0.6)

-- Fade out интро
TweenService:Create(introScreen, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 1,
}):Play()
TweenService:Create(introContainer, TweenInfo.new(0.5), {
    Position = UDim2.new(0.5, 0, 0.5, -30),
}):Play()
TweenService:Create(introLogo, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
TweenService:Create(introSub, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
TweenService:Create(introLine, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
TweenService:Create(introStatus, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
TweenService:Create(introBarBg, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
TweenService:Create(introBarFill, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
TweenService:Create(introPercent, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()

task.wait(0.7)
introScreen:Destroy()
-- ==================== ГЛАВНОЕ ОКНО ====================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, CONFIG.WindowWidth, 0, CONFIG.WindowHeight)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = CONFIG.BgColor
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CONFIG.AccentColor
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3
MainStroke.Parent = Main

-- ==================== TOP BAR ====================
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = CONFIG.PanelColor
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 10)
TopBarFix.Position = UDim2.new(0, 0, 1, -10)
TopBarFix.BackgroundColor3 = CONFIG.PanelColor
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = CONFIG.WindowTitle
Title.TextColor3 = CONFIG.TextColor
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = CONFIG.TextColor
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar
local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 6); c1.Parent = CloseBtn
CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60) end)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0, 6)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinBtn.Text = "–"
MinBtn.TextColor3 = CONFIG.TextColor
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.AutoButtonColor = false
MinBtn.Parent = TopBar
local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 6); c2.Parent = MinBtn
MinBtn.MouseEnter:Connect(function() MinBtn.BackgroundColor3 = CONFIG.AccentColor end)
MinBtn.MouseLeave:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60) end)
MinBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- ==================== БОКОВАЯ ПАНЕЛЬ (СЕКЦИИ) ====================
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 170, 1, -55)
SideBar.Position = UDim2.new(0, 10, 0, 45)
SideBar.BackgroundColor3 = CONFIG.PanelColor
SideBar.BorderSizePixel = 0
SideBar.Parent = Main

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 8)
SideBarCorner.Parent = SideBar

local SideBarScroll = Instance.new("ScrollingFrame")
SideBarScroll.Size = UDim2.new(1, 0, 1, 0)
SideBarScroll.BackgroundTransparency = 1
SideBarScroll.BorderSizePixel = 0
SideBarScroll.ScrollBarThickness = 3
SideBarScroll.ScrollBarImageColor3 = CONFIG.AccentColor
SideBarScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SideBarScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SideBarScroll.Parent = SideBar

local SideBarLayout = Instance.new("UIListLayout")
SideBarLayout.Padding = UDim.new(0, 4)
SideBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideBarLayout.Parent = SideBarScroll

local SideBarPadding = Instance.new("UIPadding")
SideBarPadding.PaddingTop = UDim.new(0, 8)
SideBarPadding.PaddingLeft = UDim.new(0, 6)
SideBarPadding.PaddingRight = UDim.new(0, 6)
SideBarPadding.PaddingBottom = UDim.new(0, 8)
SideBarPadding.Parent = SideBarScroll

-- ==================== КОНТЕНТ ====================
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -200, 1, -55)
Content.Position = UDim2.new(0, 190, 0, 45)
Content.BackgroundColor3 = CONFIG.PanelColor
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = CONFIG.AccentColor
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = Content

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = Content

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 12)
ContentPadding.PaddingBottom = UDim.new(0, 12)
ContentPadding.PaddingLeft = UDim.new(0, 12)
ContentPadding.PaddingRight = UDim.new(0, 12)
ContentPadding.Parent = Content

-- ==================== API ====================
local Menu = {}
Menu.Sections = {}
Menu.CurrentSection = nil

-- Создать секцию = кнопка слева + пустой контейнер справа
function Menu:CreateSection(name)
    local section = { Name = name }

    -- Кнопка слева
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    btn.Text = name
    btn.TextColor3 = CONFIG.SubTextColor
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = SideBarScroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    -- Контейнер справа
    local frame = Instance.new("Frame")
    frame.Name = "Section_" .. name
    frame.Size = UDim2.new(1, 0, 0, 0)
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame

    section.Button = btn
    section.Frame = frame
    section.Layout = layout

    btn.MouseButton1Click:Connect(function()
        Menu:SelectSection(section)
    end)

    table.insert(Menu.Sections, section)
    return section
end

function Menu:SelectSection(section)
    for _, s in ipairs(Menu.Sections) do
        if s == section then
            s.Button.BackgroundColor3 = CONFIG.AccentColor
            s.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            s.Frame.Visible = true
        else
            s.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
            s.Button.TextColor3 = CONFIG.SubTextColor
            s.Frame.Visible = false
        end
    end
    Menu.CurrentSection = section
end

-- ==================== ЭЛЕМЕНТЫ ====================
function Menu:Toggle(section, name, default, callback)
    local state = default or false

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 36)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = #section.Frame:GetChildren()
    holder.Parent = section.Frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = holder

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = CONFIG.TextColor
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local swBg = Instance.new("Frame")
    swBg.Size = UDim2.new(0, 44, 0, 22)
    swBg.Position = UDim2.new(1, -56, 0.5, -11)
    swBg.BackgroundColor3 = state and CONFIG.AccentColor or Color3.fromRGB(60, 60, 70)
    swBg.BorderSizePixel = 0
    swBg.Parent = holder

    local swCorner = Instance.new("UICorner")
    swCorner.CornerRadius = UDim.new(1, 0)
    swCorner.Parent = swBg

    local swKnob = Instance.new("Frame")
    swKnob.Size = UDim2.new(0, 18, 0, 18)
    swKnob.Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    swKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    swKnob.BorderSizePixel = 0
    swKnob.Parent = swBg

    local swKnobCorner = Instance.new("UICorner")
    swKnobCorner.CornerRadius = UDim.new(1, 0)
    swKnobCorner.Parent = swKnob

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = holder

    local function setVisual(v)
        state = v
        TweenService:Create(swBg, TweenInfo.new(0.15), {
            BackgroundColor3 = v and CONFIG.AccentColor or Color3.fromRGB(60, 60, 70)
        }):Play()
        TweenService:Create(swKnob, TweenInfo.new(0.15), {
            Position = v and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
    end

    clickBtn.MouseButton1Click:Connect(function()
        setVisual(not state)
        if callback then pcall(callback, state) end
    end)

    return {
        Set = function(_, v)
            if state ~= v then
                setVisual(v)
                if callback then pcall(callback, state) end
            end
        end,
        Get = function() return state end,
    }
end

function Menu:Slider(section, name, min, max, default, callback)
    local value = default or min

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 50)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = #section.Frame:GetChildren()
    holder.Parent = section.Frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = holder

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 0, 20)
    lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = CONFIG.TextColor
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 70, 0, 20)
    valLbl.Position = UDim2.new(1, -80, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = string.format("%.2f", value)
    valLbl.TextColor3 = CONFIG.AccentColor
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 13
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = holder

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -24, 0, 8)
    barBg.Position = UDim2.new(0, 12, 0, 32)
    barBg.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    barBg.BorderSizePixel = 0
    barBg.Parent = holder

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = barBg

    local initPct = (value - min) / (max - min)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(initPct, 0, 1, 0)
    barFill.BackgroundColor3 = CONFIG.AccentColor
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg

    local barFillCorner = Instance.new("UICorner")
    barFillCorner.CornerRadius = UDim.new(1, 0)
    barFillCorner.Parent = barFill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(initPct, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 2
    knob.Parent = barBg

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local dragging = false

    local function updateFromX(x)
        local rel = math.clamp((x - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * rel
        barFill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -7, 0.5, -7)
        valLbl.Text = string.format("%.2f", value)
        if callback then pcall(callback, value) end
    end

    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromX(input.Position.X)
        end
    end)
    barBg.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                         or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Menu:ColorPicker(section, name, default, callback)
    local color = default or Color3.fromRGB(255, 0, 0)

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 36)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = #section.Frame:GetChildren()
    holder.Parent = section.Frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = holder

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = CONFIG.TextColor
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0, 44, 0, 22)
    preview.Position = UDim2.new(1, -56, 0.5, -11)
    preview.BackgroundColor3 = color
    preview.BorderSizePixel = 0
    preview.Parent = holder

    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(0, 4)
    pCorner.Parent = preview

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = holder

    local r = math.floor(color.R * 255)
    local g = math.floor(color.G * 255)
    local b = math.floor(color.B * 255)

    local popup = Instance.new("Frame")
    popup.Size = UDim2.new(0, 220, 0, 170)
    popup.Position = UDim2.new(0.5, 0, 0.5, 0)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    popup.BorderSizePixel = 0
    popup.Visible = false
    popup.ZIndex = 100
    popup.Parent = ScreenGui

    local popCorner = Instance.new("UICorner")
    popCorner.CornerRadius = UDim.new(0, 8)
    popCorner.Parent = popup

    local popStroke = Instance.new("UIStroke")
    popStroke.Color = CONFIG.AccentColor
    popStroke.Parent = popup

    local popTitle = Instance.new("TextLabel")
    popTitle.Size = UDim2.new(1, -20, 0, 24)
    popTitle.Position = UDim2.new(0, 10, 0, 6)
    popTitle.BackgroundTransparency = 1
    popTitle.Text = name
    popTitle.TextColor3 = CONFIG.TextColor
    popTitle.Font = Enum.Font.GothamBold
    popTitle.TextSize = 13
    popTitle.TextXAlignment = Enum.TextXAlignment.Left
    popTitle.ZIndex = 101
    popTitle.Parent = popup

    local closePop = Instance.new("TextButton")
    closePop.Size = UDim2.new(0, 20, 0, 20)
    closePop.Position = UDim2.new(1, -26, 0, 6)
    closePop.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closePop.Text = "×"
    closePop.TextColor3 = Color3.fromRGB(255, 255, 255)
    closePop.TextSize = 14
    closePop.Font = Enum.Font.GothamBold
    closePop.BorderSizePixel = 0
    closePop.ZIndex = 101
    closePop.Parent = popup

    local function makeSlider(y, label, init, setter)
        local sLbl = Instance.new("TextLabel")
        sLbl.Size = UDim2.new(0, 20, 0, 20)
        sLbl.Position = UDim2.new(0, 10, 0, y)
        sLbl.BackgroundTransparency = 1
        sLbl.Text = label
        sLbl.TextColor3 = CONFIG.TextColor
        sLbl.Font = Enum.Font.GothamBold
        sLbl.TextSize = 12
        sLbl.ZIndex = 101
        sLbl.Parent = popup

        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, -40, 0, 8)
        bg.Position = UDim2.new(0, 30, 0, y + 6)
        bg.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        bg.BorderSizePixel = 0
        bg.ZIndex = 101
        bg.Parent = popup

        local bgC = Instance.new("UICorner")
        bgC.CornerRadius = UDim.new(1, 0)
        bgC.Parent = bg

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(init / 255, 0, 1, 0)
        fill.BackgroundColor3 = CONFIG.AccentColor
        fill.BorderSizePixel = 0
        fill.ZIndex = 102
        fill.Parent = bg

        local fC = Instance.new("UICorner")
        fC.CornerRadius = UDim.new(1, 0)
        fC.Parent = fill

        local drag = false
        local function update(x)
            local rel = math.clamp((x - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            setter(math.floor(rel * 255))
            preview.BackgroundColor3 = Color3.fromRGB(r, g, b)
            if callback then pcall(callback, preview.BackgroundColor3) end
        end

        bg.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                drag = true
                update(i.Position.X)
            end
        end)
        bg.InputChanged:Connect(function(i)
            if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
                update(i.Position.X)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
        end)
    end

    makeSlider(40, "R", r, function(v) r = v end)
    makeSlider(75, "G", g, function(v) g = v end)
    makeSlider(110, "B", b, function(v) b = v end)

    closePop.MouseButton1Click:Connect(function() popup.Visible = false end)
    clickBtn.MouseButton1Click:Connect(function() popup.Visible = not popup.Visible end)
end

function Menu:Dropdown(section, name, options, default, callback)
    local selected = default or options[1]

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 36)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = #section.Frame:GetChildren()
    holder.Parent = section.Frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = holder

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -140, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = CONFIG.TextColor
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0, 120, 0, 24)
    dropBtn.Position = UDim2.new(1, -128, 0.5, -12)
    dropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    dropBtn.Text = selected .. " ▾"
    dropBtn.TextColor3 = CONFIG.TextColor
    dropBtn.Font = Enum.Font.Gotham
    dropBtn.TextSize = 12
    dropBtn.BorderSizePixel = 0
    dropBtn.AutoButtonColor = false
    dropBtn.Parent = holder

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 4)
    dCorner.Parent = dropBtn

    -- ⚠️ Список теперь висит НА SCREENGUI, а не на holder
    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(0, 120, 0, #options * 24 + 4)
    listFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    listFrame.BorderSizePixel = 0
    listFrame.Visible = false
    listFrame.ZIndex = 500
    listFrame.Parent = ScreenGui   -- ← ГЛАВНОЕ: родитель = ScreenGui

    local lCorner = Instance.new("UICorner")
    lCorner.CornerRadius = UDim.new(0, 4)
    lCorner.Parent = listFrame

    local lStroke = Instance.new("UIStroke")
    lStroke.Color = CONFIG.AccentColor
    lStroke.Thickness = 1
    lStroke.Transparency = 0.4
    lStroke.Parent = listFrame

    local lLayout = Instance.new("UIListLayout")
    lLayout.Padding = UDim.new(0, 2)
    lLayout.Parent = listFrame

    local lPad = Instance.new("UIPadding")
    lPad.PaddingTop = UDim.new(0, 2)
    lPad.PaddingLeft = UDim.new(0, 2)
    lPad.PaddingRight = UDim.new(0, 2)
    lPad.Parent = listFrame

    -- Функция позиционирования списка под кнопкой
    local function updateListPosition()
        local btnPos = dropBtn.AbsolutePosition
        local btnSize = dropBtn.AbsoluteSize
        listFrame.Position = UDim2.new(0, btnPos.X, 0, btnPos.Y + btnSize.Y + 2)
    end

    for _, opt in ipairs(options) do
        local oBtn = Instance.new("TextButton")
        oBtn.Size = UDim2.new(1, 0, 0, 22)
        oBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
        oBtn.Text = opt
        oBtn.TextColor3 = CONFIG.TextColor
        oBtn.Font = Enum.Font.Gotham
        oBtn.TextSize = 12
        oBtn.BorderSizePixel = 0
        oBtn.AutoButtonColor = false
        oBtn.ZIndex = 501
        oBtn.Parent = listFrame

        local oc = Instance.new("UICorner")
        oc.CornerRadius = UDim.new(0, 3)
        oc.Parent = oBtn

        oBtn.MouseEnter:Connect(function()
            oBtn.BackgroundColor3 = CONFIG.AccentColor
        end)
        oBtn.MouseLeave:Connect(function()
            oBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
        end)

        oBtn.MouseButton1Click:Connect(function()
            selected = opt
            dropBtn.Text = opt .. " ▾"
            listFrame.Visible = false
            if callback then pcall(callback, opt) end
        end)
    end

    dropBtn.MouseButton1Click:Connect(function()
        if not listFrame.Visible then
            updateListPosition()
            listFrame.Visible = true
        else
            listFrame.Visible = false
        end
    end)

    -- Скрывать список при клике вне него
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if listFrame.Visible then
                local mouse = UserInputService:GetMouseLocation()
                local lp = listFrame.AbsolutePosition
                local ls = listFrame.AbsoluteSize
                local insideList = mouse.X >= lp.X and mouse.X <= lp.X + ls.X
                               and mouse.Y >= lp.Y and mouse.Y <= lp.Y + ls.Y
                local bp = dropBtn.AbsolutePosition
                local bs = dropBtn.AbsoluteSize
                local insideBtn = mouse.X >= bp.X and mouse.X <= bp.X + bs.X
                              and mouse.Y >= bp.Y and mouse.Y <= bp.Y + bs.Y
                if not insideList and not insideBtn then
                    listFrame.Visible = false
                end
            end
        end
    end)

    -- Скрывать список при скролле
    Content.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel
           or input.UserInputType == Enum.UserInputType.Touch then
            if listFrame.Visible then
                updateListPosition()
            end
        end
    end)
end

function Menu:Button(section, name, callback)
    local holder = Instance.new("TextButton")
    holder.Size = UDim2.new(1, 0, 0, 34)
    holder.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    holder.Text = name
    holder.TextColor3 = CONFIG.TextColor
    holder.Font = Enum.Font.Gotham
    holder.TextSize = 13
    holder.BorderSizePixel = 0
    holder.AutoButtonColor = false
    holder.LayoutOrder = #section.Frame:GetChildren()
    holder.Parent = section.Frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = holder

    holder.MouseEnter:Connect(function()
        TweenService:Create(holder, TweenInfo.new(0.15), {
            BackgroundColor3 = CONFIG.AccentColor
        }):Play()
    end)
    holder.MouseLeave:Connect(function()
        TweenService:Create(holder, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        }):Play()
    end)
    holder.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)
end

function Menu:Label(section, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = CONFIG.SubTextColor
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = #section.Frame:GetChildren()
    lbl.Parent = section.Frame
end

-- ==================== ХОТКЕЙ ====================
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == CONFIG.ToggleKey then
        Main.Visible = not Main.Visible
    end
end)

-- ================================================================
--                        ФУНКЦИОНАЛ
-- ================================================================

-- ==================== BOT REGISTRY ====================
local function isBotModel(model)
    if not model or not model:IsA("Model") then return false end
    if model.Name ~= "Male" then return false end
    if Players:GetPlayerFromCharacter(model) then return false end
    if Players.LocalPlayer.Character == model then return false end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    for _, d in ipairs(model:GetDescendants()) do
        if typeof(d) == "Instance" and d.Name:sub(1, 3) == "AI_" then
            return true
        end
    end
    return false
end

local BotRegistry = {
    Bots = {}, Lookup = {}, Started = false,
    OnRegister = {}, OnUnregister = {},
}

local function registerBot(model)
    if BotRegistry.Lookup[model] then return end
    BotRegistry.Lookup[model] = true
    table.insert(BotRegistry.Bots, model)
    local conn
    conn = model.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if conn then conn:Disconnect() end
            if BotRegistry.Lookup[model] then
                BotRegistry.Lookup[model] = nil
                for i = #BotRegistry.Bots, 1, -1 do
                    if BotRegistry.Bots[i] == model then
                        table.remove(BotRegistry.Bots, i); break
                    end
                end
                for _, cb in ipairs(BotRegistry.OnUnregister) do pcall(cb, model) end
            end
        end
    end)
    for _, cb in ipairs(BotRegistry.OnRegister) do pcall(cb, model) end
end

local function fullScanBots()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Male" then
            if not BotRegistry.Lookup[obj] and isBotModel(obj) then
                registerBot(obj)
            end
        end
    end
end

local function startBotRegistry()
    if BotRegistry.Started then return end
    BotRegistry.Started = true
    task.spawn(fullScanBots)
    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("Model") and obj.Name == "Male" then
            task.defer(function()
                if obj.Parent and not BotRegistry.Lookup[obj] and isBotModel(obj) then
                    registerBot(obj)
                end
            end)
        end
    end)
end

startBotRegistry()

local HealthESP = {
    Enabled = false,
    ColorLow = Color3.fromRGB(255, 60, 60),    -- < 30%
    ColorMid = Color3.fromRGB(255, 200, 60),   -- 30-70%
    ColorHigh = Color3.fromRGB(80, 220, 100),  -- > 70%
    ShowHealth = true,
    ShowName = true,
    ShowDistance = false,
    MaxDistance = 500,
    Scale = 1,
    OffsetY = 3,
    Drawings = {},   -- [model] = {name = Drawing, hp = Drawing, dist = Drawing}
}

local function getHealthColor(hp, maxHp)
    local pct = hp / math.max(maxHp, 1)
    if pct <= 0.3 then
        return HealthESP.ColorLow
    elseif pct <= 0.7 then
        return HealthESP.ColorMid
    else
        return HealthESP.ColorHigh
    end
end

local function createHealthDrawings(model)
    local set = {}
    set.name = Drawing.new("Text")
    set.name.Size = 14
    set.name.Center = true
    set.name.Outline = true
    set.name.Font = 2 -- Gotham
    set.name.Visible = false

    set.hp = Drawing.new("Text")
    set.hp.Size = 13
    set.hp.Center = true
    set.hp.Outline = true
    set.hp.Font = 2
    set.hp.Visible = false

    set.dist = Drawing.new("Text")
    set.dist.Size = 12
    set.dist.Center = true
    set.dist.Outline = true
    set.dist.Font = 2
    set.dist.Visible = false

    HealthESP.Drawings[model] = set
    return set
end

local function removeHealthDrawings(model)
    local set = HealthESP.Drawings[model]
    if set then
        for _, d in pairs(set) do
            pcall(function() d:Remove() end)
        end
        HealthESP.Drawings[model] = nil
    end
end

-- Чистим drawings при удалении бота
table.insert(BotRegistry.OnUnregister, function(model)
    removeHealthDrawings(model)
end)

local healthESPRender = RunService.RenderStepped:Connect(function()
    if not HealthESP.Enabled then
        -- Скрываем всё, если выключено
        for _, set in pairs(HealthESP.Drawings) do
            set.name.Visible = false
            set.hp.Visible = false
            set.dist.Visible = false
        end
        return
    end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for i = #BotRegistry.Bots, 1, -1 do
        local model = BotRegistry.Bots[i]
        if not model or not model.Parent then
            removeHealthDrawings(model)
            table.remove(BotRegistry.Bots, i)
            if model then BotRegistry.Lookup[model] = nil end
        else
            local head = model:FindFirstChild("Head")
            local hum = model:FindFirstChildOfClass("Humanoid")

            if not head or not hum then
                removeHealthDrawings(model)
            else
                local set = HealthESP.Drawings[model] or createHealthDrawings(model)

                if hum.Health <= 0 then
                    set.name.Visible = false
                    set.hp.Visible = false
                    set.dist.Visible = false
                else
                    local sp, onScreen = camera:WorldToViewportPoint(
                        head.Position + Vector3.new(0, HealthESP.OffsetY, 0)
                    )

                    local dist = 0
                    if myRoot then
                        dist = (head.Position - myRoot.Position).Magnitude
                    end

                    if onScreen and sp.Z > 0 and dist <= HealthESP.MaxDistance then
                        local baseY = sp.Y - 40 * HealthESP.Scale

                        -- Имя
                        if HealthESP.ShowName then
                            set.name.Text = "Bot"
                            set.name.Position = Vector2.new(sp.X, baseY)
                            set.name.Color = Color3.fromRGB(255, 255, 255)
                            set.name.Visible = true
                            baseY = baseY + 16 * HealthESP.Scale
                        else
                            set.name.Visible = false
                        end

                        -- HP
                        if HealthESP.ShowHealth then
                            set.hp.Text = string.format("%d / %d", math.floor(hum.Health), math.floor(hum.MaxHealth))
                            set.hp.Position = Vector2.new(sp.X, baseY)
                            set.hp.Color = getHealthColor(hum.Health, hum.MaxHealth)
                            set.hp.Visible = true
                            baseY = baseY + 15 * HealthESP.Scale
                        else
                            set.hp.Visible = false
                        end

                        -- Дистанция
                        if HealthESP.ShowDistance then
                            set.dist.Text = string.format("[%d m]", math.floor(dist))
                            set.dist.Position = Vector2.new(sp.X, baseY)
                            set.dist.Color = Color3.fromRGB(200, 200, 200)
                            set.dist.Visible = true
                        else
                            set.dist.Visible = false
                        end
                    else
                        set.name.Visible = false
                        set.hp.Visible = false
                        set.dist.Visible = false
                    end
                end
            end
        end
    end
end)
-- ==================== ESP ====================
local ESP = {
    Bots = {
        Enabled = false,
        FillColor = Color3.fromRGB(255, 0, 0),
        OutlineColor = Color3.fromRGB(255, 255, 255),
        FillTransparency = 0.5,
        OutlineTransparency = 0,
        HighlightName = "VizHub_ESP_Bot"
    }
}

local function applyHighlightSettings(h)
    h.FillColor = ESP.Bots.FillColor
    h.OutlineColor = ESP.Bots.OutlineColor
    h.FillTransparency = ESP.Bots.FillTransparency
    h.OutlineTransparency = ESP.Bots.OutlineTransparency
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

local function ensureHighlight(model)
    if not model or not model.Parent then return end
    local h = model:FindFirstChild(ESP.Bots.HighlightName)
    if not h then
        h = Instance.new("Highlight")
        h.Name = ESP.Bots.HighlightName
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = model
    end
    applyHighlightSettings(h)
end

local function removeHighlight(model)
    if not model then return end
    local h = model:FindFirstChild(ESP.Bots.HighlightName)
    if h then h:Destroy() end
end

table.insert(BotRegistry.OnRegister, function(m)
    if ESP.Bots.Enabled then ensureHighlight(m) end
end)
table.insert(BotRegistry.OnUnregister, function(m)
    removeHighlight(m)
end)

local function removeAllHighlights()
    for _, model in ipairs(BotRegistry.Bots) do removeHighlight(model) end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") and obj.Name == ESP.Bots.HighlightName then
            obj:Destroy()
        end
    end
end

local function updateAllHighlights(prop, value)
    for _, model in ipairs(BotRegistry.Bots) do
        local h = model:FindFirstChild(ESP.Bots.HighlightName)
        if h then h[prop] = value end
    end
end


-- ==================== FULLBRIGHT ====================
local Fullbright = {
    Enabled = false, Original = {}, Saved = false,
    Brightness = 3, ClockTime = 12,
    Ambient = Color3.fromRGB(178, 178, 178),
    OutdoorAmbient = Color3.fromRGB(178, 178, 178),
    FogEnd = 100000, FogStart = 0,
    NoFog = true, NoColorCorrection = true, NoBloom = true,
    NoAtmosphere = true, NoSunRays = true, NoDepthOfField = true, NoBlur = true,
    EnvironmentDiffuse = 1, EnvironmentSpecular = 1,
    _bindName = "VizHub_Fullbright", _hbConn = nil,
}

local function saveLighting()
    if Fullbright.Saved then return end
    Fullbright.Saved = true
    local L = Lighting
    Fullbright.Original = { Effects = {} }
    pcall(function() Fullbright.Original.Brightness = L.Brightness end)
    pcall(function() Fullbright.Original.ClockTime = L.ClockTime end)
    pcall(function() Fullbright.Original.GeographicLatitude = L.GeographicLatitude end)
    pcall(function() Fullbright.Original.Ambient = L.Ambient end)
    pcall(function() Fullbright.Original.OutdoorAmbient = L.OutdoorAmbient end)
    pcall(function() Fullbright.Original.GlobalShadows = L.GlobalShadows end)
    pcall(function() Fullbright.Original.FogEnd = L.FogEnd end)
    pcall(function() Fullbright.Original.FogStart = L.FogStart end)
    pcall(function() Fullbright.Original.FogColor = L.FogColor end)
    pcall(function() Fullbright.Original.EnvironmentDiffuseScale = L.EnvironmentDiffuseScale end)
    pcall(function() Fullbright.Original.EnvironmentSpecularScale = L.EnvironmentSpecularScale end)
    pcall(function() Fullbright.Original.ExposureCompensation = L.ExposureCompensation end)
    for _, e in ipairs(L:GetChildren()) do
        if e:IsA("ColorCorrectionEffect")
            or e:IsA("BloomEffect")
            or e:IsA("BlurEffect")
            or e:IsA("SunRaysEffect")
            or e:IsA("DepthOfFieldEffect") then
            table.insert(Fullbright.Original.Effects, { Object = e, Enabled = e.Enabled })
        elseif e:IsA("Atmosphere") then
            table.insert(Fullbright.Original.Effects, {
                Object = e, Density = e.Density, Haze = e.Haze, Glare = e.Glare,
            })
        end
    end
end

local function applyFullbright()
    local L = Lighting
    pcall(function() L.Brightness = Fullbright.Brightness end)
    pcall(function() L.ClockTime = Fullbright.ClockTime end)
    pcall(function() L.Ambient = Fullbright.Ambient end)
    pcall(function() L.OutdoorAmbient = Fullbright.OutdoorAmbient end)
    pcall(function() L.GlobalShadows = false end)
    pcall(function() L.EnvironmentDiffuseScale = Fullbright.EnvironmentDiffuse end)
    pcall(function() L.EnvironmentSpecularScale = Fullbright.EnvironmentSpecular end)
    pcall(function() L.ExposureCompensation = 0 end)
    if Fullbright.NoFog then
        pcall(function() L.FogEnd = Fullbright.FogEnd end)
        pcall(function() L.FogStart = Fullbright.FogStart end)
        pcall(function() L.FogColor = Color3.fromRGB(200, 200, 200) end)
    end
    for _, e in ipairs(L:GetChildren()) do
        if e:IsA("Atmosphere") and Fullbright.NoAtmosphere then
            pcall(function()
                if e.Density ~= 0 then e.Density = 0 end
                if e.Haze ~= 0 then e.Haze = 0 end
                if e.Glare ~= 0 then e.Glare = 0 end
            end)
        elseif e:IsA("ColorCorrectionEffect") and Fullbright.NoColorCorrection and e.Enabled then
            pcall(function() e.Enabled = false end)
        elseif e:IsA("BloomEffect") and Fullbright.NoBloom and e.Enabled then
            pcall(function() e.Enabled = false end)
        elseif e:IsA("SunRaysEffect") and Fullbright.NoSunRays and e.Enabled then
            pcall(function() e.Enabled = false end)
        elseif e:IsA("DepthOfFieldEffect") and Fullbright.NoDepthOfField and e.Enabled then
            pcall(function() e.Enabled = false end)
        elseif e:IsA("BlurEffect") and Fullbright.NoBlur and e.Enabled then
            pcall(function() e.Enabled = false end)
        end
    end
end

local function restoreLighting()
    if not Fullbright.Saved then return end
    local L = Lighting
    local O = Fullbright.Original
    pcall(function()
        if O.Brightness ~= nil then L.Brightness = O.Brightness end
        if O.ClockTime ~= nil then L.ClockTime = O.ClockTime end
        if O.GeographicLatitude ~= nil then L.GeographicLatitude = O.GeographicLatitude end
        if O.Ambient ~= nil then L.Ambient = O.Ambient end
        if O.OutdoorAmbient ~= nil then L.OutdoorAmbient = O.OutdoorAmbient end
        if O.GlobalShadows ~= nil then L.GlobalShadows = O.GlobalShadows end
        if O.FogEnd ~= nil then L.FogEnd = O.FogEnd end
        if O.FogStart ~= nil then L.FogStart = O.FogStart end
        if O.FogColor ~= nil then L.FogColor = O.FogColor end
        if O.EnvironmentDiffuseScale ~= nil then L.EnvironmentDiffuseScale = O.EnvironmentDiffuseScale end
        if O.EnvironmentSpecularScale ~= nil then L.EnvironmentSpecularScale = O.EnvironmentSpecularScale end
        if O.ExposureCompensation ~= nil then L.ExposureCompensation = O.ExposureCompensation end
    end)
    if O.Effects then
        for _, data in ipairs(O.Effects) do
            local obj = data.Object
            if obj and obj.Parent then
                pcall(function()
                    if obj:IsA("Atmosphere") then
                        if data.Density then obj.Density = data.Density end
                        if data.Haze then obj.Haze = data.Haze end
                        if data.Glare then obj.Glare = data.Glare end
                    elseif obj:IsA("PostEffect") then
                        if data.Enabled ~= nil then obj.Enabled = data.Enabled end
                    end
                end)
            end
        end
    end
    Fullbright.Saved = false
    Fullbright.Original = {}
end

local function fullbrightRenderStep()
    if Fullbright.Enabled then pcall(applyFullbright) end
end

local function startFullbright()
    pcall(function() RunService:UnbindFromRenderStep(Fullbright._bindName) end)
    pcall(function()
        RunService:BindToRenderStep(Fullbright._bindName, 2000, fullbrightRenderStep)
    end)
    if Fullbright._hbConn then
        pcall(function() Fullbright._hbConn:Disconnect() end)
    end
    Fullbright._hbConn = RunService.Heartbeat:Connect(function()
        if Fullbright.Enabled then pcall(applyFullbright) end
    end)
end

local function stopFullbright()
    pcall(function() RunService:UnbindFromRenderStep(Fullbright._bindName) end)
    if Fullbright._hbConn then
        pcall(function() Fullbright._hbConn:Disconnect() end)
        Fullbright._hbConn = nil
    end
end

-- ==================== RECOIL ====================
local RecoilControl = {
    Enabled = false, Mode = "Fixed", Speed = 3, AdaptiveSpeed = 3, Sensitivity = 1,
    Shooting = false, LastCameraCF = nil,
    RecoilSamples = {}, SampleCount = 0,
    PlayerMovingThreshold = 1.5, RenderConn = nil,
}

MouseDown = RecoilControl

local function getYawPitch(cframe)
    local look = cframe.LookVector
    local yaw = math.atan2(-look.X, -look.Z)
    local pitch = math.asin(math.clamp(look.Y, -1, 1))
    return yaw, pitch
end

local function isShooting()
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end

local function recoilStep()
    if not RecoilControl.Enabled then return end
    local camera = workspace.CurrentCamera
    if not camera then return end
    local shooting = isShooting()
    if shooting and not RecoilControl.Shooting then
        RecoilControl.Shooting = true
        RecoilControl.LastCameraCF = camera.CFrame
        RecoilControl.RecoilSamples = {}
        RecoilControl.SampleCount = 0
        return
    end
    if not shooting then
        RecoilControl.Shooting = false
        RecoilControl.LastCameraCF = nil
        return
    end
    if not RecoilControl.LastCameraCF then
        RecoilControl.LastCameraCF = camera.CFrame
        return
    end
    if not mousemoverel then return end
    local curCF = camera.CFrame
    local curYaw, curPitch = getYawPitch(curCF)
    local lastYaw, lastPitch = getYawPitch(RecoilControl.LastCameraCF)
    local yawDelta = math.deg(curYaw - lastYaw)
    local pitchDelta = math.deg(curPitch - lastPitch)
    local isPlayerMoving = math.abs(pitchDelta) > RecoilControl.PlayerMovingThreshold
                        or math.abs(yawDelta) > RecoilControl.PlayerMovingThreshold
    if RecoilControl.Mode == "Adaptive" and not isPlayerMoving then
        if math.abs(pitchDelta) > 0.05 then
            table.insert(RecoilControl.RecoilSamples, math.abs(pitchDelta))
            RecoilControl.SampleCount = RecoilControl.SampleCount + 1
            if RecoilControl.SampleCount >= 10 then
                local sum = 0
                for _, v in ipairs(RecoilControl.RecoilSamples) do sum = sum + v end
                local avg = sum / #RecoilControl.RecoilSamples
                RecoilControl.AdaptiveSpeed = math.clamp(avg * RecoilControl.Sensitivity, 0.5, 15)
                RecoilControl.RecoilSamples = {}
                RecoilControl.SampleCount = 0
            end
        end
    end
    if isPlayerMoving then
        RecoilControl.LastCameraCF = curCF
        return
    end
    local speed = RecoilControl.Mode == "Adaptive" and RecoilControl.AdaptiveSpeed or RecoilControl.Speed
    speed = speed * RecoilControl.Sensitivity
    if speed > 0.1 then pcall(mousemoverel, 0, speed) end
    RecoilControl.LastCameraCF = curCF
end

RecoilControl.RenderConn = RunService.RenderStepped:Connect(function()
    pcall(recoilStep)
end)

local function setRecoilState(state)
    RecoilControl.Enabled = state
    if not state then
        RecoilControl.Shooting = false
        RecoilControl.LastCameraCF = nil
    end
    if RecoilControl.Toggle then
        pcall(function() RecoilControl.Toggle:Set(state) end)
    end
end

-- ==================== AIMBOT (Cursor) ====================
local AimCursor = {
    Enabled = false, FOV = 250, Speed = 1, Smoothness = 1,
    LastScan = 0, ScanInterval = 0.1, CachedTarget = nil,
    VisibleOnly = true,
    VisibleParts = {"Head", "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart"},
    ShowFOV = true, FOVColor = Color3.fromRGB(255, 255, 255),
    FOVThickness = 1, FOVTransparency = 0.7, FOVFilled = false,
    FOVObject = nil, FOVConn = nil,
}

local function createFOVCircle()
    if AimCursor.FOVObject then
        pcall(function() AimCursor.FOVObject:Remove() end)
        AimCursor.FOVObject = nil
    end
    local circle = Drawing.new("Circle")
    circle.Thickness = AimCursor.FOVThickness
    circle.Color = AimCursor.FOVColor
    circle.Transparency = AimCursor.FOVTransparency
    circle.Filled = AimCursor.FOVFilled
    circle.Radius = AimCursor.FOV
    circle.Visible = false
    circle.NumSides = 64
    AimCursor.FOVObject = circle
end

local function updateFOVCircle()
    if not AimCursor.FOVObject then return end
    local circle = AimCursor.FOVObject
    if not AimCursor.ShowFOV or not AimCursor.Enabled then
        circle.Visible = false
        return
    end
    local camera = workspace.CurrentCamera
    if not camera then circle.Visible = false; return end
    local vp = camera.ViewportSize
    circle.Position = Vector2.new(vp.X / 2, vp.Y / 2)
    circle.Radius = AimCursor.FOV
    circle.Color = AimCursor.FOVColor
    circle.Thickness = AimCursor.FOVThickness
    circle.Transparency = AimCursor.FOVTransparency
    circle.Filled = AimCursor.FOVFilled
    circle.Visible = true
end

AimCursor.FOVConn = RunService.RenderStepped:Connect(function()
    pcall(updateFOVCircle)
end)

createFOVCircle()

-- ==================== VISIBILITY CHECK ====================
local function isVisible(targetModel, targetPart)
    if not AimCursor.VisibleOnly then return true end
    if not targetModel or not targetPart then return false end
    local camera = workspace.CurrentCamera
    if not camera then return false end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.IgnoreWater = true
    local ignore = {}
    if LocalPlayer.Character then table.insert(ignore, LocalPlayer.Character) end
    table.insert(ignore, targetModel)
    rp.FilterDescendantsInstances = ignore
    local origin = camera.CFrame.Position
    local parts = {}
    for _, n in ipairs(AimCursor.VisibleParts) do
        local p = targetModel:FindFirstChild(n)
        if p and p:IsA("BasePart") then table.insert(parts, p) end
    end
    if #parts == 0 then parts = {targetPart} end
    for _, p in ipairs(parts) do
        local res = workspace:Raycast(origin, p.Position - origin, rp)
        if not res then return true end
        if res.Instance and res.Instance:IsDescendantOf(targetModel) then return true end
    end
    return false
end

-- ==================== TARGET FINDING ====================
local function findBestTarget()
    local camera = workspace.CurrentCamera
    if not camera then return nil end

    local vp = camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)
    local best, bestDist = nil, math.huge

    for i = #BotRegistry.Bots, 1, -1 do
        local model = BotRegistry.Bots[i]
        if not model or not model.Parent then
            table.remove(BotRegistry.Bots, i)
            if model then BotRegistry.Lookup[model] = nil end
        else
            local head = model:FindFirstChild("Head")
            if head and head:IsA("BasePart") then
                local sp, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen and sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d <= AimCursor.FOV and d < bestDist then
                        if isVisible(model, head) then
                            bestDist = d
                            best = { model = model, head = head }
                        end
                    end
                end
            end
        end
    end

    return best
end

-- ==================== AIMBOT LOGIC ====================
local aimCursorRender = RunService.RenderStepped:Connect(function()
    if not AimCursor.Enabled then
        AimCursor.CachedTarget = nil
        return
    end

    if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        AimCursor.CachedTarget = nil
        return
    end

    local now = os.clock()
    if now - AimCursor.LastScan >= AimCursor.ScanInterval or not AimCursor.CachedTarget then
        AimCursor.LastScan = now
        AimCursor.CachedTarget = findBestTarget()
    end

    local t = AimCursor.CachedTarget
    if not t or not t.model.Parent then
        AimCursor.CachedTarget = nil
        return
    end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local vp = camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)

    local sp, onScreen = camera:WorldToViewportPoint(t.head.Position)
    if not onScreen or sp.Z <= 0 then return end

    local delta = Vector2.new(sp.X, sp.Y) - center
    if delta.Magnitude < 2 then return end

    local gain = 0.15 * AimCursor.Speed
    if AimCursor.Smoothness > 1 then
        gain = gain / AimCursor.Smoothness
    end
    if AimCursor.Speed >= 10 then
        gain = 1
    end

    local mx = math.clamp(delta.X * gain, -math.abs(delta.X), math.abs(delta.X))
    local my = math.clamp(delta.Y * gain, -math.abs(delta.Y), math.abs(delta.Y))

    if mousemoverel then
        pcall(mousemoverel, mx, my)
    end
end)
local CameraFOV = {
    Enabled = false,
    Value = 70,
    Original = nil,
    _bindName = "VizHub_FOV",
    _running = false,
}

local function applyCameraFOV()
    if not CameraFOV.Enabled then return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    cam.FieldOfView = CameraFOV.Value
end

local function startCameraFOV()
    CameraFOV.Enabled = true

    local cam = workspace.CurrentCamera
    if cam and CameraFOV.Original == nil then
        CameraFOV.Original = cam.FieldOfView
    end

    if CameraFOV._running then return end
    CameraFOV._running = true

    -- Высокий приоритет = выполняется ПОСЛЕ игры (перебивает её сброс)
    pcall(function()
        RunService:UnbindFromRenderStep(CameraFOV._bindName)
    end)
    pcall(function()
        RunService:BindToRenderStep(CameraFOV._bindName, 2000, function()
            if CameraFOV.Enabled then
                local c = workspace.CurrentCamera
                if c then
                    c.FieldOfView = CameraFOV.Value
                end
            end
        end)
    end)
end

local function stopCameraFOV()
    CameraFOV.Enabled = false
    CameraFOV._running = false

    pcall(function()
        RunService:UnbindFromRenderStep(CameraFOV._bindName)
    end)

    local cam = workspace.CurrentCamera
    if cam and CameraFOV.Original then
        cam.FieldOfView = CameraFOV.Original
    end
end

-- Следим за сменой камеры (респавн, смена режима)
CameraFOV._cameraConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    task.wait(0.1)
    local cam = workspace.CurrentCamera
    if cam and CameraFOV.Original == nil then
        CameraFOV.Original = cam.FieldOfView
    end
end)
-- ==================== SKYBOX ====================
local Skybox = {
    Enabled = false, CurrentPreset = "Night",
    SkyboxObject = nil, OriginalSkyboxes = {},
}

local SkyboxPresetsReal = {
    ["Night"]    = "rbxassetid://159056641",
    ["Space"]    = "rbxassetid://6310302061",
    ["Nebula"]   = "rbxassetid://6309768465",
    ["Blue Sky"] = "rbxassetid://159454299",
    ["Stormy"]   = "rbxassetid://5705570340",
}

local function createSkybox(textureId)
    local old = Lighting:FindFirstChild("VizHub_Sky")
    if old then old:Destroy() end
    local sky = Instance.new("Sky")
    sky.Name = "VizHub_Sky"
    sky.SkyboxBk = textureId
    sky.SkyboxDn = textureId
    sky.SkyboxFt = textureId
    sky.SkyboxLf = textureId
    sky.SkyboxRt = textureId
    sky.SkyboxUp = textureId
    sky.SunAngularSize = 21
    sky.MoonAngularSize = 12
    sky.StarCount = 3000
    sky.Parent = Lighting
    Skybox.SkyboxObject = sky
end

local function removeSkybox()
    local sky = Lighting:FindFirstChild("VizHub_Sky")
    if sky then sky:Destroy() end
    Skybox.SkyboxObject = nil
end

local function hideOriginalSkyboxes()
    Skybox.OriginalSkyboxes = {}
    for _, s in ipairs(Lighting:GetChildren()) do
        if s:IsA("Sky") and s.Name ~= "VizHub_Sky" then
            Skybox.OriginalSkyboxes[s] = s.Parent
            s.Parent = nil
        end
    end
end

local function restoreOriginalSkyboxes()
    for sky, originalParent in pairs(Skybox.OriginalSkyboxes) do
        if sky then sky.Parent = originalParent or Lighting end
    end
    Skybox.OriginalSkyboxes = {}
end

local function applySkyboxPreset(name)
    local id = SkyboxPresetsReal[name]
    if not id then return end
    hideOriginalSkyboxes()
    createSkybox(id)
    Skybox.Enabled = true
    Skybox.CurrentPreset = name
end

local function clearSkybox()
    removeSkybox()
    restoreOriginalSkyboxes()
    Skybox.Enabled = false
end

-- ==================== BOOST FPS ====================
local BoostFPS = {
    Enabled = false, DisabledObjects = {}, OriginalSettings = {},
}

local function disableObject(obj)
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
        or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
        BoostFPS.DisabledObjects[obj] = {type = "Enabled", value = obj.Enabled}
        obj.Enabled = false
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        BoostFPS.DisabledObjects[obj] = {type = "Transparency", value = obj.Transparency}
        obj.Transparency = 1
    elseif obj:IsA("PostEffect") then
        BoostFPS.DisabledObjects[obj] = {type = "Enabled", value = obj.Enabled}
        obj.Enabled = false
    elseif obj:IsA("Atmosphere") then
        BoostFPS.DisabledObjects[obj] = {type = "Density", value = obj.Density}
        obj.Density = 0
    elseif obj:IsA("Clouds") then
        BoostFPS.DisabledObjects[obj] = {type = "Enabled", value = obj.Enabled}
        obj.Enabled = false
    elseif obj:IsA("Sky") then
        BoostFPS.DisabledObjects[obj] = {type = "StarCount", value = obj.StarCount}
        obj.StarCount = 0
    end
end

local function enableBoostFPS()
    BoostFPS.Enabled = true
    BoostFPS.DisabledObjects = {}
    BoostFPS.OriginalSettings = {}
    BoostFPS.OriginalSettings.Brightness = Lighting.Brightness
    BoostFPS.OriginalSettings.GlobalShadows = Lighting.GlobalShadows
    BoostFPS.OriginalSettings.ClockTime = Lighting.ClockTime
    BoostFPS.OriginalSettings.FogEnd = Lighting.FogEnd
    BoostFPS.OriginalSettings.FogStart = Lighting.FogStart
    BoostFPS.OriginalSettings.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
    BoostFPS.OriginalSettings.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale

    Lighting.GlobalShadows = false
    Lighting.Brightness = 2
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)

    for _, obj in ipairs(Workspace:GetDescendants()) do disableObject(obj) end
    for _, obj in ipairs(Lighting:GetDescendants()) do disableObject(obj) end

    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01 end)

    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then pcall(function() terrain.Decoration = false end) end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            if obj.Brightness > 2 then
                BoostFPS.DisabledObjects[obj] = {type = "Brightness", value = obj.Brightness}
                obj.Brightness = 0
            end
        end
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if obj.Material == Enum.Material.Glass or obj.Material == Enum.Material.ForceField then
                BoostFPS.DisabledObjects[obj] = {type = "Material", value = obj.Material}
                obj.Material = Enum.Material.SmoothPlastic
            end
            if obj.Reflectance > 0 then
                BoostFPS.DisabledObjects[obj] = {type = "Reflectance", value = obj.Reflectance}
                obj.Reflectance = 0
            end
        end
    end
end

local function disableBoostFPS()
    BoostFPS.Enabled = false
    if BoostFPS.OriginalSettings.Brightness then
        Lighting.Brightness = BoostFPS.OriginalSettings.Brightness
        Lighting.GlobalShadows = BoostFPS.OriginalSettings.GlobalShadows
        Lighting.ClockTime = BoostFPS.OriginalSettings.ClockTime
        Lighting.FogEnd = BoostFPS.OriginalSettings.FogEnd
        Lighting.FogStart = BoostFPS.OriginalSettings.FogStart
        Lighting.EnvironmentDiffuseScale = BoostFPS.OriginalSettings.EnvironmentDiffuseScale
        Lighting.EnvironmentSpecularScale = BoostFPS.OriginalSettings.EnvironmentSpecularScale
    end
    for obj, data in pairs(BoostFPS.DisabledObjects) do
        if typeof(obj) == "Instance" and obj.Parent then
            pcall(function()
                if data.type == "Enabled" then obj.Enabled = data.value
                elseif data.type == "Transparency" then obj.Transparency = data.value
                elseif data.type == "Density" then obj.Density = data.value
                elseif data.type == "StarCount" then obj.StarCount = data.value
                elseif data.type == "Brightness" then obj.Brightness = data.value
                elseif data.type == "Material" then obj.Material = data.value
                elseif data.type == "Reflectance" then obj.Reflectance = data.value
                end
            end)
        end
    end
    BoostFPS.DisabledObjects = {}
    BoostFPS.OriginalSettings = {}
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
    end)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then pcall(function() terrain.Decoration = true end) end
end

-- ==================== WATERMARK ====================
local Watermark = {
    Enabled = false, Gui = nil, Label = nil, FrameConn = nil,
    FPS = 60, FrameCount = 0, LastFPSUpdate = tick(),
}

local function createWatermark()
    if Watermark.Gui then Watermark.Gui:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "VizHub_Watermark"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999
    if gethui then gui.Parent = gethui() else gui.Parent = game:GetService("CoreGui") end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 0)
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = frame

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 6)
    padding.PaddingBottom = UDim.new(0, 6)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 0)
    label.AutomaticSize = Enum.AutomaticSize.Y
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Code
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.Text = "VizHub | Loading..."
    label.Parent = frame

    Watermark.Gui = gui
    Watermark.Label = label

    Watermark.FrameConn = RunService.Heartbeat:Connect(function()
        Watermark.FrameCount = Watermark.FrameCount + 1
        local now = tick()
        if now - Watermark.LastFPSUpdate >= 0.5 then
            Watermark.FPS = math.floor(Watermark.FrameCount / (now - Watermark.LastFPSUpdate))
            Watermark.FrameCount = 0
            Watermark.LastFPSUpdate = now
        end
    end)

    task.spawn(function()
        while Watermark.Enabled and Watermark.Gui do
            task.wait(0.3)
            local recoilState = RecoilControl.Enabled and "ON" or "OFF"
            local recoilColor = RecoilControl.Enabled and "[+]" or "[-]"
            local aimState = AimCursor.Enabled and "ON" or "OFF"
            local aimColor = AimCursor.Enabled and "[+]" or "[-]"
            local ping = "?"
            pcall(function()
                ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            local time = os.date("%H:%M:%S")
            local text = string.format(
                "VizHub | FPS: %d | Ping: %s\nRecoil [LMB]: %s %s\nAimbot [RMB]: %s %s\nTime: %s",
                Watermark.FPS, tostring(ping),
                recoilColor, recoilState, aimColor, aimState, time
            )
            if Watermark.Label and Watermark.Label.Parent then
                Watermark.Label.Text = text
            else
                break
            end
        end
    end)
end

local function removeWatermark()
    if Watermark.FrameConn then
        pcall(function() Watermark.FrameConn:Disconnect() end)
        Watermark.FrameConn = nil
    end
    if Watermark.Gui then
        Watermark.Gui:Destroy()
        Watermark.Gui = nil
    end
    Watermark.Label = nil
end

-- ================================================================
--              СОЗДАЁМ СЕКЦИИ И НАПОЛНЯЕМ
-- ================================================================

local SectionESP        = Menu:CreateSection("Visuals")
local SectionAimbot     = Menu:CreateSection("Aimbot")
local SectionRecoil     = Menu:CreateSection("Combat")
local SectionFullbright = Menu:CreateSection("Graphics")
local SectionBoostFPS   = Menu:CreateSection("Performance")
local SectionSettings   = Menu:CreateSection("Settings")

Menu:SelectSection(SectionESP)

-- ==================== ESP BOTS ====================
Menu:Label(SectionESP, "── ESP ONLY NPC's ──")
Menu:Toggle(SectionESP, "ESP (NPC)", false, function(v)
    ESP.Bots.Enabled = v
    if v then
        for _, m in ipairs(BotRegistry.Bots) do ensureHighlight(m) end
    else
        removeAllHighlights()
    end
end)

Menu:ColorPicker(SectionESP, "NPC Fill Color", ESP.Bots.FillColor, function(c)
    ESP.Bots.FillColor = c
    updateAllHighlights("FillColor", c)
end)

Menu:ColorPicker(SectionESP, "NPC Outline Color", ESP.Bots.OutlineColor, function(c)
    ESP.Bots.OutlineColor = c
    updateAllHighlights("OutlineColor", c)
end)

Menu:Slider(SectionESP, "Fill Transparency", 0, 1, 0.5, function(v)
    ESP.Bots.FillTransparency = v
    updateAllHighlights("FillTransparency", v)
end)

Menu:Slider(SectionESP, "Outline Transparency", 0, 1, 0, function(v)
    ESP.Bots.OutlineTransparency = v
    updateAllHighlights("OutlineTransparency", v)
end)
-- ══════════════ HEALTH ESP ══════════════
Menu:Label(SectionESP, "── ESP Health ──")

Menu:Toggle(SectionESP, "Health ESP", false, function(v)
    HealthESP.Enabled = v
    if not v then
        for _, set in pairs(HealthESP.Drawings) do
            set.name.Visible = false
            set.hp.Visible = false
            set.dist.Visible = false
        end
    end
end)

Menu:Toggle(SectionESP, "  Show Name", true, function(v)
    HealthESP.ShowName = v
end)

Menu:Toggle(SectionESP, "  Show Health", true, function(v)
    HealthESP.ShowHealth = v
end)

Menu:Toggle(SectionESP, "  Show Distance", false, function(v)
    HealthESP.ShowDistance = v
end)

Menu:Slider(SectionESP, "  Max Distance", 50, 2000, 500, function(v)
    HealthESP.MaxDistance = v
end)

Menu:Slider(SectionESP, "  Scale", 0.5, 2, 1, function(v)
    HealthESP.Scale = v
end)

Menu:Slider(SectionESP, "  Offset Y", 0, 10, 3, function(v)
    HealthESP.OffsetY = v
end)

-- ==================== FULLBRIGHT ====================
Menu:Label(SectionFullbright, "── Render Settings ──")
Menu:Toggle(SectionFullbright, "Fullbright", false, function(v)
    local ok, err = pcall(function()
        Fullbright.Enabled = v
        if v then
            saveLighting()
            startFullbright()
        else
            stopFullbright()
            restoreLighting()
        end
    end)
    if not ok then warn("[Fullbright] error:", err) end
end)

Menu:Slider(SectionFullbright, "Brightness", 1, 10, 3, function(v)
    Fullbright.Brightness = v
end)

Menu:Slider(SectionFullbright, "ClockTime", 0, 24, 12, function(v)
    Fullbright.ClockTime = v
end)

Menu:Toggle(SectionFullbright, "No Fog", true, function(v) Fullbright.NoFog = v end)
Menu:Toggle(SectionFullbright, "No Atmosphere", true, function(v) Fullbright.NoAtmosphere = v end)
Menu:Toggle(SectionFullbright, "No ColorCorrection", true, function(v) Fullbright.NoColorCorrection = v end)
Menu:Toggle(SectionFullbright, "No Bloom", true, function(v) Fullbright.NoBloom = v end)
Menu:Toggle(SectionFullbright, "No SunRays", true, function(v) Fullbright.NoSunRays = v end)
Menu:Toggle(SectionFullbright, "No Blur / DoF", true, function(v)
    Fullbright.NoBlur = v
    Fullbright.NoDepthOfField = v
    
end)
-- Skybox внутри Fullbright
Menu:Label(SectionFullbright, "── Textures ──")

Menu:Toggle(SectionFullbright, "Enable Custom Skybox", false, function(v)
    if v then
        applySkyboxPreset(Skybox.CurrentPreset)
    else
        clearSkybox()
    end
end)

Menu:Dropdown(SectionFullbright, "Skybox Preset",
    {"Night", "Space", "Nebula", "Blue Sky", "Stormy"}, "Night",
    function(v)
        Skybox.CurrentPreset = v
        if Skybox.Enabled then
            applySkyboxPreset(v)
        end
    end
)

-- ==================== RECOIL ====================
Menu:Label(SectionRecoil, "── Recoil Controller ──")
RecoilControl.Toggle = Menu:Toggle(SectionRecoil, "Recoil Control", false, function(v)
    setRecoilState(v)
end)

Menu:Dropdown(SectionRecoil, "Recoil Mode", {"Fixed", "Adaptive"}, "Fixed", function(v)
    RecoilControl.Mode = v
    RecoilControl.Shooting = false
    RecoilControl.LastCameraCF = nil
    RecoilControl.RecoilSamples = {}
    RecoilControl.SampleCount = 0
end)

Menu:Slider(SectionRecoil, "Recoil Speed (Fixed)", 0.5, 20, 3, function(v)
    RecoilControl.Speed = v
end)

Menu:Slider(SectionRecoil, "Recoil Sensitivity", 0.1, 3, 1, function(v)
    RecoilControl.Sensitivity = v
end)

local f1ToggleConnection = UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        setRecoilState(not RecoilControl.Enabled)
    end
end)
Menu:Label(SectionRecoil, "── Camera FOV ──")

Menu:Toggle(SectionRecoil, "Custom FOV", false, function(v)
    if v then
        startCameraFOV()
    else
        stopCameraFOV()
    end
end)

Menu:Slider(SectionRecoil, "  FOV Value", 30, 120, 70, function(v)
    CameraFOV.Value = v
    -- Значение применится автоматически через RenderStep
end)

-- ==================== AIMBOT ====================
Menu:Label(SectionAimbot, "── Aimbot ──")
Menu:Toggle(SectionAimbot, "Enable Aimbot (Hold RMB)", false, function(v)
    AimCursor.Enabled = v
    if not v then
        AimCursor.CachedTarget = nil
        if AimCursor.FOVObject then AimCursor.FOVObject.Visible = false end
    end
end)

Menu:Slider(SectionAimbot, "Aimbot FOV", 20, 800, 250, function(v)
    AimCursor.FOV = v
    if AimCursor.FOVObject then AimCursor.FOVObject.Radius = v end
end)

Menu:Slider(SectionAimbot, "Aimbot Speed", 0.1, 10, 1, function(v)
    AimCursor.Speed = v
    AimCursor.CachedTarget = nil
end)

Menu:Slider(SectionAimbot, "Aimbot Smoothness", 1, 10, 1, function(v)
    AimCursor.Smoothness = v
end)

Menu:Toggle(SectionAimbot, "Visible Only", true, function(v)
    AimCursor.VisibleOnly = v
    AimCursor.CachedTarget = nil
end)

Menu:Toggle(SectionAimbot, "Show FOV Circle", true, function(v)
    AimCursor.ShowFOV = v
    if not v and AimCursor.FOVObject then AimCursor.FOVObject.Visible = false end
end)

Menu:ColorPicker(SectionAimbot, "FOV Circle Color", Color3.fromRGB(255, 255, 255), function(c)
    AimCursor.FOVColor = c
    if AimCursor.FOVObject then AimCursor.FOVObject.Color = c end
end)

Menu:Slider(SectionAimbot, "FOV Thickness", 1, 5, 1, function(v)
    AimCursor.FOVThickness = v
    if AimCursor.FOVObject then AimCursor.FOVObject.Thickness = v end
end)

Menu:Slider(SectionAimbot, "FOV Transparency", 0, 1, 0.7, function(v)
    AimCursor.FOVTransparency = v
    if AimCursor.FOVObject then AimCursor.FOVObject.Transparency = v end
end)

Menu:Toggle(SectionAimbot, "FOV Circle Filled", false, function(v)
    AimCursor.FOVFilled = v
    if AimCursor.FOVObject then AimCursor.FOVObject.Filled = v end
end)
-- ══════════════ TRIGGERBOT ══════════════
Menu:Label(SectionAimbot, "── Triggerbot ──")

local Triggerbot = {
    Enabled = false,
    Mode = "Hold",              -- Hold | Always
    HoldKey = Enum.KeyCode.LeftAlt,
    IsHolding = false,
    Delay = 0.05,               -- сек между выстрелами
    LastShot = 0,
    FOV = 30,                   -- радиус вокруг прицела
    VisibleOnly = true,
    UseMouse1 = true,           -- эмулировать ЛКМ
    TargetPart = "Head",        -- Head / UpperTorso / HumanoidRootPart
}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Triggerbot.HoldKey then
        Triggerbot.IsHolding = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Triggerbot.HoldKey then
        Triggerbot.IsHolding = false
    end
end)

local function triggerbotGetTarget()
    local camera = workspace.CurrentCamera
    if not camera then return nil end

    local vp = camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)

    local best, bestDist = nil, math.huge

    for _, model in ipairs(BotRegistry.Bots) do
        if model.Parent then
            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local part = model:FindFirstChild(Triggerbot.TargetPart)
                if part and part:IsA("BasePart") then
                    local sp, onScreen = camera:WorldToViewportPoint(part.Position)
                    if onScreen and sp.Z > 0 then
                        local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if d <= Triggerbot.FOV and d < bestDist then
                            if not Triggerbot.VisibleOnly or isVisible(model, part) then
                                bestDist = d
                                best = { model = model, part = part }
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

local function triggerbotClick()
    if Triggerbot.UseMouse1 then
        -- mouse1click есть у большинства executor'ов
        if mouse1click then
            pcall(mouse1click)
        elseif mouse1press and mouse1release then
            pcall(mouse1press)
            task.wait(0.02)
            pcall(mouse1release)
        end
    end
end

local triggerbotRender = RunService.RenderStepped:Connect(function()
    if not Triggerbot.Enabled then return end

    -- Режим
    if Triggerbot.Mode == "Hold" and not Triggerbot.IsHolding then return end
    if not UserInputService.MouseEnabled then return end

    -- Delay
    local now = os.clock()
    if now - Triggerbot.LastShot < Triggerbot.Delay then return end

    -- Ищем цель в маленьком FOV
    local target = triggerbotGetTarget()
    if not target then return end

    Triggerbot.LastShot = now
    triggerbotClick()
end)

Menu:Toggle(SectionAimbot, "Triggerbot", false, function(v)
    Triggerbot.Enabled = v
    Triggerbot.LastShot = 0
end)

Menu:Dropdown(SectionAimbot, "  Trigger Mode", {"Hold", "Always"}, "Hold", function(v)
    Triggerbot.Mode = v
end)

Menu:Dropdown(SectionAimbot, "  Hold Key",
    {"LeftAlt", "RightAlt", "LeftControl", "RightControl", "Q", "E", "C", "X", "Z"},
    "LeftAlt",
    function(v)
        local map = {
            LeftAlt = Enum.KeyCode.LeftAlt,
            RightAlt = Enum.KeyCode.RightAlt,
            LeftControl = Enum.KeyCode.LeftControl,
            RightControl = Enum.KeyCode.RightControl,
            Q = Enum.KeyCode.Q, E = Enum.KeyCode.E,
            C = Enum.KeyCode.C, X = Enum.KeyCode.X, Z = Enum.KeyCode.Z,
        }
        Triggerbot.HoldKey = map[v] or Enum.KeyCode.LeftAlt
    end
)

Menu:Slider(SectionAimbot, "  Trigger FOV", 5, 200, 30, function(v)
    Triggerbot.FOV = v
end)

Menu:Slider(SectionAimbot, "  Trigger Delay", 0.01, 0.5, 0.05, function(v)
    Triggerbot.Delay = v
end)

Menu:Toggle(SectionAimbot, "  Trigger Visible Only", true, function(v)
    Triggerbot.VisibleOnly = v
end)

Menu:Dropdown(SectionAimbot, "  Trigger Target",
    {"Head", "UpperTorso", "Torso", "HumanoidRootPart"},
    "Head",
    function(v)
        Triggerbot.TargetPart = v
    end
)

-- ==================== BOOST FPS ====================
Menu:Label(SectionBoostFPS, "── Perfomance Boosting ──")
Menu:Toggle(SectionBoostFPS, "FPS Boost", false, function(v)
    if v then enableBoostFPS() else disableBoostFPS() end
end)

-- ==================== SETTINGS ====================
Menu:Label(SectionSettings, "── Hub Information ──")
Menu:Toggle(SectionSettings, "Watermark & Keybinds", false, function(v)
    Watermark.Enabled = v
    if v then createWatermark() else removeWatermark() end
end)

Menu:Button(SectionSettings, "Unload Hub", function()
    ESP.Bots.Enabled = false
    pcall(removeAllHighlights)

    Fullbright.Enabled = false
    stopFullbright()
    pcall(restoreLighting)

    if MouseDown then MouseDown.Enabled = false end
    if RecoilControl then
        RecoilControl.Enabled = false
        RecoilControl.Shooting = false
        RecoilControl.LastCameraCF = nil
    end

    AimCursor.Enabled = false
    AimCursor.CachedTarget = nil
    if AimCursor.FOVObject then
        pcall(function() AimCursor.FOVObject:Remove() end)
        AimCursor.FOVObject = nil
    end
    if AimCursor.FOVConn then
        pcall(function() AimCursor.FOVConn:Disconnect() end)
        AimCursor.FOVConn = nil
    end

    if Skybox.Enabled then pcall(clearSkybox) end
    if BoostFPS.Enabled then pcall(disableBoostFPS) end

    Watermark.Enabled = false
    pcall(removeWatermark)

    if f1ToggleConnection then
        pcall(function() f1ToggleConnection:Disconnect() end)
    end
    if aimCursorRender then
        pcall(function() aimCursorRender:Disconnect() end)
    end
    if RecoilControl and RecoilControl.RenderConn then
        pcall(function() RecoilControl.RenderConn:Disconnect() end)
        RecoilControl.RenderConn = nil
    end

    pcall(function() ScreenGui:Destroy() end)

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "VizHub",
        Text = "Hack Unloaded",
        Duration = 3,
    })
        -- Health ESP cleanup
    for _, set in pairs(HealthESP.Drawings) do
        for _, d in pairs(set) do
            pcall(function() d:Remove() end)
        end
    end
    HealthESP.Drawings = {}
    if healthESPRender then
        pcall(function() healthESPRender:Disconnect() end)
    end

    -- Triggerbot cleanup
    if triggerbotRender then
        pcall(function() triggerbotRender:Disconnect() end)
    end
    Triggerbot.Enabled = false
end)

Menu:Label(SectionSettings, "Toggle menu: " .. CONFIG.ToggleKey.Name)
Menu:Label(SectionSettings, "Recoil Control: F1")
Menu:Label(SectionSettings, "Aimbot: hold Mouse 2")
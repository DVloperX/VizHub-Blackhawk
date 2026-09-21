-- ================================================================
-- VizHub Key System (HWID-locked)
-- ================================================================

-- ═══════════════ НАСТРОЙКИ ═══════════════
local KEY_CONFIG = {
    Title       = "VizHub - Internal | BRM5",
    Subtitle    = "Введите ключ",

    -- Ссылка на твой скрипт (после успешного ключа)
    ScriptURL   = "https://raw.githubusercontent.com/DVloperX/VizHub-Blackhawk/refs/heads/main/vizhubdrop.lua",

    -- ─── JSONBin настройки ───
    API_KEY     = "$2a$10$n4Eoj0AUqU1BNzBM/59BWOxRRpriX7a9JiG0rncgbl/r.O.J6Nqny",     -- из jsonbin.io
    BIN_ID      = "6ab15450ffd5d160531fd4e3",          -- из jsonbin.io

    -- ─── Локальный кэш ключа ───
    SaveKey     = false,
    SaveFile    = "VizHub_Key.txt",

    -- ─── Цвета ───
    AccentColor = Color3.fromRGB(88, 101, 242),
    BgColor     = Color3.fromRGB(20, 20, 25),
    PanelColor  = Color3.fromRGB(28, 28, 34),
    TextColor   = Color3.fromRGB(240, 240, 240),
    ErrorColor  = Color3.fromRGB(255, 80, 80),
    SuccessColor= Color3.fromRGB(80, 220, 100),
}

-- ═══════════════ СЕРВИСЫ ═══════════════
local Players          = game:GetService("Players")
local HttpService      = game:GetService("HttpService")
local TweenService     = game:GetService("TweenService")
local LocalPlayer      = Players.LocalPlayer

-- ═══════════════ HWID ═══════════════
local function getHWID()
    -- 1) Пробуем через executor API
    if gethwid then
        local ok, id = pcall(gethwid)
        if ok and id and id ~= "" then return tostring(id) end
    end
    if syn and syn.get_hwid then
        local ok, id = pcall(syn.get_hwid)
        if ok and id then return tostring(id) end
    end
    -- 2) Fallback: идентификатор пользователя Roblox (менее уникален)
    return "RBX-" .. tostring(LocalPlayer.UserId)
end

-- ═══════════════ HTTP ЗАПРОСЫ ═══════════════
local function httpRequest(opts)
    if request then
        local ok, res = pcall(request, opts)
        if ok then return res end
    end
    if http_request then
        local ok, res = pcall(http_request, opts)
        if ok then return res end
    end
    if syn and syn.request then
        local ok, res = pcall(syn.request, opts)
        if ok then return res end
    end
    return nil
end

local function fetchKeys()
    local url = "https://api.jsonbin.io/v3/b/" .. KEY_CONFIG.BIN_ID .. "/latest"
    local res = httpRequest({
        Url = url,
        Method = "GET",
        Headers = {
            ["X-Master-Key"] = KEY_CONFIG.API_KEY,
            ["Content-Type"] = "application/json",
        },
    })

    if not res or not res.Body then return nil end
    local ok, data = pcall(HttpService.JSONDecode, HttpService, res.Body)
    if not ok or not data or not data.record then return nil end
    return data.record
end

local function updateKeys(record)
    local url = "https://api.jsonbin.io/v3/b/" .. KEY_CONFIG.BIN_ID
    local body = HttpService:JSONEncode(record)

    local res = httpRequest({
        Url = url,
        Method = "PUT",
        Headers = {
            ["X-Master-Key"] = KEY_CONFIG.API_KEY,
            ["Content-Type"] = "application/json",
        },
        Body = body,
    })

    if not res or not res.Body then return false end
    return res.StatusCode == 200
end

-- ═══════════════ ПРОВЕРКА КЛЮЧА ═══════════════
-- Возвращает: status, message
--   "ok"      — ключ валидный, доступ разрешён
--   "bound"   — ключ впервые привязан к этому HWID
--   "invalid" — ключа нет в базе
--   "used"    — ключ уже привязан к другому HWID
--   "error"   — ошибка сети/API
local function checkKey(key)
    local hwid = getHWID()
    local record = fetchKeys()

    if not record then
        return "error", "Не удалось подключиться к серверу"
    end
    if not record.keys then
        record.keys = {}
    end

    local entry = record.keys[key]

    -- Ключа нет вообще
    if not entry then
        return "invalid", "Ключ не найден"
    end

    -- Ключ есть, но не привязан ни к кому → привязываем
    if not entry.hwid or entry.hwid == "" then
        entry.hwid = hwid
        entry.bound_at = os.time()
        if not updateKeys(record) then
            return "error", "Ошибка записи (попробуйте позже)"
        end
        return "bound", "Ключ активирован и привязан к вашему устройству"
    end

    -- Ключ уже привязан к этому HWID
    if entry.hwid == hwid then
        return "ok", "Ключ активирован!"
    end

    -- Ключ привязан к ДРУГОМУ HWID
    return "used", "Ключ уже использован другим пользователем"
end

-- ═══════════════ ЗАПУСК СКРИПТА ═══════════════
local function launchScript()
    local ok, err = pcall(function()
        loadstring(game:HttpGet(KEY_CONFIG.ScriptURL))()
    end)
    if not ok then
        warn("[VizHub] Ошибка загрузки скрипта:", err)
    end
end

-- ═══════════════ UI КЛЮЧА ═══════════════
local parentGui = (gethui and gethui()) or game:GetService("CoreGui")

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "VizHub_KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.IgnoreGuiInset = true
KeyGui.DisplayOrder = 1000
pcall(function() KeyGui.Parent = parentGui end)
if not KeyGui.Parent then
    KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 0.5
Backdrop.BorderSizePixel = 0
Backdrop.Parent = KeyGui

local Window = Instance.new("Frame")
Window.Size = UDim2.new(0, 440, 0, 280)
Window.Position = UDim2.new(0.5, 0, 0.5, 0)
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.BackgroundColor3 = KEY_CONFIG.BgColor
Window.BorderSizePixel = 0
Window.Active = true
Window.Draggable = true
Window.Parent = KeyGui

local wCorner = Instance.new("UICorner")
wCorner.CornerRadius = UDim.new(0, 12)
wCorner.Parent = Window

local wStroke = Instance.new("UIStroke")
wStroke.Color = KEY_CONFIG.AccentColor
wStroke.Thickness = 1.5
wStroke.Transparency = 0.3
wStroke.Parent = Window

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = KEY_CONFIG.PanelColor
TopBar.BorderSizePixel = 0
TopBar.Parent = Window

local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 12)
tbCorner.Parent = TopBar

local tbFix = Instance.new("Frame")
tbFix.Size = UDim2.new(1, 0, 0, 10)
tbFix.Position = UDim2.new(0, 0, 1, -10)
tbFix.BackgroundColor3 = KEY_CONFIG.PanelColor
tbFix.BorderSizePixel = 0
tbFix.Parent = TopBar

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1, -60, 1, 0)
TitleLbl.Position = UDim2.new(0, 16, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = KEY_CONFIG.Title
TitleLbl.TextColor3 = KEY_CONFIG.TextColor
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextSize = 15
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = KEY_CONFIG.TextColor
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar

local cbCorner = Instance.new("UICorner")
cbCorner.CornerRadius = UDim.new(0, 6)
cbCorner.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
end)
CloseBtn.MouseButton1Click:Connect(function()
    KeyGui:Destroy()
end)

local SubLbl = Instance.new("TextLabel")
SubLbl.Size = UDim2.new(1, -40, 0, 24)
SubLbl.Position = UDim2.new(0, 20, 0, 55)
SubLbl.BackgroundTransparency = 1
SubLbl.Text = KEY_CONFIG.Subtitle
SubLbl.TextColor3 = Color3.fromRGB(180, 180, 190)
SubLbl.Font = Enum.Font.Gotham
SubLbl.TextSize = 13
SubLbl.TextXAlignment = Enum.TextXAlignment.Left
SubLbl.Parent = Window

local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(1, -40, 0, 40)
InputFrame.Position = UDim2.new(0, 20, 0, 90)
InputFrame.BackgroundColor3 = KEY_CONFIG.PanelColor
InputFrame.BorderSizePixel = 0
InputFrame.Parent = Window

local ifCorner = Instance.new("UICorner")
ifCorner.CornerRadius = UDim.new(0, 8)
ifCorner.Parent = InputFrame

local ifStroke = Instance.new("UIStroke")
ifStroke.Color = Color3.fromRGB(60, 60, 70)
ifStroke.Thickness = 1
ifStroke.Parent = InputFrame

local Input = Instance.new("TextBox")
Input.Size = UDim2.new(1, -20, 1, 0)
Input.Position = UDim2.new(0, 10, 0, 0)
Input.BackgroundTransparency = 1
Input.Text = ""
Input.PlaceholderText = "Введите ключ..."
Input.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
Input.TextColor3 = KEY_CONFIG.TextColor
Input.Font = Enum.Font.Gotham
Input.TextSize = 14
Input.TextXAlignment = Enum.TextXAlignment.Left
Input.ClearTextOnFocus = false
Input.Parent = InputFrame

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(1, -40, 0, 42)
SubmitBtn.Position = UDim2.new(0, 20, 0, 145)
SubmitBtn.BackgroundColor3 = KEY_CONFIG.AccentColor
SubmitBtn.Text = "ВОЙТИ"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.BorderSizePixel = 0
SubmitBtn.AutoButtonColor = false
SubmitBtn.Parent = Window

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 8)
sbCorner.Parent = SubmitBtn

SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(110, 125, 255)
    }):Play()
end)
SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = KEY_CONFIG.AccentColor
    }):Play()
end)

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Size = UDim2.new(1, -40, 0, 40)
StatusLbl.Position = UDim2.new(0, 20, 0, 200)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Text = ""
StatusLbl.TextColor3 = KEY_CONFIG.ErrorColor
StatusLbl.Font = Enum.Font.Gotham
StatusLbl.TextSize = 13
StatusLbl.TextWrapped = true
StatusLbl.TextXAlignment = Enum.TextXAlignment.Center
StatusLbl.Parent = Window

-- ═══════════════ ЛОГИКА ═══════════════
local function setStatus(text, color)
    StatusLbl.Text = text
    StatusLbl.TextColor3 = color or KEY_CONFIG.ErrorColor
end

local isProcessing = false

local function trySubmit()
    if isProcessing then return end

    local key = Input.Text:gsub("%s+", "")
    if key == "" then
        setStatus("Введите ключ", KEY_CONFIG.ErrorColor)
        return
    end

    isProcessing = true
    SubmitBtn.Text = "ПРОВЕРКА..."
    setStatus("Связь с сервером...", Color3.fromRGB(200, 200, 100))

    task.spawn(function()
        local status, message = checkKey(key)

        if status == "ok" or status == "bound" then
            setStatus(message, KEY_CONFIG.SuccessColor)
            SubmitBtn.Text = "ЗАГРУЗКА..."
            task.wait(0.6)
            KeyGui:Destroy()
            launchScript()
            return
        end

        -- Ошибки
        setStatus(message, KEY_CONFIG.ErrorColor)
        SubmitBtn.Text = "ВОЙТИ"
        isProcessing = false

        -- Тряска при неверном ключе
        if status == "invalid" or status == "used" then
            local origPos = Window.Position
            for i = 1, 6 do
                local offset = (i % 2 == 0) and 8 or -8
                Window.Position = origPos + UDim2.new(0, offset, 0, 0)
                task.wait(0.03)
            end
            Window.Position = origPos

            ifStroke.Color = KEY_CONFIG.ErrorColor
            task.delay(0.6, function()
                if ifStroke and ifStroke.Parent then
                    ifStroke.Color = Color3.fromRGB(60, 60, 70)
                end
            end)
        end
    end)
end

SubmitBtn.MouseButton1Click:Connect(trySubmit)

Input.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        trySubmit()
    end
end)

task.defer(function()
    task.wait(0.3)
    if Input and Input.Parent then
        Input:CaptureFocus()
    end
end)
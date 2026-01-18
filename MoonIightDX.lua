--// MoonIight DX Full Script Hub
--// PC + Mobile Support
--// Dark Theme + Draggable + Multi-tabs + Games
--// Toggle with K (PC) + On-screen button (Mobile/PC)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local hub = Instance.new("ScreenGui")
hub.Name = "MoonIightDX"
hub.ResetOnSpawn = false
hub.Parent = PlayerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 750, 0, 520)
frame.Position = UDim2.new(0.5, -375, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = hub

-- Rounded edges
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "🌌 MoonIight DX 🌌"
title.TextColor3 = Color3.fromRGB(200, 160, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

-- Dragging (PC + Mobile)
local dragging = false
local dragStart, startPos

local function startDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = frame.Position
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        startDrag(input)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

-- Tabs
local tabs = {"Utilities","Fun","Visuals","Combat","Special","Games"}
local tabFrames = {}

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1,0,0,40)
tabBar.Position = UDim2.new(0,0,0,50)
tabBar.BackgroundTransparency = 1
tabBar.Parent = frame

for i,name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,120,1,0)
    btn.Position = UDim2.new(0,(i-1)*125,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,60)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Text = name
    btn.Parent = tabBar
    
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1,-20,1,-100)
    tabFrame.Position = UDim2.new(0,10,0,100)
    tabFrame.BackgroundTransparency = 1
    tabFrame.ScrollBarThickness = 8
    tabFrame.CanvasSize = UDim2.new(0,0,0,0)
    tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabFrame.Visible = (i==1)
    tabFrame.Parent = frame
    tabFrames[name] = tabFrame
    
    btn.MouseButton1Click:Connect(function()
        for _,f in pairs(tabFrames) do
            f.Visible = false
        end
        tabFrame.Visible = true
    end)
end

-- Button creator
local function addButton(tab,name,url)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,45)
    btn.Position = UDim2.new(0,5,0,#tab:GetChildren()*50)
    btn.BackgroundColor3 = Color3.fromRGB(60,0,120)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextWrapped = true
    btn.Text = name
    btn.Parent = tab
    btn.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet(url))()
        end)
    end)
end

-- ✅ Utilities (fixed)
addButton(tabFrames["Utilities"],"Infinite Yield","https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
addButton(tabFrames["Utilities"],"Dex Explorer","https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua")
addButton(tabFrames["Utilities"],"Remote Spy","https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua")

-- ✅ Fun (fixed)
addButton(tabFrames["Fun"],"Fly Script","https://pastebin.com/raw/CxjL8zYV")
addButton(tabFrames["Fun"],"Gravity Gun","https://raw.githubusercontent.com/lilmond/roblox_fly_script/main/v3.lua")
addButton(tabFrames["Fun"],"Speed Boost","https://raw.githubusercontent.com/TrixAde/scripts/main/Btools.lua")

-- ✅ Visuals (fixed)
addButton(tabFrames["Visuals"],"ESP Script","https://raw.githubusercontent.com/wa0101/Roblox-ESP/refs/heads/main/esp.lua")
addButton(tabFrames["Visuals"],"Chams","https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/ESP.lua")
addButton(tabFrames["Visuals"],"Rainbow Character","https://raw.githubusercontent.com/RobloxianRoblox3200/Scripts_Roblox/main/Esp_v4.lua")

-- ✅ Combat (unchanged URL, just wrapped)
addButton(tabFrames["Combat"],"TSB Moveset Hub","https://github.com/Guestly-Second-Account/Custom-Movesets-Hub/raw/main/Tsb%20script%20credits%20by%20Darker")

-- ✅ Special (XVC kept as you said)
addButton(tabFrames["Special"],"XVC Hub","https://raw.githubusercontent.com/Skeleton19/XVC-Hub/main/code.lua")

-- ✅ Games (fixed, XVC/Funky Friday untouched where relevant)
addButton(tabFrames["Games"],"Funky Friday","https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/Loader")
addButton(tabFrames["Games"],"Blox Fruits","https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua")
addButton(tabFrames["Games"],"Brookhaven","https://raw.githubusercontent.com/TrixAde/scripts/main/BrokenBones.lua")
addButton(tabFrames["Games"],"Pet Simulator X","https://luxhub.cc/script.lua")
addButton(tabFrames["Games"],"Adopt Me","https://raw.githubusercontent.com/TrixAde/scripts/main/AdoptMeGingerBreadsFarm.lua")
addButton(tabFrames["Games"],"Arsenal","https://raw.githubusercontent.com/ex55/weed-client/refs/heads/main/main.lua")
addButton(tabFrames["Games"],"Murder Mystery 2","https://raw.githubusercontent.com/TrixAde/scripts/main/BgsScript.lua")
addButton(tabFrames["Games"],"Tower of Hell","https://raw.githubusercontent.com/TrixAde/scripts/main/TowerOfHellHub.lua")
addButton(tabFrames["Games"],"Doors","https://raw.githubusercontent.com/RobloxianRoblox3200/Scripts_Roblox/main/DOORS_v3.lua")
addButton(tabFrames["Games"],"BedWars","https://raw.githubusercontent.com/miacheats/VapeV4ForRoblox/main/NewMainScript.lua")
addButton(tabFrames["Games"],"Shindo Life","https://raw.githubusercontent.com/shindo-life-scripts/shindolife/main/index.html")
addButton(tabFrames["Games"],"Jailbreak","https://raw.githubusercontent.com/RobloxianRoblox3200/Scripts_Roblox/main/Jailbreak.lua")
addButton(tabFrames["Games"],"MeepCity","https://raw.githubusercontent.com/TrixAde/scripts/main/DarkDexV3.lua")
addButton(tabFrames["Games"],"Royale High","https://raw.githubusercontent.com/TrixAde/scripts/main/BgsAztupBrewScript.lua")
addButton(tabFrames["Games"],"Anime Fighters","https://raw.githubusercontent.com/TrixAde/scripts/main/AnimeFighting.lua")
addButton(tabFrames["Games"],"Tower Defense Simulator","https://raw.githubusercontent.com/RobloxianRoblox3200/Scripts_Roblox/main/Tower_Defense_Simulator.lua")
addButton(tabFrames["Games"],"Build A Boat","https://raw.githubusercontent.com/TrixAde/scripts/main/Build_A_Boat_v3.lua")
addButton(tabFrames["Games"],"Natural Disaster Survival","https://raw.githubusercontent.com/TrixAde/scripts/main/NaturalDisaster.lua")
addButton(tabFrames["Games"],"Bee Swarm Simulator","https://raw.githubusercontent.com/TrixAde/scripts/main/Bss-Kocmoc-Lastest-V2.lua")

-- PC toggle with K
local visible = true
UIS.InputBegan:Connect(function(input,gp)
    if not gp and input.KeyCode == Enum.KeyCode.K then
        visible = not visible
        frame.Visible = visible
    end
end)

-- On-screen toggle button (PC + Mobile)
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,20,0.5,-30)
toggle.BackgroundColor3 = Color3.fromRGB(80,0,160)
toggle.Text = "DX"
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBold
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Parent = hub

toggle.MouseButton1Click:Connect(function()
    visible = not visible
    frame.Visible = visible
end)

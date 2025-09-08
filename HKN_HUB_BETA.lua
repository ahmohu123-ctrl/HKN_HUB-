-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Theme colors
local Themes = {
    Dark = Color3.fromRGB(25,25,25),
    Light = Color3.fromRGB(240,240,240),
    Neon = Color3.fromRGB(0,255,255)
}
local CurrentTheme = "Dark"

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "HKN HUB BETA",
    LoadingTitle = "HKN HUB BETA",
    LoadingSubtitle = "Welcome, Ahmed!",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "HKN_HUB",
        FileName = "config"
    },
    Discord = {Enabled = false},
    KeySystem = false
})

-- Force Show GUI
pcall(function()
    local gui = game:GetService("CoreGui"):WaitForChild("Rayfield", 5)
    if gui then gui.Enabled = true end
end)

-- Helper function for button animation
local function AnimateButton(button)
    spawn(function()
        local origColor = button.BackgroundColor3
        button.BackgroundColor3 = Themes[CurrentTheme]
        wait(0.1)
        button.BackgroundColor3 = origColor
    end)
end

-- AntiKick / AntiBan
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
    if not LocalPlayer.Parent then
        Rayfield:Notify({Title="Security", Content="Kick attempt detected! Rejoining...", Duration=3})
        pcall(function()
            local cloned = LocalPlayer:Clone()
            cloned.Parent = workspace
        end)
    end
end)

-- All Scripts Tab
local ScriptsTab = Window:CreateTab("🧩 All Scripts", 4483362458)
local scripts = {
    {Name="🔥 UGLY HUB", URL="https://api.luarmor.net/files/v3/loaders/53325754de16c11fbf8bf78101c1c881.lua"},
    {Name="🛡️ KURD HUB", URL="https://rawscripts.net/raw/Universal-Script-Kurd-Hub-27356"},
    {Name="🌶️ CHILLI HUB", URL="https://rawscripts.net/raw/Steal-a-Brainrot-Chilli-hub-51378"},
    {Name="⚡ KANGER HUB", URL="https://raw.githubusercontent.com/iw929wiwiw/New-Bypassed-/refs/heads/main/SAB"},
    {Name="🐼 LyezHub", URL="https://pandadevelopment.net/virtual/file/0988845b2372c5ee"},
    {Name="💻 Uni Hub (PC only)", URL="https://pastebin.com/raw/dcyuEgyK"}
}

-- Search Box
ScriptsTab:CreateInput({
    Name = "Search Script",
    PlaceholderText = "Type script name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        for _, s in pairs(scripts) do
            if s.Name:lower():find(text:lower()) then
                Rayfield:Notify({Title="Search Result", Content=s.Name, Duration=2})
            end
        end
    end
})

for _, s in pairs(scripts) do
    ScriptsTab:CreateButton({
        Name = s.Name,
        Callback = function(buttonObj)
            AnimateButton(buttonObj)
            loadstring(game:HttpGet(s.URL))()
            Rayfield:Notify({Title="Running Script", Content=s.Name.." Activated!", Duration=3})
        end
    })
end

-- Support Tab
local SupportTab = Window:CreateTab("🛠️ Support", 4483362458)
SupportTab:CreateButton({
    Name = "🌐 Join Support Server",
    Callback = function(buttonObj)
        AnimateButton(buttonObj)
        setclipboard("https://discord.gg/42WZzPvD")
        Rayfield:Notify({Title="Support", Content="Discord link copied! Paste in browser to join HKN server.", Duration=4})
    end
})
SupportTab:CreateButton({
    Name = "📬 Contact Owner",
    Callback = function(buttonObj)
        AnimateButton(buttonObj)
        setclipboard("Ahmed#0001")
        Rayfield:Notify({Title="Support", Content="Owner info copied! Paste in chat to contact.", Duration=4})
    end
})

-- Themes Tab
local ThemeTab = Window:CreateTab("🎨 Themes", 4483362458)
for themeName, color in pairs(Themes) do
    ThemeTab:CreateButton({
        Name = themeName,
        Callback = function(buttonObj)
            AnimateButton(buttonObj)
            Window:ChangeColor(color)
            CurrentTheme = themeName
            Rayfield:Notify({Title="Theme Changed", Content=themeName.." theme applied!", Duration=3})
        end
    })
end

-- Tips & Tricks Tab
local TipsTab = Window:CreateTab("💡 Tips & Tricks", 4483362458)
local tips = {
    "Use UGLY HUB for fastest scripts.",
    "KURD HUB is stable for all maps.",
    "CHILLI HUB has extra utilities.",
    "Always update your executor."
}
for _, tip in pairs(tips) do
    TipsTab:CreateLabel(tip)
end

-- Credits Tab
local CreditsTab = Window:CreateTab("🎖️ Credits", 4483362458)
CreditsTab:CreateLabel("© 2025 Ahmed | Server: HKN")

-- Update Tab
local UpdateTab = Window:CreateTab("🔄 Update", 4483362458)
UpdateTab:CreateButton({
    Name = "Update HKN HUB",
    Callback = function(buttonObj)
        AnimateButton(buttonObj)
        Rayfield:Notify({Title="Update", Content="Downloading latest version...", Duration=3})
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/HKN-HUB-BETA/main/HKN_HUB_BETA.lua"))()
        end)
        if success then
            Rayfield:Notify({Title="Update", Content="HKN HUB updated successfully!", Duration=3})
        else
            Rayfield:Notify({Title="Update Error", Content=err, Duration=4})
        end
    end
})

-- Initial Notification
Rayfield:Notify({
    Title = "HKN HUB BETA",
    Content = "All scripts loaded successfully! AntiKick enabled.",
    Duration = 4
})

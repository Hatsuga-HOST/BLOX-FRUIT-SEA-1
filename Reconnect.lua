-- Blox Fruits Sea 1 Script - 100% Mirip Redz Hub V2 (Mobile Optimized)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = library.CreateLib("Blox Fruits Sea 1 - NANO HUB (Redz Hub V2 Style)", "BloodTheme")

-- Variables
local player = game.Players.LocalPlayer
local belly = player.Data.Beli
local fragment = player.Data.Fragments
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("ReplicatedStorage").Remotes.CommF_
local activeFarm = false
local activeTeleport = false
local activeShopAbility = false

-- Functions
local function teleportTo(location)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = location
    end
end

local function buyItem(npcPath, price)
    if belly.Value >= price then
        TeleportService:InvokeServer("BuyItem", npcPath)
    end
end

local function autoBuyAbility(abilityName)
    if not activeShopAbility then return end
    TeleportService:InvokeServer("BuyHaki", abilityName)
end

local function farmQuest()
    while activeFarm do
        local quest = TeleportService:InvokeServer("AutoQuest")
        if quest then
            TeleportService:InvokeServer("AutoFarm", quest)
        end
        wait(2)
    end
end

local function teleportIslands()
    while activeTeleport do
        for _, island in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
            teleportTo(island.CFrame)
            wait(3)
        end
    end
end

-- Main Tab (Farm Quest Otomatis)
local mainTab = Window:NewTab("Main")
local mainSection = mainTab:NewSection("Farm Quest Otomatis")

mainSection:NewToggle("Enable Farm Quest", "Kerjakan misi otomatis dengan auto attack & terbang", function(state)
    activeFarm = state
    if state then
        farmQuest()
    end
end)

-- Shop Tab (Lengkap dengan Ability)
local shopTab = Window:NewTab("Shop")
local swordSection = shopTab:NewSection("Swords")
local gunSection = shopTab:NewSection("Guns")
local fightingSection = shopTab:NewSection("Fighting Styles")
local abilitySection = shopTab:NewSection("Auto Buy Ability")
local accessoriesSection = shopTab:NewSection("Accessories")

-- Auto Buy Ability (Toggle)
abilitySection:NewToggle("Auto Buy Aura", "Otomatis beli Buso Haki saat cukup Belly", function(state)
    activeShopAbility = state
    if state then
        autoBuyAbility("Buso Haki")
    end
end)
abilitySection:NewToggle("Auto Buy Flash Step", "Otomatis beli Flash Step", function(state)
    activeShopAbility = state
    if state then
        autoBuyAbility("Flash Step")
    end
end)
abilitySection:NewToggle("Auto Buy Sky Jump", "Otomatis beli Sky Jump", function(state)
    activeShopAbility = state
    if state then
        autoBuyAbility("Sky Jump")
    end
end)

-- Teleport Tab (Otomatis & Lengkap)
local teleportTab = Window:NewTab("Teleport")
local teleportSection = teleportTab:NewSection("Teleportasi Pulau First Sea")

teleportSection:NewToggle("Enable Auto Teleport", "Teleport otomatis ke semua pulau di First Sea", function(state)
    activeTeleport = state
    if state then
        teleportIslands()
    end
end)

-- Miscellaneous Tab (Optimasi Mobile)
local miscTab = Window:NewTab("Miscellaneous")
local miscSection = miscTab:NewSection("Fitur Tambahan")

miscSection:NewToggle("Reduce Lag", "Mengurangi lag saat bermain", function(state)
    RunService:Set3dRenderingEnabled(not state)
end)
miscSection:NewToggle("Auto Reconnect", "Otomatis reconnect jika disconnect", function(state)
    if state then
        player.OnTeleport:Connect(function()
            loadstring(game:HttpGet(("https://raw.githubusercontent.com/Hatsuga-HOST/BLOX-FRUIT-SEA-1/refs/heads/main/Reconnect.lua")))()
        end)
    end
end)

print("[NANO HUB - Blox Fruits Sea 1 Script (Redz Hub V2 Style) Loaded Successfully]")

--loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/main/Dex%20V5.lua"))()
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/onion1242w/heloxda/main/real.lua"))()
-- dex
-- loadstring(game:HttpGet("https://pastebin.com/raw/ZLfF3qa0"))()
-- simple spy loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()

local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()

local Players = game:GetService("Players")
local RepStor = game:GetService("ReplicatedStorage")

local Player = game.Players.LocalPlayer

local MutlipMonsters = workspace.Monsters.Multiple
local SingleMonsters = workspace.Monsters.One

local Window = UILib.new("Survive in Area 51 Remake v0.0.1 ", Player.UserId, "Made by on_i6")
local Category = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainButton = Category:Button("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainTab = MainButton:Section("Main", "Left")

local KillAllMobsButton
local KillAuraToggle
local KillAuraRange

-- // Functions \\ --

local function FoundGun()
    -- Guns will probably have InflictTarget remote (not sure)
    local TarFoundGun = nil

    local TarToolBackpack = Player.Backpack:FindFirstChild("InflictTarget", true)
    local CharFoundGunRemote = Player.Character:FindFirstChild("InflictTarget", true)

    TarFoundGun = TarToolBackpack and TarToolBackpack:FindFirstAncestorWhichIsA("Tool") or TarFoundGun
    TarFoundGun = CharFoundGunRemote and CharFoundGunRemote:FindFirstAncestorWhichIsA("Tool") or TarFoundGun

    return TarFoundGun
end

local function KillTarget(TargetModel : Model)
    local Human = TargetModel:FindFirstChild("Humanoid")
    if Player.Character and Human then
        local RootProbably = Human.Torso
        if RootProbably then
            while task.wait() do
                local CurrentGun = FoundGun()
                if TargetModel:FindFirstChild("Humanoid") then
                    if CurrentGun and TargetModel.Humanoid.Health > 0 then
                        CurrentGun.GunScript_Server.InflictTarget:FireServer(RootProbably.Name, Human, RootProbably, CurrentGun, Vector3.new(0, 0, 0))
                    else
                        break
                    end
                else
                    break
                end
            end
        end
    end
end

local function KillAllMobs()
    for i, v in pairs(SingleMonsters:GetChildren()) do
        if v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then
                task.defer(KillTarget, v)
            end
        end
    end

    for _, v in pairs(MutlipMonsters:GetChildren()) do
        for i, Monster in pairs(v:GetChildren()) do
            if Monster:FindFirstChild("Humanoid") then
                if v.Humanoid.Health > 0 then
                    task.defer(KillTarget, v)
                end
            end
        end
    end
end

local AuraTargetedAlready = {}

local function KillAuraExtra(v, Range)
    if not AuraTargetedAlready[v.Parent] then
        local CFTar = v.Parent:GetPivot()
        local MyCf = Player.Character:GetPivot()
        local Mag = (CFTar.Position - MyCf.Position).Magnitude
        if Mag <= Range and v.Health > 0 then
            local DiedConn
            AuraTargetedAlready[v.Parent] = true
            task.defer(KillTarget, v.Parent)
            DiedConn = v.Died:Connect(function()
                AuraTargetedAlready[v.Parent] = nil
                DiedConn:Disconnect()
            end)
        end
    end
end

local function KillNpcsInRange(Range : number)
    if not Player.Character then return end

    for i, v in pairs(SingleMonsters:GetChildren()) do
        if v:FindFirstChild("Humanoid") then
            KillAuraExtra(v.Humanoid, Range)
        end
    end

    for _, v in pairs(MutlipMonsters:GetChildren()) do
        for i, Monster in pairs(v:GetChildren()) do
            if Monster:FindFirstChild("Humanoid") then
                KillAuraExtra(Monster.Humanoid, Range)
            end
        end
    end
end

-- // Ui \\ --

KillAllMobsButton = MainTab:Button({
        Title = "Kill All Npcs",
        Description = "",
        ButtonName = "KILL THEM"
    },
    KillAllMobs
)

KillAuraToggle = MainTab:Toggle({
        Title = "Kill Aura",
        Description = "Change range for cooler killaura",
        Default = false
    }, 
    function()
        -- nothing duh
    end
)

KillAuraRange = MainTab:Slider({
        Title = "Kill Aura Range",
        Description = "Range of killaura.",
        Default = 16,
        Min = 1,
        Max = 160
    }, 
    function()
        -- nothing
    end
)

-- // Loops \\ --

task.defer(function()
    while task.wait() do
        if KillAuraToggle:getValue() then
            KillNpcsInRange(KillAuraRange:getValue())
        end
    end
end)

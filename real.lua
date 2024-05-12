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

local Window = UILib.new("Survive in Area 51 Remake v0.0.1", Player.UserId, "!!")
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
                if not TargetModel:FindFirstChild("Humanoid") then break end
                if not CurrentGun or TargetModel.Humanoid.Health <= 0 then break end
                CurrentGun.GunScript_Server.InflictTarget:FireServer(RootProbably.Name, Human, RootProbably, CurrentGun, Vector3.new(0, 0, 0))
            end
        end
    end
end

local function KillAllMobs()
    for i, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Humanoid") then
            if v.Health > 0 then
                task.defer(KillTarget, v.Parent)
            end
        end
    end
end

local AuraTargetedAlready = {}

local function KillNpcsInRange(Range : number)
    if not Player.Character then return end
    for i, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Humanoid") then
            local CFTar = v.Parent:GetPivot()
            local MyCf = Player.Character:GetPivot()
            local Mag = (CFTar.Position - MyCf.Position).Magnitude
            if Mag <= Range and v.Health > 0 and not AuraTargetedAlready[v.Parent] then
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

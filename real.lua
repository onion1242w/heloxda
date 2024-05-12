--loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/main/Dex%20V5.lua"))()
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/onion1242w/heloxda/main/real.lua"))()
-- dex
-- loadstring(game:HttpGet("https://pastebin.com/raw/ZLfF3qa0"))()

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
                if CurrentGun and TargetModel:FindFirstChild("Humanoid") then
                    if TargetModel.Humanoid.Health > 0 then
                        CurrentGun.GunScript_Server.InflictTarget:FireServer(RootProbably.Name, Human, RootProbably, CurrentGun, Vector3.new(-0.13287943601608276, -0.226749986410141, -0.9648458957672119))
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
    for i, v in pairs(MutlipMonsters:GetChildren()) do
        for _, Monster in pairs(v:GetChildren()) do
            task.defer(KillTarget, Monster)
            task.wait()
        end
    end
    for i, Monster in pairs(SingleMonsters:GetChildren()) do
        task.defer(KillTarget, Monster)
        task.wait()
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

-- // Loops \\ --


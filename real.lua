--loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/main/Dex%20V5.lua"))()
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/onion1242w/heloxda/main/real.lua"))()
-- dex
-- loadstring(game:HttpGet("https://pastebin.com/raw/ZLfF3qa0"))()

local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()

local Players = game:GetService("Players")
local Player = game.Players.LocalPlayer

local MutlipMonsters = workspace.Monsters.Multiple
local SingleMonsters = workspace.Monsters.One

local TargetGun = "USP"

local Window = UILib.new("Survive in Area 51 Remake v0.0.1", Player.UserId, "!!")
local Category = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainButton = Category:Button("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainTab = MainButton:Section("Main", "Left")

local KillAllMobsButton

-- // Functions \\ --

local function FoundGun()
    local TarFoundGun = Player.Backpack:FindFirstChild(TargetGun) or Player.Character:FindFirstChild(TargetGun)
    return TarFoundGun
end

local function KillTarget(TargetModel : Model)
    local Human = TargetModel:FindFirstChild("Humanoid")
    if Player.Character and Human then
        local RootProbably = Human.Torso
        if RootProbably then
            while TargetModel.Humanoid.Health > 0 do
                local CurrentGun = FoundGun()
                if CurrentGun then
                    CurrentGun.GunScript_Server.InflictTarget:FireServer("Torso", TargetModel.Human, RootProbably, CurrentGun, Vector3.new(-0.13287943601608276, -0.226749986410141, -0.9648458957672119))
                end
                task.wait()
            end
        end
    end
end

local function KillAllMobs()
    for i, v in pairs(MutlipMonsters:GetChildren()) do
        for _, Monster in pairs(v:GetChildren()) do
            KillTarget(Monsters)
            task.wait()
        end
    end
    for i, Monster in pairs(SingleMonsters:GetChildren()) do
        KillTarget(Monsters)
        task.wait()
    end
end

-- // Ui \\ --

KillAllMobsButton = MainTab:Button({
        Title = "Kill All Npcs",
        Description = "",
        ButtonName = "kill..."
    },
    KillAllMobs
)

-- // Loops \\ --


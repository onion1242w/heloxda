--loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/main/Dex%20V5.lua"))()
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/onion1242w/heloxda/main/real.lua"))()
-- dex

local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()

local Player = game.Players.LocalPlayer

local Players = game:GetService("Players")

local Window = UILib.new("Ability wars v0.0.1", Player.UserId, "!!")
local Category = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainButton = Category:Button("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainTab = MainButton:Section("Main", "Left")

local RemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("Remote Events")

-- // Ui \\ --

local HitboxMul = MainTab:Slider({
        Title = "Hitbox Multiplier",
        Description = "",
        Default = 2,
        Min = 1,
        Max = 15
    }, 
    function(value)
        -- nothing
    end
)

local AFarmVal = MainTab:Toggle({
        Title = "Auto Farm Players",
        Description = "",
        Default = false
    },
    function(v)
        -- Nothing
    end
)

-- // Functions \\ --

local ClassicHitboxSize = 1.5

local function UpgradeHitbox(Multiplier)
    if Player.Character then
        local Multiplied = Multiplier * ClassicHitboxSize
        Player.Character.Hitbox.Size = Vector3.new(Multiplied, Multiplied, Multiplied)
    end
end

local function PunchHim(TargetChar)
    if TargetChar:FindFirstChild("Torso") then
        local args = {
            [1] = TargetChar, -- Target Model
            [2] = TargetChar:GetPivot().Position, -- Efect position
            [3] = 12.274284362792969, -- idk whats this (maybe hitbox size???)
            [4] = TargetChar.Torso -- Target Part
        }
        RemoteEvents.Punch:FireServer(unpack(args))
    end
end

-- // Loops \\ --

task.spawn(function()
    while task.wait() do
        UpgradeHitbox(HitboxMul:getValue())
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if AFarmVal:getValue() then
            for i, v in pairs(Players:GetChildren()) do
                if v.Character then
                    PunchHim(v.Character)
                    task.wait(0.05)
                end
            end
        end
    end
end)

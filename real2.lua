-- loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/main/Dex%20V5.lua"))()
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/onion1242w/heloxda/main/real2.lua"))()
-- dex
-- loadstring(game:HttpGet("https://pastebin.com/raw/ZLfF3qa0"))()
-- simple spy loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()

-- Rexol world

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Rexol world v0.0.1",
    SubTitle = "by !!!",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local MainTab = Window:AddTab({ Title = "Main", Icon = "home" }),
local Options = Fluent.Options

local RepStor = game:GetService("ReplicatedStorage")

local Remotes = RepStor:WaitForChild("Remotes")
local MobsFolder = workspace:WaitForChild("Mobs")

-- // Functions \\ --

local function DamageMob(TargetMob) -- works with equipped weapon
    Remotes.DamageMob:InvokeServer(TargetMob)
end

local function KillMob(TargetMob)
    while task.wait() and TargetMob do
        if TargetMob:FindFirstChild("Humanoid") then
            if TargetMob.Humanoid.Health > 0 then
                DamageMob(TargetMob)
            else
                break
            end
        else
            break
        end
    end
end

local function KillAllMobs()
    for i, v in pairs(MobsFolder:GetChildren()) do
        if v:IsA("Model") then -- Not sure if folders exist
            task.defer(KillMob, v)
        end
    end
end

-- // UI \\ --

MainTab:AddButton({
    Title = "Kill All Mobs",
    Description = "Kills all mobs",
    Callback = KillAllMobs
})



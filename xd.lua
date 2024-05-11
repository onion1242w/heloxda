--loadstring(game:HttpGet('https://raw.githubusercontent.com/onion1242w/whatidk/main/whadudhell.lua'))()
--loadstring(game:HttpGet('https://raw.githubusercontent.com/onion1242w/heloxda/main/xd.lua'))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/main/Dex%20V5.lua"))()
-- dex

local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()

local Player = game.Players.LocalPlayer

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local Window = UILib.new("Blox fruits but bad v0.0.1", Player.UserId, "!!")
local Category = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainButton = Category:Button("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainTab = MainButton:Section("Main", "Left")

-- // Config \\ --

local CurrentFruitModel = nil

-- // Functions \\ --

local function SpawnShips(Count : number)
    for i = 1, Count do
        MarketplaceService:SignalPromptProductPurchaseFinished(Player.UserId, 1717407738, true)
        task.wait(1.3)
    end
end

local function GodMode()
    if Player.Character then
        Player.Character.Humanoid.MaxHealth = math.huge
        Player.Character.Humanoid.Health = math.huge
    end
end

local function FindFruitInInventory(FruitName : string)
    if Player.Character.Humanoid.Health > 0 then
        local Fru = Player.Backpack:FindFirstChild(FruitName) or Player.Character:FindFirstChild(FruitName)
        return Fru
    end
    return nil
end

local function FindEquippedFruit()
    for i, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("NameVal") then
            local FoundFruit = FindFruitInInventory(v.NameVal.Value)
            if FoundFruit then
                return v -- Fruit found, return it and break loop
            end
        end
    end
    return nil -- nothing found return nil
end

local function TargetUntilDeath(TarChar : Model)
    local m1Tick = tick()
    local m1CD = 0.34
    while TarChar and CurrentFruitModel and Player.Character do
        if TarChar:FindFirstChild("Humanoid") then
            if TarChar.Humanoid.Health > 0 and Player.Character.Parent ~= nil then -- Until our death or targets death
                if TarChar:FindFirstChild("Torso") then
                    local BackPos = TarChar.Torso.Position + (-TarChar.Torso.CFrame.LookVector * 3.5)
                    Player.Character:PivotTo(CFrame.new(BackPos, TarChar.Torso.Position))
                end
                if tick() > m1Tick + m1CD then
                    m1Tick = tick()
                    CurrentFruitModel.ten:FireServer()
                end
            else
                break
            end
        else
            break
        end
        task.wait()
    end
end

-- // UI \\ --

local sliderVal = MainTab:Slider({
        Title = "Ship spam",
        Description = "",
        Default = 2,
        Min = 1,
        Max = 15
    }, 
    function(value)
        -- nothing
    end
)

MainTab:Button({
        Title = "Spawn Ships",
        ButtonName = "Spawn",
        Description = "",
    }, 
    function(v)
        local ShipVal = sliderVal:getValue()
        SpawnShips(ShipVal)
    end
)

MainTab:Button({
        Title = "GodMode",
        ButtonName = "Enable",
        Description = "",
    }, 
    function(v)
        GodMode()
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

-- // Loops \\ --

task.spawn(function()
    while task.wait() do
        -- AutoFarm
        if AFarmVal:getValue() and Player.Character then
            for i, v in pairs(Players:GetChildren()) do
                if not (v == Player) and AFarmVal:getValue() then
                    local CharPlr = v.Character
                    if CharPlr then
                        TargetUntilDeath(CharPlr)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Player.Character then
            if Player.Character:FindFirstChild("Humanoid") then
                CurrentFruitModel = FindEquippedFruit()
            end
        end
    end
end)

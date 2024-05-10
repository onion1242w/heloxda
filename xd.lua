--loadstring(game:HttpGet('https://raw.githubusercontent.com/onion1242w/whatidk/main/whadudhell.lua'))()
--loadstring(game:HttpGet('https://raw.githubusercontent.com/onion1242w/heloxda/main/xd.lua'))()

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
    task.spawn(function()
        for i = 1, Count do
            MarketplaceService:SignalPromptProductPurchaseFinished(Player.UserId, 1717407738, true)
            task.wait(0.4)
        end
    end)
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

local function LoopTargetYield(TarChar : Model, TimeToTarget : number)
    local TimeC = tick() + TimeToTarget
    repeat
        if Player.Character and TarChar and CurrentFruitModel then
            if TarChar:FindFirstChild("Torso") then
                local BackPos = TarChar.Torso.Position + (-TarChar.Torso.CFrame.LookVector * 3.5)
                Player.Character:PivotTo(CFrame.new(BackPos, TarChar.Torso.Position))
            end
        end
        task.wait()
    until (tick() > TimeC)
end

local function LoopAttack(TimeToTarget : number)
    local TimeC = tick() + TimeToTarget
    while tick() < TimeC and Player.Character and CurrentFruitModel do
        if Player.Character.Humanoid.Health > 0 and CurrentFruitModel then
            CurrentFruitModel.ten:FireServer()
        end
        task.wait(0.1)
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
                        local TimeToTarget = 1.3
                        task.spawn(LoopTargetYield, CharPlr, TimeToTarget)
                        task.spawn(LoopAttack, TimeToTarget)
                        task.wait(TimeToTarget)
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

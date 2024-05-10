--loadstring(game:HttpGet('https://raw.githubusercontent.com/onion1242w/whatidk/main/whadudhell.lua'))()
--loadstring(game:HttpGet('https://raw.githubusercontent.com/onion1242w/heloxda/main/xd.lua'))()

local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()

local Player = game.Players.LocalPlayer

local MarketplaceService = game:GetService("MarketplaceService")

local Window = UILib.new("Blox fruits but bad v0.0.1", Player.UserId, "!!")
local Category = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainButton = Category:Button("Main", "http://www.roblox.com/asset/?id=8395621517")

local MainTab = MainButton:Section("Main", "Left")

-- // Functions \\ --

local function SpawnShips(Count : number)
    task.defer(function()
        for i = 1, Count do
            MarketplaceService:SignalPromptProductPurchaseFinished(Player.UserId, 1717407738, true)
            task.wait(0.4)
        end
    end)
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
        print("spawnnship")
        SpawnShips(ShipVal)
    end
)

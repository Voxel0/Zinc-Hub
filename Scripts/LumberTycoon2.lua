local plr = game:GetService('Players').LocalPlayer.Character

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/dirt",true))()
local Table = {}
local window1 = Lib:CreateWindow("ZincHub | v1.0")
local window2 = Lib:CreateWindow("LocalPlayer")
local window3 = Lib:CreateWindow("Teleports")
local window4 = Lib:CreateWindow("Slot")
local window5 = Lib:CreateWindow("Items")
local window6 = Lib:CreateWindow("Credits")
window1:Button("Rejoin Game",function()
    local ts = game:GetService("TeleportService")

    local p = game:GetService("Players").LocalPlayer
    
     
    
    ts:Teleport(game.PlaceId, p)
end)
window2:Slider("WalkSpeed",{location = Table, min = 16, max = 64, default = 16, precise = true --[[ 0.00 instead of 0 ]], flag = "Slider"},function(s)
   game.Player.LocalPlayer.Character.Humanoid.Walkspeed = s
end)
   window2:Slider("JumpPower",{location = Table, min = 1, max = 64, default = 32, precise = true --[[ 0.00 instead of 0 ]], flag = "Slider"},function(j)
   game.Player.LocalPlayer.Character.Humanoid.JumpPower = j
end)

window3:Button("Woods R Us",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(265, 5, 57)
end)
window3:Button("Spawn",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(155, 5, 74)
end)
window3:Button("Volcano",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(-1585, 625, 1140)
end)
window3:Button("Palm Island",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(2549, 5, -42)
end)
window3:Button("Boxed Cars Store",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(509, 5.2, -1463)
end)
window3:Button("Blue Wood Cave",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(3581, -177, 430)
end)
window3:Button("Swamp",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(-1209, 138, -801)
end)
window3:Button("StrangeMan",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(1061, 20, 1131)
end)
window3:Button("Rukiryaxe Den",function ()
    plr.HumanoidRootPart.CFrame = CFrame.new(323, 49, 1930)
end)
window4:Button("Maxland",function ()
    for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
		if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
			base = v
			square = v.OriginSquare
			end
		end
	function makebase(pos)
		local Event = game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty
		Event:FireServer(base, pos)
		end
	spos = square.Position
	makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z))
	makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z))
	makebase(CFrame.new(spos.X, spos.Y, spos.Z + 40))
	makebase(CFrame.new(spos.X, spos.Y, spos.Z - 40))
	makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 40))
	makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 40))
	makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 40))
	makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 40))
	makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z))
	makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z))
	makebase(CFrame.new(spos.X, spos.Y, spos.Z + 80))
	makebase(CFrame.new(spos.X, spos.Y, spos.Z - 80))
--Corners--
	makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 80))
	makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 80))
	makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 80))
	makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 80))
--Corners--
	makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 80))
	makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 80))
	makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 40))
	makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 40))
	makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 40))
	makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 40))
	makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 80))
	makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 80))
end)
window6:Button("Main Developer - Voxel#1455",function ()

end)
window5:Button("AxeDupe",function ()
    local plr = game:service'Players'.LocalPlayer

function SafeRespawn()
    plr.Character.Head:Destroy()
end

function Dupe()
    SafeRespawn()
    for i,v in pairs(plr.Backpack:GetChildren()) do
        if v.Name == "Tool" then
            game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v,"Drop tool",plr.Character.Torso.CFrame * CFrame.new(0,5,0))
        end
    end
end

Dupe()
end)


window1:Bind("KeyBind",{location = Table, flag = "KeyBind", default = Enum.KeyCode.B},function() -- Automatically stops when the gui is removed
    print(Table["KeyBind"])
 end)

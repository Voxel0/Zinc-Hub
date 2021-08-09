local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GameLogic, CharTable, Trajectory
for I,V in pairs(getgc(true)) do
    if type(V) == "table" then
        if rawget(V, "gammo") then
            GameLogic = V
        end
    elseif type(V) == "function" then
        if debug.getinfo(V).name == "getbodyparts" then
            CharTable = debug.getupvalue(V, 1)
        elseif debug.getinfo(V).name == "trajectory" then
            Trajectory = V
        end
    end
    if GameLogic and CharTable and Trajectory then break end
end

local function Closest()
    local Max, Close = math.huge
    for I,V in pairs(Players:GetPlayers()) do
        if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and CharTable[V] then
            local Pos, OnScreen = Camera:WorldToScreenPoint(CharTable[V].head.Position)
            if OnScreen then
                local Dist = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if Dist < Max then
                    Max = Dist
                    Close = V
                end
            end
        end
    end
    return Close
end
local MT = getrawmetatable(game)
local __index = MT.__index
setreadonly(MT, false)
MT.__index = newcclosure(function(self, K)
    if not checkcaller() and GameLogic.currentgun and GameLogic.currentgun.data and (self == GameLogic.currentgun.barrel or tostring(self) == "SightMark") and K == "CFrame" then
        local CharChosen = (CharTable[Closest()] and CharTable[Closest()].head)
        if CharChosen then
            local _, Time = Trajectory(self.Position, Vector3.new(0, -workspace.Gravity, 0), CharChosen.Position, GameLogic.currentgun.data.bulletspeed)
            return CFrame.new(self.Position, CharChosen.Position + (Vector3.new(0, -workspace.Gravity / 2, 0)) * (Time ^ 2) + (CharChosen.Velocity * Time))
        end
    end
    return __index(self, K)
end)
setreadonly(MT, true)

local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ClientModules = ReplicatedFirst.ClientModules

local Old = ClientModules.Old

local framework = Old.framework

local network = require(framework.network)

local Table = coroutine.wrap(function(...)
	for _, Value in ipairs(getgc(true)) do
		if typeof(Value) == "table" and rawget(Value, "gammo") then
			return Value
		end
	end
end)()

local getbodyparts = coroutine.wrap(function(...)
	for _, Value in ipairs(getgc(false)) do
		if debug.getinfo(Value).name == "getbodyparts" then
			return Value
		end
	end
end)()

local GetClosestEnemyPlayer = function(Range, ...)
	local Player = nil
	for _, Value in ipairs(Players:GetPlayers()) do
		if Value ~= LocalPlayer and Value.Team ~= LocalPlayer.Team and LocalPlayer.Character then
			local BodyParts = getbodyparts(Value)
			if BodyParts then
				local Magnitude = math.floor((BodyParts.head.Position - LocalPlayer.Character.Head.Position).Magnitude)
				if Magnitude <= Range then
					Player = Value
					Range = Magnitude
				end
			end
		end
	end
	return Player
end

local KnifeEquipped = false
local GunEquipped = false
local Old = 0
local Range = 25

RunService.RenderStepped:Connect(function(...)
	if Table.currentgun then
		local ClosestEnemyPlayer = GetClosestEnemyPlayer(Range)
		if ClosestEnemyPlayer then
			if not KnifeEquipped and Table.currentgun.type ~= "KNIFE" then
				KnifeEquipped = true
				GunEquipped = false
				Old = Table.currentgun.gunnumber
				network:send("equip", 3)
			end
			network:send("knifehit", ClosestEnemyPlayer, tick(), getbodyparts(ClosestEnemyPlayer).head)
		else
			if not GunEquipped and Old ~= 0 then
				GunEquipped = true
				KnifeEquipped = false
				network:send("equip", Old)
			end
		end
	end
end)

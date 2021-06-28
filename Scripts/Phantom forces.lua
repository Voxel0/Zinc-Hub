
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
local function ClosestPlayer()
local closestPlayer=nil
local shortestDistance=math.huge
for _,a in pairs(game.Workspace.Players:GetChildren())do
if a.Name~=game.Players.LocalPlayer.Team.Name then
for _,b in pairs(a:GetChildren())do
if(b.Head.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude<shortestDistance then
closestPlayer=b
shortestDistance=(b.Head.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
end
end
end
end
return closestPlayer
end
local b=Vector3.new()
game.RunService.RenderStepped:Connect(function()
b=ClosestPlayer().HumanoidRootPart.Position
end)
local mt=getrawmetatable(game)
local oldNamecall=mt.__namecall
local oldIndex=mt.__index
setreadonly(mt,false)
mt.__namecall=newcclosure(function(...)
local method=getnamecallmethod()
local args={...}
if tostring(method)=="FireServer"and args[2]=="newgrenade"then
for i=1,#args[4]["frames"]do
if i~=1 then
args[4]["frames"][i]["p0"]=b
end
end
args[4]["blowuptime"]=0
end
return oldNamecall(unpack(args))
end)
setreadonly(mt,true)

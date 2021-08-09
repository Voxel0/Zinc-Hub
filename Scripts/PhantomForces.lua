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

--// Decompiled Code. 
  _G.infammo = false
_G.norecoil = false
_G.fastreload = false
_G.maxbulletpen = false
_G.infiniterange = false
_G.hidefromradar = false
_G.instantaim = false
_G.infnades = false
local GunModulesBackup = {}
local Gunmod = {}
local Gunmod2 = {}
local Gunmod3 = {}
local Gunmod4 = {}
local Gunmod5 = {}
local Gunmod6 = {}
local Gunmod7 = {}
local Gunmod8 = {}
local Gunmod9 = {}
local Gunmod10 = {}
local Gunmod11 = {}
local Gunmod12 = {}
local Gunmod13 = {}
local Gunmod14 = {}
local Gunmod15 = {}
local Gunmod16 = {}
local Gunmod17 = {}
local Gunmod18 = {}
local Gunmod19 = {}
local Gunmod20 = {}
local Gunmod21 = {}
local Gunmod22 = {}
local Gunmod23 = {}
local Gunmod24 = {}
local Gunmodfr = {}
_G.Speed = 16
_G.SpeedBackup = 16

-------------------------------------

local setbasewalkspeed;
local gunbobindex;
local stepfunction;
local isdeployed;

for i,v in next, getgc() do
  if type(v) == "function" then
      for i2,v2 in next, debug.getupvalues(v) do
          if type(v2) == "table" and rawget(v2, "setbasewalkspeed") then
              setbasewalkspeed = v2.setbasewalkspeed
          else
              if type(v2) == "table" and rawget(v2, "isdeployed") then
                  isdeployed = v2
              end
          end
      end
  end
end



spawn(function()
  repeat wait()
      setbasewalkspeed(_G.Speed, _G.Speed)
  until false
end)



local nade_amount = math.huge

local network;
local funcs;
local char;
local gamelogic;
local effects;

for i,v in next, getgc() do
   if type(v) == "function" then
       for i2,v2 in next, debug.getupvalues(v) do
           if type(v2) == "table" and rawget(v2, 'send') then
               network = v2;
           end
           if type(v2) == "table" and rawget(v2, 'add') then
               funcs = v2;
           end
           if type(v2) == "table" and rawget(v2, 'addgun') then
               char = v2;
           end
           if type(v2) == "table" and rawget(v2, 'gammo') then
               gamelogic = v2;
           end
           if type(v2) == "table" and rawget(v2, 'breakwindow') then
               effects = v2;
           end
       end
   end
end


spawn(function()
while wait() do
if _G.infnades then
    gamelogic.gammo = nade_amount
else
    gamelogic.gammo = 3
end
end
end)

spawn(function()
while wait() do
if _G.infnades then
    gamelogic.gammo = nade_amount
else
    gamelogic.gammo = 3
end
end
end)

spawn(function()
while wait() do
if _G.infnades then
    gamelogic.gammo = nade_amount
else
    gamelogic.gammo = 3
end
end
end)


--------------------------------------------------------

for i,v in pairs(game.ReplicatedStorage.GunModules:GetChildren()) do
    local v1 = require(v)
    print(v1.magsize)
    Gunmod[i] = v1.magsize
    GunModulesBackup[1] = Gunmod

    Gunmod2[i] = v1.sparerounds
    GunModulesBackup[2] = Gunmod2

---------------------------------------------

    Gunmod3[i] = v1.camkickmin
    GunModulesBackup[3] = Gunmod3

    Gunmod4[i] = v1.camkickmax
    GunModulesBackup[4] = Gunmod4

    Gunmod5[i] = v1.aimcamkickmin
    GunModulesBackup[5] = Gunmod5

    Gunmod6[i] = v1.aimcamkickmax
    GunModulesBackup[6] = Gunmod6

    Gunmod7[i] = v1.aimtranskickmin
    GunModulesBackup[7] = Gunmod7

    Gunmod8[i] = v1.aimtranskickmax
    GunModulesBackup[8] = Gunmod8

    Gunmod9[i] = v1.transkickmin
    GunModulesBackup[9] = Gunmod9

    Gunmod10[i] = v1.transkickmax
    GunModulesBackup[10] = Gunmod10

    Gunmod11[i] = v1.rotkickmin
    GunModulesBackup[11] = Gunmod11

    Gunmod12[i] = v1.rotkickmax
    GunModulesBackup[12] = Gunmod12

    Gunmod13[i] = v1.aimrotkickmin
    GunModulesBackup[13] = Gunmod13

    Gunmod14[i] = v1.aimrotkickmax
    GunModulesBackup[14] = Gunmod14

    Gunmod15[i] = v1.hipfirespread
    GunModulesBackup[15] = Gunmod15

    Gunmod16[i] = v1.hipfirespreadrecover
    GunModulesBackup[16] = Gunmod16

    Gunmod17[i] = v1.crossdumper
    GunModulesBackup[17] = Gunmod17

-----------------------------------------

    Gunmod18[i] = v1.range0
    GunModulesBackup[18] = Gunmod18

    Gunmod19[i] = v1.range1
    GunModulesBackup[19] = Gunmod19

    Gunmod20[i] = v1.hideflash
    GunModulesBackup[20] = Gunmod20

    Gunmod21[i] = v1.hideminimap
    GunModulesBackup[21] = Gunmod21

    Gunmod22[i] = v1.hiderange
    GunModulesBackup[22] = Gunmod22

    Gunmod23[i] = v1.aimspeed
    GunModulesBackup[23] = Gunmod23

    Gunmod24[i] = v1.equipspeed
    GunModulesBackup[24] = Gunmod24

    Gunmodfr[i] = v1.firerate
    GunModulesBackup[100] = Gunmodfr
end
print(GunModulesBackup[1]["1"])

local V3 = Vector3.new()
spawn(function()
while wait() do
    for i,v in pairs(game.ReplicatedStorage.GunModules:GetChildren()) do
        local v1 = require(v)
        if _G.infammo then
            v1.magsize = math.huge
            v1.sparerounds = math.huge
        else
            v1.magsize = GunModulesBackup[1][i]
            v1.sparerounds = GunModulesBackup[2][i]
        end
        if _G.norecoil then
            v1.camkickmin = V3
            v1.camkickmax = V3
            v1.aimcamkickmin = V3
            v1.aimcamkickmax = V3
            v1.aimtranskickmin = V3
            v1.aimtranskickmax = V3
            v1.transkickmin = V3
            v1.transkickmax = V3
            v1.rotkickmin = V3
            v1.rotkickmax = V3
            v1.aimrotkickmin = V3
            v1.aimrotkickmax = V3
            v1.hipfirespread = 0
            v1.hipfirespreadrecover = math.huge
            v1.crossdumper = math.huge
        else
            v1.camkickmin = GunModulesBackup[3][i]
            v1.camkickmax = GunModulesBackup[4][i]
            v1.aimcamkickmin = GunModulesBackup[5][i]
            v1.aimcamkickmax = GunModulesBackup[6][i]
            v1.aimtranskickmin = GunModulesBackup[7][i]
            v1.aimtranskickmax = GunModulesBackup[8][i]
            v1.transkickmin = GunModulesBackup[9][i]
            v1.transkickmax = GunModulesBackup[10][i]
            v1.rotkickmin = GunModulesBackup[11][i]
            v1.rotkickmax = GunModulesBackup[12][i]
            v1.aimrotkickmin = GunModulesBackup[13][i]
            v1.aimrotkickmax = GunModulesBackup[14][i]
            v1.hipfirespread = GunModulesBackup[15][i]
            v1.hipfirespreadrecover = GunModulesBackup[16][i]
            v1.crossdumper = GunModulesBackup[17][i]
        end
        if _G.infiniterange then
            v1.range0 = 2048
            v1.range1 = 2048
        else
            v1.range0 = GunModulesBackup[18][i]
            v1.range1 = GunModulesBackup[19][i]
        end
        if _G.hidefromradar then
            v1.hideflash = true
            v1.hideminimap = true
            v1.hiderange = 0
        else
            v1.hideflash = GunModulesBackup[20][i]
            v1.hideminimap = GunModulesBackup[21][i]
            v1.hiderange = GunModulesBackup[22][i]
        end
        if _G.instantaim then
            v1.aimspeed = 10000
            v1.equipspeed = 10000
        else
            v1.aimspeed = GunModulesBackup[23][i]
            v1.equipspeed = GunModulesBackup[24][i]
        end
    end
end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiwi-i/wallys-ui-fork/master/lib.lua", true))()
local GMods = library:CreateWindow('leifs Cheaky Cheater >:)')

GMods:Toggle("Inf Ammo", {default = false}, function(state)
    _G.infammo = state
end)

GMods:Toggle("No Recoil", {default = false},function(state)
    _G.norecoil = state
end)

GMods:Toggle("Fast Reload", {default = false}, function(state)
    _G.fastreload = state
end)

GMods:Toggle("Inf Range", {default = false}, function(state)
    _G.infiniterange = state
end)

GMods:Toggle("Hide From Radar", {default = false}, function(state)
    _G.hidefromradar = state
end)

GMods:Toggle("Insta Aim and Equip", {default = false}, function(state)
    _G.instantaim = state
end)

GMods:Section('Possibly No Damage')

local box = GMods:Box('Firerate All Weapons', {
    flag = "ws";
    type = 'number';
}, function(new, old, enter)
    print(new, old, enter)
    for i,v in pairs(game.ReplicatedStorage.GunModules:GetChildren()) do
        v1 = require(v)
        v1.firerate = tonumber(new)
    end
end)
local b = GMods:Button("Restore Firerate", function()
for i,v in pairs(game.ReplicatedStorage.GunModules:GetChildren()) do
        v1 = require(v)
        v1.firerate = GunModulesBackup[100][i]
    end
end)

Other:Toggle("Infinite Granades", {default = false}, function(state)
    _G.infnades = state
end)

Other:Box('Change Walkspeed', {
    flag = "ws";
    type = 'number';
}, function(new, old, enter)
    print(new, old, enter)
    _G.Speed = new
end)
Other:Button("Restore Walkspeed", function()
for i,v in pairs(game.ReplicatedStorage.GunModules:GetChildren()) do
        _G.Speed = _G.SpeedBackup
    end
end)

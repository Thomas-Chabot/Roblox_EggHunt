local replStorage = game:GetService ("ReplicatedStorage");
local events      = replStorage:FindFirstChild("RemoteEvents").Eskimo;
local questEvents = events.Quest;
local pickaxeEvts = events.Pickaxe;

local request = questEvents.Request;
local accept  = questEvents.Accept;

local spawnPickaxe = pickaxeEvts.Spawn;

accept.OnServerEvent:connect (function (player)
	spawnPickaxe:FireClient (player);
end)
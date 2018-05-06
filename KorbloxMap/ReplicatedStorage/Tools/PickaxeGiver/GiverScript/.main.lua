local replStorage = game:GetService ("ReplicatedStorage");
local modules     = replStorage:FindFirstChild ("Modules");
local events      = replStorage:FindFirstChild ("RemoteEvents");
local tools       = replStorage:FindFirstChild("Tools");

local Giver       = require (modules:FindFirstChild ("Giver"));
local count       = require (modules:FindFirstChild ("Count"));

local pickedUp    = events.Eskimo.Pickaxe.PickedUp;

local Pickaxe     = tools:FindFirstChild("Pickaxe");

local giver = Giver.new (script.Parent, Pickaxe, {
	canGive = function (hit, player)
		if (not player) then return false end;
		
		local backpack  = player:FindFirstChild ("Backpack");
		local character = player.Character;
		
		return count (character, Pickaxe.Name) + count (backpack, Pickaxe.Name) < 1;
	end
});

giver.Activated.Event:connect (function (_, player)
	if (not player) then return end
	pickedUp:FireClient (player);
end)
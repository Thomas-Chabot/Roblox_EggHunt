local replStorage = game:GetService ("ReplicatedStorage");
local tools       = replStorage.Tools;
local events      = replStorage:FindFirstChild("RemoteEvents").Eskimo;
local questEvents = events.Quest;
local pickaxeEvts = events.Pickaxe;

local pickaxeDug   = pickaxeEvts.Dug;
local pickaxeStart = pickaxeEvts.Start;
local pickaxeEnd   = pickaxeEvts.End;
local pickPickedUp = pickaxeEvts.PickedUp;
local arrowMoved   = pickaxeEvts.ArrowMoved;
local gameWon      = pickaxeEvts.Won;
local wallDamaged  = pickaxeEvts.Damaged;

local minigames = require (script.Minigames);
local Giver     = require (script.Giver);

local pickaxe = tools.Pickaxe;
local giver   = Giver.new (pickaxe);

pickaxeStart.OnServerEvent:connect (function (player)
	minigames.init (player);
end)

pickaxeDug.OnServerEvent:connect (function (player, positions)
	if (not minigames.get (player)) then
		return;
	end
	
	print ("Player dug at: ");
	table.foreach(positions, print);
	
	local valid = minigames.get (player):pick (positions);
	print (valid);
	if (valid) then
		wallDamaged:FireClient (player);
	end
end)

pickPickedUp.OnServerEvent:connect (function (player)
	giver:give (player);
end)

minigames.GameWin.Event:connect (function (player)
	gameWon:FireClient (player);
end)
minigames.GameOver.Event:connect (function (player)
	print ("GAME OVER");
	pickaxeEnd:FireClient (player);
end)
minigames.PositionChanged.Event:connect (function (position, player)
	arrowMoved:FireClient (player, position);
end)
local replStorage = game:GetService ("ReplicatedStorage");
local events      = replStorage:FindFirstChild ("RemoteEvents");
local request     = events.Eskimo.Quest.Request;

function connectEvent (clickDetector)
	clickDetector.MouseClick:connect (function (player)
		request:FireClient (player);
	end)
end

function findClickDetectors ()
	local results = { };
	for _,obj in pairs (script.Parent:GetDescendants()) do
		if (obj:IsA("ClickDetector")) then
			table.insert (results, obj);
		end
	end
	return results;
end

function init ()
	local clickDetectors = findClickDetectors ();
	for _,detector in pairs (clickDetectors) do
		connectEvent (detector);
	end
end

init ();
-- Controls running the Snowflake egg.
local servStorage = game:GetService("ServerStorage");
local modules     = servStorage:FindFirstChild("Modules");

local debounce    = require (modules.Debounce);
local Awarding    = require (modules.EggAwarding);

local egg = script.Parent;
local eggName = "Frozen Gem Egg";
local badgeId = 0;

local EggAward = Awarding.new (egg, eggName, badgeId);

local awarded = false;
function onTouched (hit)
	if (awarded) then return end
	
	local player = hit and hit.Parent and game.Players:GetPlayerFromCharacter(hit.Parent);
	if (not player) then return end
	
	awarded = true;
	EggAward:award (player);
end

-- Note: We want to check on *every* part of the egg, in case they just barely get it
--       May just get the sides, for example
local touched = debounce (onTouched);
for _,part in pairs (egg:GetChildren()) do
	if (part:IsA("BasePart")) then
		part.Touched:connect (touched);
	end
end
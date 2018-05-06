local serverStorage = game:GetService ("ServerStorage");
local eggs          = serverStorage:FindFirstChild ("Eggs");
local drop          = eggs and eggs:FindFirstChild ("Drop");
if (not drop) then return end -- If we don't have drop eggs

local EggDropper = require (script.EggDropper);
local droppers = { };

-- Initialize the droppers
for _,egg in pairs (drop:GetChildren ()) do
	droppers [egg.Name] = EggDropper.new (egg);
end
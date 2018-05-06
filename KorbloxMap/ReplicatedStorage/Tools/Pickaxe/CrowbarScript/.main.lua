-------- OMG HAX

r = game:service("RunService")
debris = game:GetService("Debris")
local replStorage = game:GetService("ReplicatedStorage");

local touchMod = require (script.TouchMod)

sword = script.Parent.Handle
Tool = script.Parent

local iceBlock = workspace.IceBlockDoor -- NOTE TO SELF THIS IS THE ICE BLOCK

local events    = replStorage:WaitForChild("RemoteEvents");
local eskimo    = events.Eskimo;
local event     = eskimo.Pickaxe.Dug;

local SmashSound = Instance.new("Sound")
SmashSound.SoundId = "http://www.roblox.com/asset/?id=21433696"
SmashSound.Parent = sword
SmashSound.Volume = .7

local SmashSound2 = Instance.new("Sound")
SmashSound2.SoundId = "http://www.roblox.com/asset/?id=21433711"
SmashSound2.Parent = sword
SmashSound2.Volume = .7

local sounds = {SmashSound, SmashSound2}

local UnsheathSound = Instance.new("Sound")
UnsheathSound.SoundId = "rbxasset://sounds\\unsheath.wav"
UnsheathSound.Parent = sword
UnsheathSound.Volume = 1


function blow(hit)
	if (Tool.Enabled) then return end -- only damages on a swing
	local tab = touchMod:getTouching (sword)
	local intersections = { };
	
	for _,details in pairs (tab) do
		if (details.touching == iceBlock or details.part == iceBlock) then
			for _,intersect in pairs (details.intersections) do
				table.insert (intersections, intersect)
			end
		end
	end
	
	if (#intersections == 0) then return end
	event:FireServer (intersections)
end


function tagHumanoid(humanoid, player)
	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = player
	creator_tag.Name = "creator"
	creator_tag.Parent = humanoid
end

function untagHumanoid(humanoid)
	if humanoid ~= nil then
		local tag = humanoid:findFirstChild("creator")
		if tag ~= nil then
			tag.Parent = nil
		end
	end
end


function attack()
	local s = sounds[math.random(1,#sounds)]
	s.Pitch = .9 + (math.random() * .2)
	s.Volume = .7 + (math.random() * .3)
	s:Play()

	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Slash"
	anim.Parent = Tool
end



function swordUp()
	Tool.GripForward = Vector3.new(-1,0,0)
	Tool.GripRight = Vector3.new(0,1,0)
	Tool.GripUp = Vector3.new(0,0,1)
end

function swordOut()
	Tool.GripForward = Vector3.new(0,0,1)
	Tool.GripRight = Vector3.new(0,-1,0)
	Tool.GripUp = Vector3.new(-1,0,0)
end

function swordAcross()
	-- parry
end


Tool.Enabled = true
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil then
		print("Humanoid not found")
		return 
	end


	attack()



	wait(.5)

	Tool.Enabled = true
end


function onEquipped()
	UnsheathSound:play()
end


script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)


connection = sword.Touched:connect(blow)
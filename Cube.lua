-- LocalScript inside StarterPlayer > StarterPlayerScripts
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local TARGET_NAME = "the cube of death(i heard it kills)"

local function applyESP(object)
	-- If it's the actual killing part or the model containing it
	if (object:IsA("BasePart") or object:IsA("Model")) and not object:FindFirstChild("CubeESP") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "CubeESP"
		highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Neon Red
		highlight.FillTransparency = 0.4
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White
		highlight.OutlineTransparency = 0
		highlight.Adornee = object
		highlight.Parent = object
	end
end

-- Deep scan function that searches nested game folders
local function searchForCube(root)
	for _, child in ipairs(root:GetChildren()) do
		if child.Name:lower() == TARGET_NAME or child.Name:find("cube") and child.Name:find("death") then
			applyESP(child)
		end
		-- Search deeper into map structures
		searchForCube(child)
	end
end

-- Continuous passive check loop to fight map streaming issues
task.spawn(function()
	while task.wait(2) do 
		-- Check the classic Arena folder if it exists, otherwise scan entire Workspace
		local arena = Workspace:FindFirstChild("Arena")
		if arena then
			searchForCube(arena)
		else
			searchForCube(Workspace)
		end
	end
end)

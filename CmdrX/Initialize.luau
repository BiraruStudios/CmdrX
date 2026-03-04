local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CreateGui = require(script.Parent.CreateGui)

-- Handles initial preparation of the game server-side.
return function(cmdrx)
	local ReplicatedRoot, RemoteFunction, RemoteEvent

	local function Create(class, name, parent)
		local object = Instance.new(class)
		object.Name = name
		object.Parent = parent or ReplicatedRoot

		return object
	end

	ReplicatedRoot = script.Parent.CmdrXClient
	ReplicatedRoot.Parent = ReplicatedStorage

	RemoteFunction = Create("RemoteFunction", "CmdrXFunction")
	RemoteEvent = Create("RemoteEvent", "CmdrXEvent")

	Create("Folder", "Commands")
	Create("Folder", "Types")

	script.Parent.Shared.Parent = ReplicatedRoot

	cmdrx.ReplicatedRoot = ReplicatedRoot
	cmdrx.RemoteFunction = RemoteFunction
	cmdrx.RemoteEvent = RemoteEvent

	cmdrx:RegisterTypesIn(script.Parent.BuiltInTypes)

	script.Parent.BuiltInTypes:Destroy()
	script.Parent.BuiltInCommands.Name = "Server commands"

	if StarterGui:FindFirstChild("CmdrX") == nil then
		CreateGui()
	end
end

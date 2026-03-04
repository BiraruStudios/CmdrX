local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))

if RunService:IsClient() == false then
	error(
		"[CmdrX] Server scripts cannot require the client library. Please require the server library from the server to use CmdrX in your own code."
	)
end

--[=[
	@class CmdrXClient
	@client
	The CmdrX client singleton and entry point.
]=]

--[=[
	@within CmdrXClient
	@prop Registry Registry
	@readonly
	Refers to the current command Registry.
]=]

--[=[
	@within CmdrXClient
	@prop Dispatcher Dispatcher
	@readonly
	Refers to the current command Dispatcher.
]=]

--[=[
	@within CmdrXClient
	@prop Util Util
	@readonly
	Refers to a table containing many useful utility functions.
]=]

--[=[
	@within CmdrXClient
	@prop Enabled boolean
	@readonly
	Whether or not CmdrX is enabled (will show via the defined activation keys). Use [`CmdrXClient:SetEnabled`](#SetEnabled) to change.
]=]

--[=[
	@within CmdrXClient
	@prop PlaceName string
	@readonly
	The current place name, displayed on the interface. Use [`CmdrXClient:SetPlaceName`](#SetPlaceName) to change.
]=]

--[=[
	@within CmdrXClient
	@prop ActivationKeys { [Enum.KeyCode] = true }
	@readonly
	The list of key codes that will show or hide CmdrX. Use [`CmdrXClient:SetActivationKeys`](#SetActivationKeys) to change.
]=]

local CmdrX
do
	CmdrX = setmetatable({
		ReplicatedRoot = script,
		RemoteFunction = script:WaitForChild("CmdrXFunction"),
		RemoteEvent = script:WaitForChild("CmdrXEvent"),
		ActivationKeys = { [Enum.KeyCode.F2] = true },
		Enabled = true,
		MashToEnable = false,
		ActivationUnlocksMouse = false,
		HideOnLostFocus = true,
		PlaceName = "CmdrX",
		Util = Util,
		Events = {},
	}, {
		-- This sucks, and may be redone or removed
		-- Proxies dispatch methods on to main CmdrX object
		__index = function(self, k)
			local r = self.Dispatcher[k]
			if r and type(r) == "function" then
				return function(_, ...)
					return r(self.Dispatcher, ...)
				end
			end
		end,
	})

	CmdrX.Registry = require(Shared.Registry)(CmdrX)
	CmdrX.Dispatcher = require(Shared.Dispatcher)(CmdrX)
end

if StarterGui:WaitForChild("CmdrX") and wait() and Player:WaitForChild("PlayerGui"):FindFirstChild("CmdrX") == nil then
	StarterGui.CmdrX:Clone().Parent = Player.PlayerGui
end

local Interface = require(script.CmdrXInterface)(CmdrX)

--[=[
	Sets the key codes that will used to show or hide CmdrX.

	@within CmdrXClient
]=]
function CmdrX:SetActivationKeys(keys: { Enum.KeyCode })
	self.ActivationKeys = Util.MakeDictionary(keys)
end

--[=[
	Sets the place name label on the interface. This is useful for a quick way to tell what game you're playing in a universe game.

	@within CmdrXClient
]=]
function CmdrX:SetPlaceName(name: string)
	self.PlaceName = name
	Interface.Window:UpdateLabel()
end

--[=[
	Sets whether or not CmdrX can be shown via the defined activation keys. Useful for when you want users to opt-in to show the console, for instance in a settings menu.

	@within CmdrXClient
]=]
function CmdrX:SetEnabled(enabled: boolean)
	self.Enabled = enabled
end

--[=[
	Sets if activation will free the mouse.

	@within CmdrXClient
]=]
function CmdrX:SetActivationUnlocksMouse(enabled: boolean)
	self.ActivationUnlocksMouse = enabled
end

--[=[
	Shows the CmdrX window. Does nothing if CmdrX isn't enabled.

	@within CmdrXClient
]=]
function CmdrX:Show()
	if not self.Enabled then
		return
	end

	Interface.Window:Show()
end

--[=[
	Hides the CmdrX window.

	@within CmdrXClient
]=]
function CmdrX:Hide()
	Interface.Window:Hide()
end

--[=[
	Toggles the CmdrX window. Does nothing if CmdrX isn't enabled.

	@within CmdrXClient
]=]
function CmdrX:Toggle()
	if not self.Enabled then
		self:Hide()
		return
	end

	Interface.Window:SetVisible(not Interface.Window:IsVisible())
end

--[=[
	Enables the "Mash to open" feature.
	This feature, when enabled, requires the activation key to be pressed 5 times within a second to [enable](#SetEnabled) CmdrX.
	This may be helpful to guard against mispresses from opening the window, for example.

	@within CmdrXClient
]=]
function CmdrX:SetMashToEnable(enabled: boolean)
	self.MashToEnable = enabled

	if enabled then
		self:SetEnabled(false)
	end
end

--[=[
	Sets the hide on 'lost focus' feature.
	This feature, which is enabled by default, will cause CmdrX to [hide](#Hide) when the user clicks off the window.

	@within CmdrXClient
]=]
function CmdrX:SetHideOnLostFocus(enabled: boolean)
	self.HideOnLostFocus = enabled
end

--[=[
	Sets the [network event handler](/docs/networkeventhandlers) for a certain event type.

	@within CmdrXClient
]=]
function CmdrX:HandleEvent(name: string, callback: (...any) -> ())
	self.Events[name] = callback
end

-- "Only register when we aren't in studio because don't want to overwrite what the server portion did"
-- This is legacy code which predates Accurate Play Solo (which is now the only way to test in studio), this code will never run.
if RunService:IsServer() == false then
	CmdrX.Registry:RegisterTypesIn(script:WaitForChild("Types"))
	CmdrX.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end

-- Hook up event listener
CmdrX.RemoteEvent.OnClientEvent:Connect(function(name, ...)
	if CmdrX.Events[name] then
		CmdrX.Events[name](...)
	end
end)

require(script.DefaultEventHandlers)(CmdrX)

return CmdrX

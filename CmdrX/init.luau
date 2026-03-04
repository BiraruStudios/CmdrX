local RunService = game:GetService("RunService")
local Util = require(script.Shared:WaitForChild("Util"))

if RunService:IsServer() == false then
	error(
		"[CmdrX] Client scripts cannot require the server library. Please require the client library from the client to use CmdrX in your own code."
	)
end

--[=[
	@class CmdrX
	@server

	The CmdrX server singleton and entry point.
]=]

--[=[
	@within CmdrX
	@prop Registry Registry
	@readonly
	Refers to the current command Registry.
]=]

--[=[
	@within CmdrX
	@prop Dispatcher Dispatcher
	@readonly
	Refers to the current command Dispatcher.
]=]

--[=[
	@within CmdrX
	@prop Util Util
	@readonly
	Refers to a table containing many useful utility functions.
]=]

local CmdrX
do
	CmdrX = setmetatable({
		ReplicatedRoot = nil,
		RemoteFunction = nil,
		RemoteEvent = nil,
		Util = Util,
		DefaultCommandsFolder = script.BuiltInCommands,
	}, {
		__index = function(self, k)
			local r = self.Registry[k]
			if r and type(r) == "function" then
				return function(_, ...)
					return r(self.Registry, ...)
				end
			end
		end,
	})

	CmdrX.Registry = require(script.Shared.Registry)(CmdrX)
	CmdrX.Dispatcher = require(script.Shared.Dispatcher)(CmdrX)

	require(script.Initialize)(CmdrX)
end

-- Handle command invocations from the clients.
CmdrX.RemoteFunction.OnServerInvoke = function(player, text, options)
	if #text > 10000 then
		return "Input too long"
	end

	return CmdrX.Dispatcher:EvaluateAndRun(text, player, options)
end

return CmdrX

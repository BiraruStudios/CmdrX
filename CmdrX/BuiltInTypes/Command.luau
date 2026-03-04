local Util = require(script.Parent.Parent.Shared.Util)

return function(cmdrx)
	local commandType = {
		Transform = function(text)
			local findCommand = Util.MakeFuzzyFinder(cmdrx:GetCommandNames())

			return findCommand(text)
		end,

		Validate = function(commands)
			return #commands > 0, "No command with that name could be found."
		end,

		Autocomplete = function(commands)
			return commands
		end,

		Parse = function(commands)
			return commands[1]
		end,
	}

	cmdrx:RegisterType("command", commandType)
	cmdrx:RegisterType("commands", Util.MakeListableType(commandType))
end

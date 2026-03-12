local version = "v1.13.0"

return {
	Name = "version",
	Args = {},
	Description = "Shows the current version of CmdrX",
	Group = "DefaultDebug",

	ClientRun = function()
		return ("CmdrX Version %s"):format(version)
	end,
}

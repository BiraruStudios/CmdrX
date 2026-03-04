local Util = require(script.Parent.Parent.Shared.Util)

local storedKeyType = {
	Validate = function(text)
		if text:match("^https?://.+$") then
			return true
		end

		return false, "URLs must begin with http:// or https://"
	end,

	Parse = function(text)
		return text
	end,
}

return function(cmdrx)
	cmdrx:RegisterType("url", storedKeyType)
	cmdrx:RegisterType("urls", Util.MakeListableType(storedKeyType))
end

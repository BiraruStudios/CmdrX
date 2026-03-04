return function(registry)
	registry:RegisterType(
		"mathOperator",
		registry.CmdrX.Util.MakeEnumType("Math Operator", {
			{
				Name = "+",
				Perform = function(a, b)
					return a + b
				end,
			},
			{
				Name = "-",
				Perform = function(a, b)
					return a - b
				end,
			},
			{
				Name = "*",
				Perform = function(a, b)
					return a * b
				end,
			},
			{
				Name = "/",
				Perform = function(a, b)
					return a / b
				end,
			},
			{
				Name = "**",
				Perform = function(a, b)
					return a ^ b
				end,
			},
			{
				Name = "%",
				Perform = function(a, b)
					return a % b
				end,
			},
		})
	)
end

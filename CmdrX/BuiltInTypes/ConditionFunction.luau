return function(registry)
	registry:RegisterType("conditionFunction", registry.CmdrX.Util.MakeEnumType("ConditionFunction", { "startsWith" }))
end

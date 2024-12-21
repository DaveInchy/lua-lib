-- import(URL: string)
return function(URL: string)

    local Http = game:GetService("HttpService")
    Http.HttpEnabled = true

    local m = Instance.new("ModuleScript")
    m.Parent = game:GetService("Selection"):Get()[1] or game:GetService("ServerScriptService")
    m.Name = `{URL:match( "([^/]+)$" )}`
    m.Source = Http:GetAsync(`{URL}`)
    m.Parent = game:GetService("ReplicatedStorage");

    return require(m);
end
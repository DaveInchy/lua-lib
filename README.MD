# Lua-Lib
## How to download scripts to your ROBLOX games?
Input this in your command bar in Roblox Studio and press Enter, the Instance that you had selected inside Studio will now have your Script inside.
```:lua
# here is where you fill out the script you want to download
local URL = ""

local Http = game:GetService("HttpService")
local HttpEnabled = Http.HttpEnabled
Http.HttpEnabled = true
local m = Instance.new("ModuleScript")
m.Parent = game:GetService("Selection"):Get()[1] or game:GetService("ServerScriptService")
m.Name = `{URL:match( "([^/]+)$" )}`
m.Source = Http:GetAsync(`{URL}`)
game:GetService("Selection"):Set({m})
Http.HttpEnabled = HttpEnabled
```
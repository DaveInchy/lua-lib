# Lua-Lib
## How to download scripts to your ROBLOX games?
Input this in your command bar in Roblox Studio and press Enter, the Instance that you had selected inside Studio will now have your Script inside.
```:lua
--[[
    Here is where you fill out the script you want to download
]]--
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

or

```
local URL = "https://raw.githubusercontent.com/DaveInchy/lua-lib/refs/heads/master/src/import.luau"

local Http = game:GetService("HttpService")
local HttpEnabled = Http.HttpEnabled
Http.HttpEnabled = true
local m = Instance.new("ModuleScript")
m.Parent = game:GetService("Selection"):Get()[1] or game:GetService("ServerScriptService")
m.Name = `{URL:match( "([^/]+)$" )}`
m.Source = Http:GetAsync(`{URL}`)
m.Parent = game:GetService("ReplicatedStorage");
Http.HttpEnabled = HttpEnabled
```
and then use it like this (for example):
```
local import = require(game.ReplicatedStorage['import.luau']);

local Promise = import("https://raw.githubusercontent.com/evaera/roblox-lua-promise/master/lib/init.lua");
local useState = import("https://raw.githubusercontent.com/DaveInchy/lua-lib/refs/heads/master/src/hooks/useState.luau")

local isGud = useState(true, "isGud");
local count = useState(0, "count");

isGud.update:Connect(function(value)
    local Update = Promise.new(function(res, rej)
        isGud.set(not isGud.get());

        count.set(count.get()+1);
        if count.get() >= 10 then
            rej(`Max times tripping over reached. Stopping Execution`)
        end

        res(isGud.get())
    end):catch(function(err)
        warn(`{err}`);
    end)
    print(`tripping over => {Update}`);
end)

isGud.set(false);
```
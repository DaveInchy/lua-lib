return function(initial, player: Player, name: string?): {get: () -> any, set: (state: any) -> any, object: ValueBase}

	local refObject = {}

	function refObject.create(valueType)
		local instance = Instance.new(valueType)
		return instance;
	end

	local state = initial;
	local object = refObject;
	local valueType = "StringValue";
	local folder = require(game.ReplicatedStorage.Functions.getLeaderStats)(player)

	local encodeJSON = function(data: any): string
		local http = game:GetService("HttpService");
		return http:JSONEncode(data);
	end

	if typeof(initial) == "table" then
		local http = game:GetService("HttpService");
		local str = http:JSONEncode(initial);
		valueType = "JSONValue"
		object = object.create("StringValue");
		object.Value = str;

	elseif typeof(initial) == "boolean" then
		valueType = "BoolValue"
		object = object.create(valueType);
		object.Value = initial;

	elseif typeof(initial) == "string" then
		valueType = "StringValue"
		object = object.create(valueType);
		object.Value = initial;

	elseif typeof(initial) == "number" then
		valueType = "NumberValue"
		object = object.create(valueType);
		object.Value = initial;

	elseif typeof(initial) == "Instance" then
		valueType = "ObjectValue"
		object = object.create(valueType);
		object.Value = initial;

	elseif typeof(initial) == "CFrame" then
		valueType = "CFrameValue"
		object = object.create(valueType);
		object.Value = initial;

	elseif typeof(initial) == "Vector3" then
		valueType = "Vector3Value"
		object = object.create(valueType);
		object.Value = initial;

	else
		warn("Error: Couldn't tell what type of data is.")
		return {get=nil,set=nil,object=nil};
	end

	local Parent = player or nil;

	assert(Parent ~= nil, "There was no player type to create the leaderstats folder to bind the realtime state to")

	object.Parent = folder;
	object.Name = name or "Unknown"

	if folder:FindFirstChild(`{name or "unknown"}`) then

		object = folder:FindFirstChild(`{name or "unknown"}`)

	else

		object.Parent = folder;
		object.Name = name or "Unknown"

	end

	local function set(new): any
		state = new;
		if valueType == "JSONValue" then
			local json = encodeJSON(new)
			object.Value = json;
		else
			object.Value = new;
		end
		return state;
	end

	local function get(): any
		if valueType == "JSONValue" then
			local json = object.Value
			local data = http:JSONDecode(json)
			return data
		else
			return object.Value;
		end
	end

	return {["get"] = get, ["set"] = set, ['object'] = object, ['update'] = object.Changed}
end
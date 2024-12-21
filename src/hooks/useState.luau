return function(initial, name: string?): {get: () -> any, set: (state: any) -> any, object: ValueBase}

	local refObject = {}

	function refObject.create(valueType: "NumberValue" | "StringValue" | "ObjectValue" | "BoolValue")
		local instance = Instance.new(valueType)
		return instance;
	end

	local state = initial;
	local object = refObject;
	local valueType = "StringValue";

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

	local Parent = (script.Parent:FindFirstAncestorWhichIsA("Player") or script.Parent:FindFirstAncestorWhichIsA("GuiBase") or script.Parent:FindFirstAncestorWhichIsA("BasePlayerGui") or script.Parent:FindFirstAncestorWhichIsA("Actor") or script.Parent:FindFirstAncestorWhichIsA("Model") or script.Parent:FindFirstAncestorWhichIsA("ModuleScript")) or script.Parent

	assert(Parent ~= nil, "There was no parent type to create the Values folder to bind the realtime state to")

	if not Parent:FindFirstChild("Values") then
		local folder = Instance.new("Folder", Parent)
		folder.Name = "Values"
	end

	if Parent.Values:FindFirstChild(`{name or "unknown"}`) then

		object = Parent.Values:FindFirstChild(`{name or "unknown"}`)

	else

		object.Parent = Parent.Values;
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
		return state
	end
	return {["get"] = get, ["set"] = set, object = object, update = object.Changed}
end
return function(player: Player)
	local leaderstats = player:FindFirstChild("leaderstats");
	if not leaderstats then
		leaderstats = Instance.new("Folder");
		leaderstats.Parent = player;
		leaderstats.Name = "leaderstats"
	end
	return leaderstats
end
--[[
	scriptifyy // 2024
	converts unix timestamp to a strings.
]]--

local intervals = {
	{31536000, "%i years ago"};
	{2592000, "%i months ago"};
	{604800, "%i weeks ago"};
	{172800, "%i days ago"};
	{86400, "A day ago"};
	{7200, "An hour ago"};
	{3600, "%i hours ago"};
	{120, "A minute ago"};
	{60, "%i seconds ago"};
	{10, "%i seconds ago"};
	{1, "Just now"};
};

local divisors = {31536000, 2592000, 604800, 86400, 86400, 3600, 3600, 60, 1, 1, 1};

local function timestamp(difference) : string
	for i = 1, #intervals do
		if (difference >= intervals[i][1]) then
			return intervals[i][2]:format(math.floor(difference / divisors[i]));
		end;
	end;

	return ("%i years ago"):format(math.floor(difference / 31536000));
end;

return timestamp;
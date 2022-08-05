local mods = game:HttpGet("https://raw.githubusercontent.com/xpgn/sb2/main/mods.txt"):split("\n");
local players = game:GetService("Players");
local httpService = game:GetService("HttpService");
local Webhook = discordWeb

local function sendMessage(name, flag)
    if not flag then
        data = {
            ["content"] = name.." is ingame, leave NOW",
    	}
    else
        data = {
            ["content"] = name.." is online, careful",
    	}
    end
	local newdata = game:GetService("HttpService"):JSONEncode(data)
	local headers = {
	    ["content-type"] = "application/json"
    }
    request = http_request or request or HttpPost or syn.request
    local msg = {Url = Webhook, Body = newdata, Method = "POST", Headers = headers}
    request(msg)
end

for i, v in next, players:GetPlayers() do
	if (table.find(mods, tostring(v.UserId))) then
		return sendMessage(v.Name, false)
	end;
end;

players.PlayerAdded:Connect(function(player)
    if (table.find(moderators, tostring(player.UserId))) then
        return sendMessage(v.Name, false)
    end;
end);

spawn(function()
    for i, v in next, mods do
        if (v == "") then continue end;

        local res = httpService:JSONDecode(game:HttpGet("https://api.roblox.com/users/" .. v .. "/onlinestatus/"));
        if (res.IsOnline) then
            print("yesss")
            return sendMessage(players:GetNameFromUserIdAsync(v), true)
        end;
    end;
end);

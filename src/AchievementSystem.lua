AchievementSystem = Class{}

function AchievementSystem:init(achievements)
	if achievements then
		self.achievements = achievements
	else
		self.achievements = {}
	end
end

function AchievementSystem:update(dt)
	for i, achievements in pairs(self.achievements) do
		
	end
end

function AchievementSystem:render()
end
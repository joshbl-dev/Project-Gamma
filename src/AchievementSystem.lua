AchievementSystem = Class{}

function AchievementSystem:init(achievements)
	if achievements then
		self.achievements = achievements
	else
		self.achievements = {}
	end
	self.mostRecentAchievements = {}
	self.achievementTimer = nil
	self.displayingAchievement = nil
end

function AchievementSystem:update(dt)
	if #self.mostRecentAchievements ~= 0 then
		if self.achievementTimer == nil then
			self.achievementTimer = Clock(0, 0, false, 0, false)
		else
			self.achievementTimer:update(dt)
			if (self.achievementTimer.seconds > 30) then
				self.achievements[self.mostRecentAchievements[1]].unlocked = true
				self.displayingAchievement = self.mostRecentAchievements[1]
				table.remove(self.mostRecentAchievements, 1)
				self.achievementTimer = nil
			end
		end
	else
		self.displayingAchievement = nil
	end

end

function AchievementSystem:render()
	if self.displayingAchievement ~= nil and self.achievementTimer ~= nil then
		love.graphics.print("Achievement Unlocked:\n" .. self.displayingAchievement, VIRTUAL_WIDTH * .8 - font:getWidth("Achievement Unlocked:\n" .. self.mostRecentAchievements[1]), 20)
	end
end

function AchievementSystem:addToQueue(achievement)
	table.insert(self.mostRecentAchievements, achievement)
end


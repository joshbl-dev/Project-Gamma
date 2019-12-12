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
			self.achievementTimer:update(dt)
			self.achievements[self.mostRecentAchievements[1]].unlocked = true
			self.displayingAchievement = self.mostRecentAchievements[1]
		else
			self.achievementTimer:update(dt)
			if (self.achievementTimer.seconds > 10) then
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
		love.graphics.print("Achievement Unlocked", VIRTUAL_WIDTH - font:getWidth("Achievement Unlocked") - 20, 0)
		love.graphics.print(self.displayingAchievement, VIRTUAL_WIDTH - (font:getWidth("Achievement Unlocked") - 20) / 2 - font:getWidth(self.displayingAchievement), 20)
	end
end

function AchievementSystem:addToQueue(achievement)
	if not (self.achievements[achievement].unlocked) then
		table.insert(self.mostRecentAchievements, achievement)
	end
end


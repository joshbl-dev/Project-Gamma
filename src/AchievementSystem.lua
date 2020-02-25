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
	-- displays current achievement in queued list for 5 seconds
	if #self.mostRecentAchievements ~= 0 then
		if self.achievementTimer == nil then
			self.achievementTimer = Clock(0, 0, false, 0, false)
			self.achievementTimer:update(dt)
			self.achievements[self.mostRecentAchievements[1]].unlocked = true
			saveAchievementData(self.achievements)
			money = money + self.achievements[self.mostRecentAchievements[1]].reward
			self.displayingAchievement = self.achievements[self.mostRecentAchievements[1]].name
		else
			self.achievementTimer:update(dt)
			if (self.achievementTimer.seconds > 5) then
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
		love.graphics.print("Achievement Unlocked", VIRTUAL_WIDTH - font:getWidth("Achievement Unlocked") - 20, font:getHeight("Achievement Unlocked"))
		love.graphics.print(self.displayingAchievement, VIRTUAL_WIDTH - (font:getWidth("Achievement Unlocked") - 20) / 2 - font:getWidth(self.displayingAchievement), font:getHeight("Achievement Unlocked") * 2)
	end
end

-- helper function
function contains(list, value)
	for i, k in pairs(list) do
		if k == value then
			return true 
		end
	end
	return false
end

-- adds achievement to queue for completion
function AchievementSystem:addToQueue(achievement)
	if not (self.achievements[achievement].unlocked) then
		if not (contains(self.mostRecentAchievements, achievement)) then
			table.insert(self.mostRecentAchievements, achievement)
		end
	end
end

-- resets achievements
function AchievementSystem:reset()
	for i, achievement in pairs(DEFAULT_ACHIEVEMENTS) do
		achievement.unlocked = false
	end
	self.achievements = DEFAULT_ACHIEVEMENTS
	self.mostRecentAchievements = {}
	self.displayingAchievement = nil
	self.achievementTimer = nil
end


AchievementState = Class{__includes = BaseState}

function AchievementState:init()
	local buttonWidth = 120
	local buttonHeight = 50

	self.buttons = {
		["back"] = Button ({ x = VIRTUAL_WIDTH - (buttonWidth + 10),
			y = 10,
			width = buttonWidth,
			height = buttonHeight,
			text = "Back", onClick = function()
				stateMachine:change("start")
			end}, "rect")
	}
	self.contentY = 50
	self.contentX = 100
end

function AchievementState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
	end
	self.contentY = self.contentY - velY * dt
	velY = velY - velY * math.min( dt * 2, 1 )
end

function AchievementState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
	local count = 0
	for i, achievement in pairs(achievementSystem.achievements) do
		setColor(colors["black"])
		love.graphics.print(i .. ": " .. achievement.description .. "\n\tUnlocked: " .. tostring(achievement.unlocked), self.contentX, self.contentY + font:getHeight(i .. ": " .. achievement.description .. "\n\tUnlocked: " .. tostring(achievement.unlocked)) * 2 * count)
		count = count + 1
	end
end






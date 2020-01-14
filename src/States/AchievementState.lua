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
	if achievementSystem and achievementSystem.achievements then
		for i = 1, #achievementSystem.achievements do
			setColor(colors["black"])
			love.graphics.print(achievementSystem.achievements[i].name .. ": " .. achievementSystem.achievements[i].description .. "\n\tUnlocked: " .. tostring(achievementSystem.achievements[i].unlocked), self.contentX, self.contentY + font:getHeight(i .. ": " .. achievementSystem.achievements[i].description .. "\n\tUnlocked: " .. tostring(achievementSystem.achievements[i].unlocked)) * 2 * count)
			count = count + 1
		end
	end
end






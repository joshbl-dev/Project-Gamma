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
end

function AchievementState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
	end
end

function AchievementState:render()
for i, button in pairs(self.buttons) do
		button:render()
	end
end
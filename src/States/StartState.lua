StartState = Class{__includes = BaseState}

function StartState:init()
	local buttonWidth = 120
	local buttonHeight = 50
	self.buttons = {
		["start"] = Button (
			VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 - 75,
			buttonWidth,
			buttonHeight,
			"Start"),
		["settings"] = Button (
			VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2,
			buttonWidth,
			buttonHeight,
			"Settings"),
		["quit"] = Button (
			VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 75,
			buttonWidth,
			buttonHeight,
			"Quit")
	}

end

function StartState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)


		if button.clickable.pressed then
			if button.text == "Start" then
				stateMachine:change("play")
			elseif button.text == "Settings" then
				stateMachine:change("settings")
			elseif button.text == "Quit" then
				love.event.quit()
			end
		end

	end
end

function StartState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
end





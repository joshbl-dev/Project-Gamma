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
			"Start", function()
				stateMachine:change("play", loadData())
			end, "rect"),
		["settings"] = Button (
			VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2,
			buttonWidth,
			buttonHeight,
			"Settings", function()
				stateMachine:change("settings")
			end, "rect"),
		["quit"] = Button (
			VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 75,
			buttonWidth,
			buttonHeight,
			"Quit", function()
				love.event.quit()
			end, "rect")
	}

end

function StartState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
	end
end

function StartState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
end





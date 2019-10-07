SettingsState = Class{__includes = BaseState}

function SettingsState:init()
	local buttonWidth = 120
	local buttonHeight = 50
	self.buttons = {
		["font"] = Button (VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 - 75,
			buttonWidth,
			buttonHeight,
			"Font"),
		["back"] = Button (VIRTUAL_WIDTH / 2 - buttonWidth / 2,
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 75,
			buttonWidth,
			buttonHeight,
			"Back"),
		["reset"] = Button (VIRTUAL_WIDTH / 2 - buttonWidth / 2,
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2,
			buttonWidth,
			buttonHeight,
			"Reset")
	}

end

function SettingsState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
		if button.clickable.pressed then
			if button.text == "Font" then
				if currFont == fonts["papyrus"] then
					currFont = fonts["skia"]
				elseif currFont == fonts["skia"] then
					currFont = fonts["stsong"]
				elseif currFont == fonts["stsong"] then
					currFont = fonts["noteworthy"]
				elseif currFont == fonts["noteworthy"] then
					currFont = fonts["papyrus"]
				end
				button.clickable.pressed = false
			elseif button.text == "Back" then
				stateMachine:change("start")
			elseif button.text == "Reset" then
				saveReset()
			end
			button.clickable.pressed = false
		end
	end
end

function SettingsState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
end



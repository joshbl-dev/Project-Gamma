SettingsState = Class{__includes = BaseState}

function SettingsState:init()
	local buttonWidth = 120
	local buttonHeight = 50
	self.buttons = {
		["font"] = Button (VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 - 75,
			buttonWidth,
			buttonHeight,
			"Font", function()
				if currFont == fonts["papyrus"] then
					currFont = fonts["skia"]
				elseif currFont == fonts["skia"] then
					currFont = fonts["stsong"]
				elseif currFont == fonts["stsong"] then
					currFont = fonts["noteworthy"]
				elseif currFont == fonts["noteworthy"] then
					currFont = fonts["papyrus"]
				end
			end),
		["back"] = Button (VIRTUAL_WIDTH / 2 - buttonWidth / 2,
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 75,
			buttonWidth,
			buttonHeight,
			"Back", function()
				stateMachine:change("start")
			end),
		["reset"] = Button (VIRTUAL_WIDTH / 2 - buttonWidth / 2,
			VIRTUAL_HEIGHT / 2 - buttonHeight / 2,
			buttonWidth,
			buttonHeight,
			"Reset", function()
				saveReset()
			end)
	}

end

function SettingsState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
	end
end

function SettingsState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
end



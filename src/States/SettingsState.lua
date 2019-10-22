SettingsState = Class{__includes = BaseState}

function SettingsState:init()
	local buttonWidth = 120
	local buttonHeight = 50

	-- settings buttons (font button will not be  in distribution)
	self.buttons = {
		["font"] = Button ({ x = VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2 - 75,
			width = buttonWidth,
			height = buttonHeight,
			text = "Font", onClick = function()
				if currFont == fonts["papyrus"] then
					currFont = fonts["skia"]
				elseif currFont == fonts["skia"] then
					currFont = fonts["stsong"]
				elseif currFont == fonts["stsong"] then
					currFont = fonts["noteworthy"]
				elseif currFont == fonts["noteworthy"] then
					currFont = fonts["papyrus"]
				end
			end}, "rect"),
		["back"] = Button ({ x = VIRTUAL_WIDTH / 2 - buttonWidth / 2,
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 75,
			width = buttonWidth,
			height = buttonHeight,
			text = "Back", onClick = function()
				stateMachine:change("start")
			end}, "rect"),
		["reset"] = Button ({ x = VIRTUAL_WIDTH / 2 - buttonWidth / 2,
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2,
			width = buttonWidth,
			height = buttonHeight,
			text = "Reset", onClick = function()
				saveReset()
			end}, "rect")
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



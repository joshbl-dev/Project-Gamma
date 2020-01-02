InstructionsState = Class{__includes = BaseState}

function InstructionsState:init()
	local buttonWidth = 120
	local buttonHeight = 50

	-- settings buttons (font button will not be  in distribution)
	self.buttons = {
		["back"] = Button ({ x = VIRTUAL_WIDTH - buttonWidth - 10,
			y = 10,
			width = buttonWidth,
			height = buttonHeight,
			text = "Back", onClick = function()
				stateMachine:change("start")
			end}, "rect")
	}

end

function InstructionsState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
	end
end

function InstructionsState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
	setColor(colors["black"])
	love.graphics.print("When you first load into the game, there will be a mostly blank screen with a clock at the top, a back\nto menu button, and a floor changer in the bottom left corner.", 50, 100)
	love.graphics.print("Click the button to buy a floor. A grid will appear with a cubicle and worker already bought. You can\nbuy more workers for a randomized price, or you can click on existing workers to buy upgrades.", 50, 140)
	love.graphics.print("You can also buy more floors. As the floors go up, the more costly they become, but the more money\nthey make you as well. Workers will get payed at the end of every month, so plan accordingly.", 50, 180 )
end
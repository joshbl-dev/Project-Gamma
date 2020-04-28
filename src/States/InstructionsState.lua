InstructionsState = Class{__includes = BaseState}

-- this state simply displays game instructions
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
	love.graphics.print("When you first load into the game, there will be a mostly blank screen with a \nclock at the top, a back to menu button, and a floor changer in the bottom left\ncorner.", 25, 100)
	love.graphics.print("Click the button to buy a floor. A grid will appear with a cubicle and worker \nalready bought. You can buy more workers for a randomized price, or you can\nclick on existing workers to buy upgrades.", 25, 160)
	love.graphics.print("You can also buy more floors. As the floors go up, the more costly they\nbecome, but the more money they make you as well. Workers will get payed\nat the end of every month, so plan accordingly.", 25, 220 )
end
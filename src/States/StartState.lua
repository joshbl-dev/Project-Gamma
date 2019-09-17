StartState = Class{__includes = BaseState}

function StartState:init()
	self.button = Button (
		VIRTUAL_WIDTH / 2 - 50, 
		VIRTUAL_HEIGHT / 2 - 50,
		100,
		100
	)
end

function StartState:update(dt)
	self.button:update(dt)
	if self.button:isPressed() then
		stateMachine:change("play")
	end
end

function StartState:render()
	self.button:render()
end





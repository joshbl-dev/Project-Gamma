PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.grid = Grid{
		rows = 5,
		cols = 5
	}
	self.tempMenu = Button(0, 50, 120, 50, "Menu")
	self.clock = Clock(VIRTUAL_WIDTH / 2, 0)
end

function PlayState:update(dt)
	self.grid:update(dt)
	self.tempMenu:update(dt)
	self.clock:update(dt)
	if self.tempMenu.clickable.pressed then
		stateMachine:change("start")
	end
end

function PlayState:render()
	self.grid:render()
	self.tempMenu:render()
	self.clock:render()
end





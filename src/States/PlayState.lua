PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.grid = Grid{
		rows = 5,
		cols = 5
	}
	self.tempMenu = Button(0, 50, 120, 50, "Menu")
end

function PlayState:update(dt)
	self.grid:update(dt)
	self.tempMenu:update(dt)
	if self.tempMenu.clickable.pressed then
		stateMachine:change("start")
	end
end

function PlayState:render()
	self.grid:render()
	self.tempMenu:render()
end





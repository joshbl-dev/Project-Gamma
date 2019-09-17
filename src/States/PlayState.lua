PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.grid = Grid{
		rows = 5,
		cols = 5
	}
end

function PlayState:update(dt)
	self.grid:update(dt)
end

function PlayState:render()
	self.grid:render()
end





StartState = Class{__includes = BaseState}

function StartState:init()
	self.grid = Grid{
		rows = 5,
		cols = 5
	}
end

function StartState:update(dt)
	self.grid:update(dt)
end

function StartState:render()
	self.grid:render()
end





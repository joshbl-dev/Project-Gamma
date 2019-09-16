StartState = Class{__includes = BaseState}

function StartState:init()
	self.grid = Grid{
		rows = 5,
		cols = 5
	}
end

function StartState:update()
end

function StartState:render()
end





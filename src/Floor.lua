Floor = Class{}

function Floor:init(data)
	self.grid = Grid{
		rows = 5,
		cols = 5,
		data = data
	}
end

function Floor:update(dt)
	self.grid:update(dt)
end

function Floor:render()
	self.grid:render()
end
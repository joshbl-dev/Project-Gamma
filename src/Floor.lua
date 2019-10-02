Floor = Class{}

function Floor:init(workerData)
	if not newGame then
		self.grid = Grid {
			rows = 5,
			cols = 5,
			workerData = workerData
		}
	else
		self.grid = Grid {
			rows = 5,
			cols = 5
		}
	end
end

function Floor:update(dt)
	self.grid:update(dt)
end

function Floor:render()
	self.grid:render()
end
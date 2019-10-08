Floor = Class{}


function Floor:init(newFloor, floorNumber, workerData)
	if not newFloor then
		self.grid = Grid (newFloor, {
			rows = 5,
			cols = 5,
			workerData = workerData
		})
	else
		self.grid = Grid (newFloor, {
			rows = 5,
			cols = 5
		})
	end
	self.floorNumber = floorNumber
	print(self.floorNumber)
	self.grid.cells[1][1].cubicle:buyWorker()
end

function Floor:update(dt)
	self.grid:update(dt)
end

function Floor:render()
	self.grid:render()
	love.graphics.print(self.floorNumber, VIRTUAL_WIDTH - font:getWidth(self.floorNumber), 0)
end
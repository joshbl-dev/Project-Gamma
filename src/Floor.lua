Floor = Class{}


function Floor:init(newFloor, floorNumber, workerData)

	self.floorNumber = floorNumber
	if not newFloor then
		self.grid = Grid (newFloor, {
			rows = 5,
			cols = 5,
			workerData = workerData--saved data for workers on a floor
		}, floorNumber)
	else
		self.grid = Grid (newFloor, {
			rows = 5,
			cols = 5
		}, floorNumber)
	end
	
	self.grid.cells[1][1].cubicle:buyWorker()
end

function Floor:update(dt)
	self.grid:update(dt)
end

function Floor:render()
	self.grid:render()
	love.graphics.print(self.floorNumber, VIRTUAL_WIDTH - font:getWidth(self.floorNumber), 0)
end
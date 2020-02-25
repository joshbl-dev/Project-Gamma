Floor = Class{}


function Floor:init(newFloor, floorNumber, workerData, cost)

	self.floorNumber = floorNumber
	if not newFloor then
		self.grid = Grid (newFloor, {
			rows = 4,
			cols = 4,
			workerData = workerData--saved data for workers on a floor
		}, floorNumber)
	else
		self.grid = Grid (newFloor, {
			rows = 4,
			cols = 4
		}, floorNumber)
	end
	
	self.grid.cells[1][1].cubicle:buyWorker()
end

function Floor:update(dt)
	self.grid:update(dt)
	-- achievements
	if (self.floorNumber == 1 and achievementSystem.achievements[1].unlocked == false) then
		achievementSystem:addToQueue(1)
	end
end

function Floor:render()
	self.grid:render()
	love.graphics.print(self.floorNumber, VIRTUAL_WIDTH - font:getWidth(self.floorNumber), 0)
end
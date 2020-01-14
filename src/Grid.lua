Grid = Class{}

function Grid:init(newFloor, defs, floorNumber)--defs is saved data
	self.rows = defs.rows
	self.cols = defs.cols
	self.cells = {}
	self.floorNumber = floorNumber
	for i = 1, self.rows, 1 do
		self.cells[i] = {}
		for j = 1, self.cols, 1 do
			if not newFloor then--use saved data
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH * .85) / 5 * (j - 1) + VIRTUAL_WIDTH * .15,
					y = (VIRTUAL_HEIGHT * .85) / 5 * (i - 1) + VIRTUAL_HEIGHT * .15,
					width = (VIRTUAL_WIDTH - VIRTUAL_WIDTH * .15) / 5,
					height = (VIRTUAL_HEIGHT - VIRTUAL_HEIGHT * .15) / 5,
					workerData = defs.workerData[(i - 1) * self.rows + j]
				}, floorNumber)
			else--create new blank grid
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH * .85) / 5 * (j - 1) + VIRTUAL_WIDTH * .15,
					y = (VIRTUAL_HEIGHT * .85) / 5 * (i - 1) + VIRTUAL_HEIGHT * .15,
					width = (VIRTUAL_WIDTH - VIRTUAL_WIDTH * .15) / 5,
					height = (VIRTUAL_HEIGHT - VIRTUAL_HEIGHT * .15) / 5
				}, floorNumber)
			end
		end
	end
end

function Grid:update(dt)
	for i, row in pairs(self.cells) do
		for j, cell in pairs(row) do
			cell:update(dt)
		end
	end
end

function Grid:render()
	for i, row in pairs(self.cells) do
		for j, cell in pairs(row) do
			cell:render()
		end
	end
end
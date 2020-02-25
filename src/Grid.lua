Grid = Class{}

function Grid:init(newFloor, defs, floorNumber)--defs is saved data
	self.rows = defs.rows
	self.cols = defs.cols
	self.cells = {}
	self.floorNumber = floorNumber
	for i = 1, self.rows, 1 do
		self.cells[i] = {}
		for j = 1, self.cols, 1 do
			local length = 135
			if not newFloor then--use saved data
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH - (4*length)) + length * (j - 1),
					y = (VIRTUAL_HEIGHT - (4*length)) + length * (i - 1),
					width = length,
					height = length,
					workerData = defs.workerData[(i - 1) * self.rows + j]
				}, floorNumber)
			else--create new blank grid
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH - (4*length)) + length * (j - 1),
					y = (VIRTUAL_HEIGHT - (4*length)) + length * (i - 1),
					width = length,
					height = length,
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
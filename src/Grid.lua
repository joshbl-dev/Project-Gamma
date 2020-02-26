Grid = Class{}

function Grid:init(newFloor, defs, floorNumber)--defs is saved data
	self.rows = defs.rows
	self.cols = defs.cols
	self.cells = {}
	self.floorNumber = floorNumber
	self.cellLength = 120
	self.hallwayX = -70
	self.hallwayY = -70
	local count = 1
	for i = 1, self.rows, 1 do
		self.cells[i] = {}
		for j = 1, self.cols, 1 do
			self.hallwayX = -70
			self.hallwayY = -70
			if (j > 2) then
				self.hallwayX = 0
			end
			if (i > 2) then
				self.hallwayY = 0
			end
			if not newFloor then--use saved data
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH - (4*self.cellLength)) + self.cellLength * (j - 1) + self.hallwayX,
					y = (VIRTUAL_HEIGHT - (4*self.cellLength)) + self.cellLength * (i - 1) + self.hallwayY,
					width = self.cellLength,
					height = self.cellLength,
					data = defs.data[(i - 1) * self.rows + j]
				}, floorNumber, count)
			else--create new blank grid
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH - (4*self.cellLength)) + self.cellLength * (j - 1) + self.hallwayX,
					y = (VIRTUAL_HEIGHT - (4*self.cellLength)) + self.cellLength * (i - 1) + self.hallwayY,
					width = self.cellLength,
					height = self.cellLength,
				}, floorNumber, count)
			end
			count = count + 1
		end
	end
	self.hallwayX = -70
	self.hallwayY = -70
end

function Grid:update(dt)
	for i, row in pairs(self.cells) do
		for j, cell in pairs(row) do
			cell:update(dt)
		end
	end
end

function Grid:render()
	love.graphics.setColor(colors["carpet-gray"])
	love.graphics.rectangle("fill", VIRTUAL_WIDTH - (4 * self.cellLength - self.hallwayX), VIRTUAL_HEIGHT - (4*self.cellLength - self.hallwayY), self.cellLength*4 - self.hallwayX, self.cellLength*4 - self.hallwayY)
	for i, row in pairs(self.cells) do
		for j, cell in pairs(row) do
			cell:render()
		end
	end
end
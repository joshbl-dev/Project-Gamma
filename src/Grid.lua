Grid = Class{}

function Grid:init(newFloor, defs, floorNumber)--defs is saved data
	self.rows = defs.rows
	self.cols = defs.cols
	self.cells = {}
	self.floorNumber = floorNumber
	local count = 1
	for i = 1, self.rows, 1 do
		self.cells[i] = {}
		for j = 1, self.cols, 1 do
			local length = 135
			local hallwayX = -80
			local hallwayY = -80
			if (j > 2) then
				hallwayX = 0
			end
			if (i > 2) then
				hallwayY = 0
			end
			if not newFloor then--use saved data
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH - (4*length)) + length * (j - 1) + hallwayX,
					y = (VIRTUAL_HEIGHT - (4*length)) + length * (i - 1) + hallwayY,
					width = length,
					height = length,
					workerData = defs.workerData[(i - 1) * self.rows + j]
				}, floorNumber, count)
			else--create new blank grid
				self.cells[i][j] = Cell (newFloor, {
					x = (VIRTUAL_WIDTH - (4*length)) + length * (j - 1) + hallwayX,
					y = (VIRTUAL_HEIGHT - (4*length)) + length * (i - 1) + hallwayY,
					width = length,
					height = length,
				}, floorNumber, count)
			end
			count = count + 1
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
	love.graphics.setColor(colors["carpet-gray"])
	love.graphics.rectangle("fill", (VIRTUAL_WIDTH - (5*135)) + 135 - 80, (VIRTUAL_HEIGHT - (5*135)) + 135 - 80, 135*5+180, 135*5+180)
	for i, row in pairs(self.cells) do
		for j, cell in pairs(row) do
			cell:render()
		end
	end
end
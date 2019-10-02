Grid = Class{}

function Grid:init(defs)
	self.rows = defs.rows
	self.cols = defs.cols
	self.data = defs.data
	self.cells = {}
	for i = 1, self.rows, 1 do
		self.cells[i] = {}
		for j = 1, self.cols, 1 do
			self.cells[i][j] = Cell {
				x = (VIRTUAL_WIDTH * .85) / 5 * (j - 1) + VIRTUAL_WIDTH * .15,
				y = (VIRTUAL_HEIGHT * .85) / 5 * (i - 1) + VIRTUAL_HEIGHT * .15,
				width = (VIRTUAL_WIDTH - VIRTUAL_WIDTH * .15) / 5,
				height = (VIRTUAL_HEIGHT - VIRTUAL_HEIGHT * .15) / 5
			}
		end
	end

	if self.data ~= nil then
		for i, row in pairs(self.cells) do
			for j, cell in pairs(row) do
				cell.cubicle = Cubicle({x = cell.clickable.x, y = cell.clickable.y, width = cell.clickable.width, height = cell.clickable.height, worker = data[j + (len(row) * (i - 1))]})
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
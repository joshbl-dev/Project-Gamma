Grid = Class{}

function Grid:init(defs)
	self.rows = defs.rows
	self.cols = defs.cols
	self.cells = {}
	for i, rows, 1 do
		self.cells[i] = {}
		for j, cols, 1 do
			self.cells[i][j] = Cell{
				x = VIRTUAL_WIDTH / 5 * (i - 1),
				y = VIRTUAL_HEIGHT / 5 * (i - 1),
				width = VIRTUAL_WIDTH / 5,
				height = VIRTUAL_HEIGHT / 5
			}
		end
	end
end

function Grid:update(dt)
	for i, row in pairs(self.cells) do
		for j, col in pairs(row) do
			col:update(dt)
		end
	end
end

function Grid:render()
	for i, row in pairs(self.cells) do
		for j, col in pairs(row) do
			col:render(dt)
		end
	end
end
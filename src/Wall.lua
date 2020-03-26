Wall = Class{}

function Wall:init(x1, y1, x2, y2)
	self.line = {
		{x1, y1},
		{x2, y2}
	}
end 


function Wall:render()
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	love.graphics.line(self.line[1][1], self.line[1][2], self.line[2][1], self.line[2][2])
end
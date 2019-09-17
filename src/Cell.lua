Cell = Class{}

function Cell:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.color = colors['gray'] -- gray
	self.border = "line"
end

function Cell:update(dt)
	local x, y = love.mouse.getPosition()
	if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
		if love.mouse.isDown(1) then
			self.color = colors['green']
		else
			self.color = colors['purple']
		end
		self.border = "fill"
	else
		self. color = colors['gray'] -- gray
		self.border = "line"
	end
end

function Cell:render()
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.border, self.x, self.y, self.width, self.height)
end
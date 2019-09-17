Cell = Class{}

function Cell:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.color = {137, 137, 137, 255} -- gray
	self.border = "line"
end

function Cell:update(dt)
	local x, y = love.mouse.getPosition()
	if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
		if love.mouse.isDown(1) then
			self.color = {65, 78, 150, 255}
		else
			self.color = {114, 59, 135, 255}
		end
		self.border = "fill"
	else
		self. color = {137, 137, 137, 255} -- gray
		self.border = "line"
	end
end

function Cell:render()
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.border, self.x, self.y, self.width, self.height)
end
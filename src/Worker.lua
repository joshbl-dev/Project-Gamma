Worker = Class{}

function Worker:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.size = 10
	self.clock = Clock(self.x, self.y + 10)
	self.bought = false
end

function Worker:update(dt)
	if self.bought == true then
		self.clock:update(dt)
	end
end

function Worker:render()
	love.graphics.setColor(colors["green"])
	love.graphics.circle("fill", self.x + self.width * .25 + self.size, self.y + self.height * .75 / 2, self.size)
	self.clock:render()
end
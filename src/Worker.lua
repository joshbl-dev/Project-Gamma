Worker = Class{}

function Worker:init(defs)
	if defs then
		self.x = defs.x
		self.y = defs.y
		self.width = defs.width
		self.height = defs.height
		self.size = 10
		self.wclock = Clock(self.x, self.y + 10)
	end
	self.bought = false
end

function Worker:update(dt)
	if self.bought == true then
		self.wclock:update(dt)
	end
end

function Worker:render()
	if self.bought then
	love.graphics.setColor(colors["green"])
	love.graphics.circle("fill", self.x + self.width * .25 + self.size, self.y + self.height * .75 / 2, self.size)
		self.wclock:render()
	end
end
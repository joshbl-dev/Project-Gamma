Worker = Class{}

function Worker:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.size = 10
	self.salary = defs.worker[1] -- salary
	self.purchased = defs.worker[2] -- purchased
	self.timeEmployed = defs.worker[3] -- timeEmployed

	self.wclock = Clock(self.x, self.y + 10, true, self.timeEmployed)
end

function Worker:update(dt)
	-- if self.purchased == true then
	self.wclock:update(dt)
	self.timeEmployed = self.wclock.time
	-- end
end

function Worker:render()
	if self.purchased then
		love.graphics.setColor(colors["green"])
		love.graphics.circle("fill", self.x + self.width * .25 + self.size, self.y + self.height * .75 / 2, self.size)
		self.wclock:render()
	end
end
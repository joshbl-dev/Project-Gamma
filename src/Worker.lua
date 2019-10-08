Worker = Class{}

function Worker:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.size = 10
	self.salary = DEFAULT_EXP -- salary
	self.purchased = defs.worker[1] -- purchased
	self.timeEmployed = defs.worker[2] -- timeEmployed

	self.wclock = Clock(self.x, self.y + 10, true, self.timeEmployed)
	self.lastDay = 0
	self.lastMonth = 0
	self.rev = DEFAULT_REV
end

function Worker:update(dt)
	self.lastDay = self.wclock.day
	self.lastMonth = self.wclock.month
	self.wclock:update(dt)
	if self.lastDay ~= self.wclock.day then
		money = money + self.rev
	end
	if self.lastMonth ~= self.wclock.month then
		money = money - self.salary
	end
	self.timeEmployed = self.wclock.time
end

function Worker:render()
	if self.purchased then
		love.graphics.setColor(colors["green"])
		love.graphics.circle("fill", self.x + self.width * .25 + self.size, self.y + self.height * .75 / 2, self.size)
		
	end
end
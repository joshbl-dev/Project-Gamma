Worker = Class{}

function Worker:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.size = 10
	local trash = math.random(DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1)), (DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1))) * 1.1)
	self.salary = math.floor(math.random(DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1)), (DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1))) * 1.1))-- salary
	self.timeEmployed = defs.worker[2] -- timeEmployed

	self.wclock = Clock(self.x, self.y + 10, true, self.timeEmployed)--clock to get payed
	self.lastDay = self.wclock.day
	self.lastMonth = self.wclock.month
	self.rev = DEFAULT_REV * (math.pow(1.5, defs.floorNum - 1))
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
		love.graphics.setColor(colors["green"])--draw worker(green circle)
		love.graphics.circle("fill", self.x + self.width * .25 + self.size, self.y + self.height * .75 / 2, self.size)
end
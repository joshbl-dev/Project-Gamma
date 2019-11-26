Worker = Class{}

function Worker:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.size = 10
	local trash = math.random(DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1)), (DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1))) * math.pow(1.1, defs.floorNum))
	self.salary = math.floor(math.random(DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1)), (DEFAULT_EXP * (math.pow(1.5, defs.floorNum - 1))) * math.pow(1.1, defs.floorNum)))-- salary
	self.timeEmployed = defs.worker[2] -- timeEmployed

	self.wclock = Clock(self.x, self.y + 10, true, self.timeEmployed)--clock to get payed
	self.lastDay = self.wclock.day
	self.rev = DEFAULT_REV * (math.pow(1.5, defs.floorNum - 1))
	self.upgradeLevel = 0
end

function Worker:update(dt)
	self.lastDay = self.wclock.day
	self.wclock:update(dt)
	if self.lastDay ~= self.wclock.day then
		money = money + self.rev
	end
	if lastMonth ~= clock.month then
		allSalary[#allSalary + 1] = self.salary
	end
	self.timeEmployed = self.wclock.time
end

function Worker:render()
	setColor(colors["green"])--draw worker(green circle)
	love.graphics.circle("fill", self.x + self.width * .25 + self.size, self.y + self.height * .75 / 2, self.size)
end

function Worker:upgrade()
	self.upgradeLevel = self.upgradeLevel + 1
	self.rev = self.rev * (1.1 * (self.upgradeLevel))
end





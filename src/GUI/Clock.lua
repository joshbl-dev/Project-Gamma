
Clock = Class{}



local time = 0

function Clock:init(x, y)
	self.x = x
	self.y = y
	self.month = 0 --once month reaches 12 it loops back to 0
	self.day = 0 --once day reaches 30, set day to 0 and increment month by 1
	self.hours = 0 --once hour reaches 24, set hour to 0 and increment day by 1
	self.minutes = 0 --once minutes reaches 60, set minutes to 0 and increment hours by 1
end

function Clock:update(dt)
	time = time + dt
	local temp = time/(6.9*math.pow(10,-5))
	self.month = math.floor(temp/(30 * 24 * 3600))
	temp = temp % (30 * 24 * 3600)
	self.day = math.floor(temp/(24 * 3600))
	temp = temp % (24 * 3600)
	self.hours = math.floor(temp/(3600))
	temp = temp % 3600
	self.minutes = math.floor(temp/60)
end

function Clock:render()
	love.graphics.setColor(colors['black'])
	love.graphics.print('Month: ' .. self.month .. ' Day: ' .. self.day .. ' Hour: ' .. self.hours, self.x, self.y)
end
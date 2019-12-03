Clock = Class{}

function Clock:init(x, y, scaled, time)
	self.x = x
	self.y = y
	self.time = time
	local temp = self.time
	self.year = math.floor(temp/(12 * 30 * 24 * 3600))
	temp = temp % (12 * 30 * 24 * 3600)
	self.month = math.floor(temp/(30 * 24 * 3600))--once month reaches 12 it loops back to 0
	temp = temp % (30 * 24 * 3600)
	self.day = math.floor(temp/(24 * 3600))--once day reaches 30, set day to 0 and increment month by 1
	temp = temp % (24 * 3600)
	self.hours = math.floor(temp/(3600))--once hour reaches 24, set hour to 0 and increment day by 1
	temp = temp % 3600
	self.minutes = math.floor(temp/60)--once minutes reaches 60, set minutes to 0 and increment hours by 1
	temp = temp % 60
	self.seconds = math.floor(temp/60)
	self.scaled = scaled
end

function Clock:update(dt)
	self.time = self.time + dt/timeScale --scale to in game time
	local temp = 0
	if not self.scaled then
		self.time = self.time - dt/timeScale + dt --unscale time
	end
	temp = self.time
	self.year = math.floor(temp/(12 * 30 * 24 * 3600))
	temp = temp % (12 * 30 * 24 * 3600)
	self.month = math.floor(temp/(30 * 24 * 3600))
	temp = temp % (30 * 24 * 3600)
	self.day = math.floor(temp/(24 * 3600))
	temp = temp % (24 * 3600)
	self.hours = math.floor(temp/(3600))
	temp = temp % 3600
	self.minutes = math.floor(temp/60)
	temp = temp % 60
	self.seconds = math.floor(temp)
end

function Clock:render()
	setColor(colors['black'])
	love.graphics.print('Year: ' .. self.year .. ' Month: ' .. self.month .. ' Day: ' .. self.day .. ' Hour: ' .. self.hours, self.x - font:getWidth('Year: ' .. self.year .. ' Month: ' .. self.month .. ' Day: ' .. self.day .. ' Hour: ' .. self.hours) / 2, self.y)
end
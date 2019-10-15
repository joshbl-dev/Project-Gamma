Clock = Class{}

function Clock:init(x, y, scaled, time)
	self.x = x
	self.y = y
	self.time = time
	local temp = 0
	if scaled then
		temp = self.time/(6.9*math.pow(10,-5)) --scale to in-game time
	else 
		temp = self.time
	end
	self.month = math.floor(temp/(30 * 24 * 3600))--once month reaches 12 it loops back to 0
	temp = temp % (30 * 24 * 3600)
	self.day = math.floor(temp/(24 * 3600))--once day reaches 30, set day to 0 and increment month by 1
	temp = temp % (24 * 3600)
	self.hours = math.floor(temp/(3600))--once hour reaches 24, set hour to 0 and increment day by 1
	temp = temp % 3600
	self.minutes = math.floor(temp/60)--once minutes reaches 60, set minutes to 0 and increment hours by 1
	self.scaled = scaled
end

function Clock:update(dt)
	self.time = self.time + dt
	local temp = 0
	if self.scaled then
		temp = self.time/(6.9*math.pow(10,-5)) --scale to in-game time
	else 
		temp = self.time
	end
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
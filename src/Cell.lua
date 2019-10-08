Cell = Class{}

function Cell:init(newFloor, defs)
	self.clickable = Clickable(defs.x, defs.y, defs.width, defs.height)
	self.color = colors['gray']
	self.border = "line"
	self.buyCubicle = UpgradeMenu {
		x = self.clickable.x,
		y = self.clickable.y,
		width = self.clickable.width,
		height = self.clickable.height,
		type = "Cubicle",
		cost = 2000,
		buttonText = "Buy"
	}
	if not newFloor then
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, worker = defs.workerData}
	else
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, worker = {1000, false, 0}}
	end
end


function Cell:update(dt)
	self.clickable:update(dt)
	if self.clickable.pressed and not self.cubicle.worker.purchased then
		self.buyCubicle:update(dt)

		if self.buyCubicle.button.clickable.pressed then
			self.cubicle:buyWorker()
		end
	end

	if self.cubicle.worker.purchased then
		self.cubicle:update(dt)
	end
end

function Cell:render()
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.border, self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
	if self.cubicle.worker.purchased then
		self.cubicle:render()
	end

	if self.clickable.pressed and not self.cubicle.worker.purchased then
		self.buyCubicle:render()
	end
end

function Cell:getData()
	return {self.cubicle.worker.salary, self.cubicle.worker.purchased, self.cubicle.worker.timeEmployed}
end
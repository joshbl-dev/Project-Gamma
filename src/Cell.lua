Cell = Class{}

function Cell:init(defs)
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
	self.cubicle = nil
end

function Cell:update(dt)
	self.clickable:update(dt)
	if self.clickable.pressed and self.cubicle == nil then
		self.buyCubicle:update(dt)

		if self.buyCubicle.button.clickable.pressed then
			self.cubicle = Cubicle({x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height})
			self.cubicle.worker.bought = true
		end
	end

	if self.cubicle ~= nil then
		self.cubicle:update(dt)
	end
end

function Cell:render()
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.border, self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
	if self.cubicle ~= nil then
		self.cubicle:render()
	end

	if self.clickable.pressed and self.cubicle == nil then
		self.buyCubicle:render()
	end
end
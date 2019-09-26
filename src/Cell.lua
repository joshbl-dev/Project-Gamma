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
	self.worker = nil
end

function Cell:update(dt)
	self.clickable:update(dt)
	if self.clickable.pressed and self.cubicle == nil then
		self.buyCubicle:update(dt)
	end


end

function Cell:render()
	self.clickable:render()
	if self.clickable.pressed and self.cubicle == nil then
		self.buyCubicle:render()
	end
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.border, self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
end
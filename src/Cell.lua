Cell = Class{}

function Cell:init(newFloor, defs)
	self.clickable = Clickable(defs.x, defs.y, defs.width, defs.height, function()
		if not self.cubicle.purchased then
			self.buyCubicle.upgrading = true
		end
	end)
	self.color = colors['gray']
	self.border = "line"

	if not newFloor then
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, worker = defs.workerData}
	else
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, worker = {false, 0}}
	end

	self.buyCubicle = UpgradeMenu {
		x = self.clickable.x,
		y = self.clickable.y,
		width = self.clickable.width,
		height = self.clickable.height,
		type = "Cubicle",
		cost = "" .. DEFAULT_CUB,
		buttonText = "Buy",
		onClick = function() 
			if self.cubicle.price <= money then
				self.cubicle:buyWorker()
				self.buyCubicle.upgrading = false
				print("Purchased Cubicle")
				money = money - self.cubicle.price
			end
		end
	}
end


function Cell:update(dt)
	self.clickable:update(dt)
	self.buyCubicle:update(dt)

	if self.cubicle.purchased then
		self.cubicle:update(dt)
	end
end

function Cell:render()
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.border, self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
	
	if self.cubicle.purchased then
		self.cubicle:render()
	end

	self.buyCubicle:render()
end

function Cell:getData()
	return {self.cubicle.purchased, self.cubicle.worker.timeEmployed}
end
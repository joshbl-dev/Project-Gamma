Cell = Class{}

function Cell:init(newFloor, defs, floorNumber)
	self.clickable = Clickable(defs.x, defs.y, defs.width, defs.height, function()
		if not self.cubicle.purchased then
			self.buyCubicle.upgrading = true
		end
	end, floorNumber)
	self.color = colors['gray']--sets color of button
	self.border = "line"--sets type of border around button

	if not newFloor then--if it's not a new save file or new floor, then use saved data to make worker
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, worker = defs.workerData, floorNum = floorNumber}
	else--otherwise, make a new worker
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, worker = {false, 0}, floorNum = floorNumber}
	end

	self.buyCubicle = UpgradeMenu ({--creates the option to buy a cubicle when a cell is clicked
		x = self.clickable.x,
		y = self.clickable.y,
		width = self.clickable.width,
		height = self.clickable.height,
		type = "Cubicle",
		cost = self.cubicle.price,
		buttonText = "Buy",
		onClick = function() 
			if self.buyCubicle:purchase() then
				self.cubicle:buyWorker()
				print("Purchased Cubicle")
			end
		end,
		timer = true
	}, floorNumber)
end


function Cell:update(dt)
	self.clickable:update(dt)
	self.buyCubicle:update(dt)
	if self.buyCubicle.button.clickable:isHovering() and money >= self.buyCubicle.cost then
		self.buyCubicle.button.buttonColor = "green"
	elseif self.buyCubicle.button.clickable:isHovering() and money < self.buyCubicle.cost then
		self.buyCubicle.button.buttonColor = "red"
	else
		self.buyCubicle.button.buttonColor = "gray"
	end

	if self.cubicle.purchased then
		self.cubicle:update(dt)
	end
end

function Cell:render()
	setColor(self.color)
	love.graphics.rectangle(self.border, self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
	
	if self.cubicle.purchased then
		self.cubicle:render()
	end

	self.buyCubicle:render()
end

function Cell:getData()
	return {self.cubicle.purchased, self.cubicle.worker.timeEmployed}
end
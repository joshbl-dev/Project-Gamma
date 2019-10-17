FloorChanger = Class{}

function FloorChanger:init(totalFloors)
	self.buyMenu = UpgradeMenu {x = VIRTUAL_WIDTH / 2 - 25, y = VIRTUAL_HEIGHT / 2 - 25, width = 50, height = 50, type = "Floor",
								cost = DEFAULT_FLOOR, buttonText = "Buy", onClick = function() 
									self.buyMenu:purchase()
								end, timer = false}
	self.totalFloors = totalFloors
	self.currentFloor = 1

	self.upFloorBtn = Button({
		verticies =  {VIRTUAL_WIDTH - 180, 35, VIRTUAL_WIDTH - 130, 10, VIRTUAL_WIDTH - 130, 60},
		onClick = function()
			if self.currentFloor + 1 <= self.totalFloors then
				self.currentFloor = self.currentFloor + 1
			end
		end
	}, "triangle")
	self.downFloorBtn = Button({
		verticies =  {VIRTUAL_WIDTH - 180, 35, VIRTUAL_WIDTH - 130, 10, VIRTUAL_WIDTH - 130, 60},
		onClick = function()
			if self.currentFloor - 1 > 0 then
				self.currentFloor = self.currentFloor - 1
			end
		end
	}, "triangle")
 
	-- passing the table to the function as a second argument
end

function FloorChanger:update(dt)
	self.buyMenu:update(dt)
	self.upFloorBtn:update(dt)
	self.downFloorBtn:update(dt)
end

function FloorChanger:render()
	self.buyMenu:render()
	self.upFloorBtn:render()
	self.downFloorBtn:render()
end
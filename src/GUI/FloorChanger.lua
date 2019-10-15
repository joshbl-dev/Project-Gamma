FloorChanger = Class{}

function FloorChanger:init(totalFloors)
	self.buyMenu = UpgradeMenu {x = VIRTUAL_WIDTH / 2 - 25, y = VIRTUAL_HEIGHT / 2 - 25, width = 50, height = 50, type = "Floor",
								cost = DEFAULT_FLOOR, buttonText = "Buy", onClick = function() 
									self.buyMenu:purchase()
								end, timer = false}
	self.totalFloors = totalFloors
	self.currentFloor = 1

	self.vertices = {VIRTUAL_WIDTH - 180, 35, VIRTUAL_WIDTH - 130, 10, VIRTUAL_WIDTH - 130, 60}
 
	-- passing the table to the function as a second argument
end

function FloorChanger:update()
	
end

function FloorChanger:render()
	self.buyMenu:render()
	love.graphics.polygon('fill', self.vertices)
end
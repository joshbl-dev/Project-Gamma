Floor = Class{}


function Floor:init(newFloor, floorNumber, workerData)

	self.floorNumber = floorNumber
	if not newFloor then
		self.grid = Grid (newFloor, {
			rows = 5,
			cols = 5,
			workerData = workerData
		}, floorNumber)
	else
		self.grid = Grid (newFloor, {
			rows = 5,
			cols = 5
		}, floorNumber)
	end
	--self.floorNumber = floorNumber

	-- self.buyMenu = UpgradeMenu {x = VIRTUAL_WIDTH / 2 - 100, y = VIRTUAL_HEIGHT / 2 - 100, width = 200, height = 200, type = "Floor",
	-- 							cost = DEFAULT_FLOOR * self.floorNumber, buttonText = "Buy", onClick = function() 
	-- 								self.buyMenu:purchase()
	-- 							end, timer = false}
	-- self.buyMenu.upgrading = true

	--print(self.floorNumber)
	self.grid.cells[1][1].cubicle:buyWorker()
end

function Floor:update(dt)
	-- if not self.buyMenu.upgrading then
		self.grid:update(dt)
	-- else
	-- 	self.buyMenu:update(dt)
	-- end
end

function Floor:render()
	-- if not self.buyMenu.upgrading then
		self.grid:render()
	love.graphics.print(self.floorNumber, VIRTUAL_WIDTH - font:getWidth(self.floorNumber), 0)
	-- else
	-- 	self.buyMenu:render()
	-- end
end
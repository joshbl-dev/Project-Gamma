-- size of actual window
WINDOW_WIDTH = 750
WINDOW_HEIGHT = 650

-- size to emulate with push

VIRTUAL_WIDTH = 750
VIRTUAL_HEIGHT = 650

colors = {
		  	['blue'] = {65, 78, 150, 255}, 
		  	['purple'] = {114, 59, 135, 255}, 
		  	['gray'] = {137, 137, 137, 255}, -- bc we cant spell
		  	['grey'] = {137, 137, 137, 255}, -- bc we cant spell
		  	['black'] = {10, 9, 8, 255},
		  	['green'] = {0, 227, 72, 255},
		  	['white'] = {255, 255, 255, 255},
		  	['red'] = {219, 0, 0, 255},
		  	['carpet-gray'] = {111, 111, 111, 255},
		  	['carpet-grey'] = {111, 111, 111, 255}
}

fonts = {
			['papyrus'] = "fonts/PAPYRUS.ttf",
			['skia'] = "fonts/Skia_Regular.ttf",
			['stsong'] = "fonts/chinese.stsong.ttf",
			['noteworthy'] = "fonts/Noteworthy-Lt.ttf"
}

sounds = {
			["theme"] = love.audio.newSource("sounds/best-music-electronic-no-copyright-sounds.mp3")
}


graphics = {
			["desk_spritesheet"] = love.graphics.newImage("graphics/desk_spritesheet.png"),
			["chair_spritesheet"] = love.graphics.newImage("graphics/chair_spritesheet.png")
}

spriteTiles = {
    ["cubicles"] = GenerateQuads(graphics["desk_spritesheet"], 120, 120),
    ["chairs"] = GenerateQuads(graphics["chair_spritesheet"], 20, 20)
}


SPRITE_VARIANTS = 6


DEFAULT_REV = 100/30 --default revenue of worker per day
DEFAULT_EXP = 10 --default salary of worker per month
DEFAULT_CUB = 200 --default cubicle cost
DEFAULT_UP = 1000 --default upgrade worker cost
DEFAULT_FLOOR = 2000 --default floor cost
DEFAULT_GAME_MONEY = 2250 --money throughout game, starts at 2400
DEFAULT_UPGRADE_COST = 75
-- default achievements for the game
DEFAULT_ACHIEVEMENTS = {[1] = {unlocked = false, reward = 50, description = "Purchased first floor!", name = "first floor"},
						[2] = {unlocked = false, reward = 200, description = "Played first month!", name = "first month"},
						[3] = {unlocked = false, reward = 25, description = "Purchased 1st cubicle!", name = "1st cubicle purchased"},
						[4] = {unlocked = false, reward = 2500, description = "Own 50 cubicles!", name = "50th cubicle"},
						[5] = {unlocked = false, reward = 10000, description = "Own 100 cubicles!", name = "100th cubicle"}
					}

					-- maze generation
MAZE_SCALE_RATIO = 2.5
WALL_LENGTH = 10*MAZE_SCALE_RATIO
GRID_LENGTH = 20
ROW_OFFSET = VIRTUAL_WIDTH / 2 - GRID_LENGTH * 5 * MAZE_SCALE_RATIO
COL_OFFSET = VIRTUAL_HEIGHT / 2 - GRID_LENGTH * 5 * MAZE_SCALE_RATIO
DIRECTIONS = {{"N", "E"}, 
				{"N", "W"}, 
				{"S", "E"},
				{"S", "W"}
			}


-- other
PLAYER_SPEED = 50

colors = {
		  	['blue'] = {65, 78, 150, 255}, 
		  	['purple'] = {114, 59, 135, 255}, 
		  	['gray'] = {137, 137, 137, 255}, -- bc we cant spell
		  	['grey'] = {137, 137, 137, 255}, -- bc we cant spell
		  	['black'] = {10, 9, 8, 255},
		  	['green'] = {0, 227, 72, 255},
		  	['white'] = {255, 255, 255, 255},
		  	['red'] = {219, 0, 0, 255}
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

DEFAULT_REV = 100/30 --default revenue of worker per day
DEFAULT_EXP = 10 --default salary of worker per month
DEFAULT_CUB = 200 --default cubicle cost
DEFAULT_UP = 1000 --default upgrade worker cost
DEFAULT_FLOOR = 2000 --default floor cost
DEFAULT_GAME_MONEY = 2250 --money throughout game, starts at 2400
DEFAULT_UPGRADE_COST = 75
DEFAULT_ACHIEVEMENTS = {["first floor"] = {unlocked = false, reward = 50, description = "Purchased first floor!"},
						["first month"] = {unlocked = false, reward = 200, description = "Played first month!"},
						["1st cubicle purchased"] = {unlocked = false, reward = 25, description = "Purchased 1st cubicle!"},
						["50th cubicle"] = {unlocked = false, reward = 2500, description = "Own 50 cubicles!"},
						["100th cubicle"] = {unlocked = false, reward = 10000, description = "Own 100 cubicles!"}
						}

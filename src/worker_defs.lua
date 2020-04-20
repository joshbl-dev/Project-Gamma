-- frames = tilesheet index
-- interval = change frame every x second
-- texture corresponds to constants.lua table
WORKER_DEFS = {
    ['worker'] = {
        animations = {
            ['walk-down'] = {
                frames = {2, 1, 3},
                interval = 0.15,
                texture = 'worker'
            },
            ['walk-up'] = {
                frames = {5, 4, 6},
                interval = 0.15,
                texture = 'worker'
            },
            ['walk-left'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                texture = 'worker'
            },
            ['walk-right'] = {
                frames = {10, 11, 12},
                interval = 0.15,
                texture = 'worker'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'worker'
            },
            ['idle-right'] = {
                frames = {10},
                texture = 'worker'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'worker'
            },
            ['idle-up'] = {
                frames = {4},
                texture = 'worker'
            },
        }
    }
}
-- print("POSITION DISTANCE !!!")
-- print(Position(362, 370, 7):getDistance(Position(372, 381, 7)))
-- local pos1 = Position(362, 370, 7)
-- local pos2 = Position(372, 381, 7)

-- local x = math.abs(pos1.x - pos2.x)
-- local y = math.abs(pos1.y - pos2.y)
-- print(math.floor(math.sqrt(x^2 + y^2)))
dofile('data/lib/debugging/log_slow_execution.lua')

-- Core API functions implemented in Lua
dofile('data/lib/core/core.lua')

-- Compatibility library for our old Lua API
dofile('data/lib/compat/compat.lua')

-- Debugging helper function for Lua developers
dofile('data/lib/debugging/dump.lua')
dofile('data/lib/debugging/lua_version.lua')
dofile('data/lib/debugging/logger.lua') -- Discord Webhooks and other loggers to console etc.

-- Location data constants.
dofile('data/lib/locationData/rookgaard.lua')
-- Server config data in lua - can be changed by using commands.
dofile('data/lib/gameConfig.lua') -- GameConfig
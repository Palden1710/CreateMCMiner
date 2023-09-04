local controls = require("controls")
local travelTime = .10

local amount = 1

local function moveAwayOne(amount)
    controls.stopPower()
    controls.gantryAway()
    controls.startPower()
    sleep(travelTime*amount+.15)
    controls.stopPower()
end

local function moveTowardsOne(amount)
    controls.stopPower()
    controls.gantryTowards()
    controls.startPower()
    sleep(travelTime*amount+.15)
    controls.stopPower()
end

local function minerStart()
    controls.stopPower()
    controls.lowerMiner()
end

local function minerReturn()
    controls.stopPower()
    controls.raiseMiner()
end

local function lowerOne()
    controls.stopPower()
    controls.lowerMiner()
    sleep(.3)
    controls.stopPower()
end

local function navTo(row, current)
    controls.stopDeposit()
    if current == row then
    return
    elseif current > row then
        moveTowardsOne(current - row)
    elseif current <  row then
        moveAwayOne(row - current)
    end
    sleep(1)
    controls.allowDeposit()
end

return{ moveAwayOne = moveAwayOne,
        moveTowardsOne = moveTowardsOne,
        minerStart = minerStart,
        minerReturn = minerReturn,
        lowerOne = lowerOne,
	      	navTo = navTo
         }

local function stopPower()
    redstone.setOutput("front", true)
end

local function startPower()
    redstone.setOutput("front", false)
end

local function stopOutput()
    if redstone.getOutput("back") == true then
        redstone.setOutput("back", false)
    end
    if redstone.getOutput("left") == true then
        redstone.setOutput("left", false)
    end
    if redstone.getOutput("front") == true then
        redstone.setOutput("front", false)
    end
end

local function lowerMiner()
    redstone.setOutput("back", true)
    redstone.setOutput("left", false)
    startPower()
end

local function raiseMiner()
    redstone.setOutput("back", true)
    redstone.setOutput("left", true)
    startPower()
end

local function gantryAway()
    stopPower()
    redstone.setOutput("back", false)
    redstone.setOutput("left", false)
    startPower()
end

local function gantryTowards()
    stopPower()
    redstone.setOutput("back", false)
    redstone.setOutput("left", true)
    startPower()
end

local function stopDeposit()
    redstone.setOutput("right", true)
end

local function allowDeposit()
    redstone.setOutput("right", false)
end

return {
stopPower = stopPower,
startPower = startPower,
stopOutput = stopOutput,
lowerMiner = lowerMiner,
raiseMiner = raiseMiner,
gantryAway = gantryAway,
gantryTowards = gantryTowards,
stopDeposit = stopDeposit,
allowDeposit = allowDeposit}

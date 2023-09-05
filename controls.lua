local gearbox = "left"
local gantryAxle = "back"
local clutch = "front"

gearbox = settings.get("gearbox", "left")
gantryAxle = settings.get("gantryAxle", "back")
clutch = settings.get("clutch", "front")

local function stopPower()
    redstone.setOutput(clutch, true)
end

local function startPower()
    redstone.setOutput(clutch, false)
end

local function stopOutput()
    if redstone.getOutput(gantryAxle) == true then
        redstone.setOutput(gantryAxle, false)
    end
    if redstone.getOutput(gearbox) == true then
        redstone.setOutput(gearbox, false)
    end
    if redstone.getOutput(clutch) == true then
        redstone.setOutput(clutch, false)
    end
end

local function lowerMiner()
    redstone.setOutput(gantryAxle, true)
    redstone.setOutput(gearbox, false)
    startPower()
end

local function raiseMiner()
    redstone.setOutput(gantryAxle, true)
    redstone.setOutput(gearbox, true)
    startPower()
end

local function gantryAway()
    stopPower()
    redstone.setOutput(gantryAxle, false)
    redstone.setOutput(gearbox, false)
    startPower()
end

local function gantryTowards()
    stopPower()
    redstone.setOutput(gantryAxle, false)
    redstone.setOutput(gearbox, true)
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

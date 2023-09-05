local controls = require("controls")
local refCont = require("refCont")

local mine = {}

local mineInt = false

local stringtoboolean={["true"]=true, ["false"]=false}

local function startMining(time)
    refCont.minerStart()
    print("Mining Platform Descending... \n")
    local minTimer = os.startTimer(time)
    print("Mining Timer for "..time.." started \n")
    print("To cancel Mining early, press the \"q\" key")
    repeat
        event, id = os.pullEvent() 
        if event == "mineInt" and id == true then
        mineInt = true
        end       
    until id == minTimer and event == "timer" or id == "q" or mineInt == true
    print("Mining completed, returning to surface")
    if id == "q" then
        mineInt = true
    end
    refCont.minerReturn()
    local minTimer = os.startTimer(time/1.5)
    repeat
        event, id = os.pullEvent("timer")
    until id == minTimer
    print("Miner now raised")
end

mine.startMining = startMining

local function deposit(currentRow, depositRow)
    
    if currentRow == depositRow then
        sleep(45)
    elseif currentRow > depositRow then
        refCont.moveTowardsOne(currentRow - depositRow)
        sleep(60)
        refCont.moveAwayOne(currentRow - depositRow)
        
    elseif currentRow < depositRow then
        refCont.moveAwayOne(depositRow - currentRow)
        sleep(60)
        refCont.moveTowardsOne(depositRow - currentRow)
        
    end
    print("Miner materials deposited")
end
mine.deposit = deposit

local function depositStop(currentRow, depositRow)
    if currentRow == depositRow then
        sleep(45)
    elseif currentRow > depositRow then
        refCont.moveTowardsOne(currentRow - depositRow)
    elseif currentRow < depositRow then
        refCont.moveTowardsOne(depositRow - currentRow)
    end
end
mine.depositStop = depositStop
    
    

local function getMineInt()
    return mineInt
end
mine.getMineInt = getMineInt

local function setMineInt(bool)
    mineInt = stringtoboolean[bool]
end
mine.setMineInt = setMineInt
    

return mine

local controls = require("controls")
local refCont = require("refCont")
local mine = require("mine")
local map = require("map")

local current, deposit, depth = ...
current = tonumber(current)
deposit = tonumber(deposit)
depth = tonumber(depth)
local defInc = 120
local addInc = 10
local inc = 0

refCont.moveAwayOne(16)
local target = map.rowAuto()
print("Going into first loop")
while map.retStatus(1) == false and mine.getMineInt() == false do
    print("first function")
    local miningRow = map.rowAuto()
    print("second function")
    refCont.navTo(miningRow, current)
    sleep(1)
    current = miningRow
    print("Going into second loop")
        while map.retStatus(miningRow) == false do
            mine.startMining(defInc + inc*addInc)
            inc = inc + 1
            mine.deposit(miningRow, deposit)
            if mine.getMineInt() == false then
                map.incDepth(miningRow, defInc*.7)
                sleep(1)
            else
                print("made to break")
                break
        end
    inc = 0
    print("Made to end of primary loop")
end

print("Made to conditional")
if mine.getMineInt() == true then
    print("Mining cancelled. Please use the correct option to restart the miner")
    mine.setMineInt(false)
else
        print("Mining completed! Please move the miner and re-build the table!")
end
end


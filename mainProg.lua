local controls = require("controls")
local refCont = require("refCont")
local map = require("map")
local mine = require("mine")

local current = 16
local deposit = 2
local input = nil
local input2 = nil

repeat
print("Welcome to the mining configurator for the Create miner!")
print("To begin please make a selection below")
print("a - Run Startup (new mining location)")
print("b - Resume mining!")
print("c - Deposit Items mined and pause miner")
print("d - Save and shut down Miner")
print("e - Configure Settings")

local event, id = os.pullEvent("char")
    if id == "a" then
    map.buildStatus()
    elseif id == "b" then
    
    elseif id == "c" then
    mine.deposit(current, deposit)
    elseif id == "d" then
    os.shutdown()
    elseif id == "e" then
        repeat
        print("Please choose what you'd like to configure")
        print("a - Row Status (enter as row, status)")
        print("b - Row Depth (enter as row, depth)")
        print("c - Current miner position (1 being closest, 16 being farthest")
        print("d - Deposit Row")
        print("x - return to main menu")
        local event2, id2 = os.pullEvent("char")
        if id2 == "a" then
            print("Enter the row and then the status")
            input = tonumber(read())
            input2 = read()
                if input < 1 or input > 16 then
                    print("Error, number outside of range")
                elseif input2 ~= true and input2 ~= false then
                    print("Error, invalid entry!")
                else map.updateStatus(row, status)
                end
        elseif id2 == "b" then
            print("Enter the row and then the depth")
            input = tonumber(read())
            input2 = tonumber(read())
                if input < 1 or input > 16 then
                    print("Error, number outside of range!")
                elseif input2 < 1 or input2 > 256 then
                    print("Error, number outside of range!")
                else
                    map.loadDepth()
                    map.setDepth(input, input2)
                end
        elseif id2 == "c" then
            print("Enter the current miner position")
            local pos = tonumber(read())
            if pos < 1 or pos > 16 then
                print("Error, number outside of range!")
            else current = pos
            end
        elseif id2 == "d" then
            print("Enter the deposit row")
            local depo = tonumber(read())
            if depo < 1 or depo > 16 then
                print("Error, number outside of range!")
            else deposit = depo
            end          
        end
        until id2 == "x"
    end
until false

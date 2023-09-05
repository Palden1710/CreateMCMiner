local controls = require("controls")
local refCont = require("refCont")
local map = require("map")
local mine = require("mine")

local current = 16
local deposit = 2
local input = nil
local input2 = nil

repeat
term.clear()
term.setCursorPos(1,1)
print("Welcome to the mining configurator for the Create miner!")
print("To begin please make a selection below")
print(" ")
print("a - Run Startup (new mining location)")
print("b - Resume mining!")
print("c - Deposit Items mined and pause miner")
print("d - Save and shut down Miner")
print("e - Configure Settings")

local event, id = os.pullEvent("char")
    if id == "a" then
    map.buildStatus()
    elseif id == "b" then
    refCont.moveAwayOne(16)
    local minShell = shell.openTab("mineProg", current, deposit, 256)
    elseif id == "c" then
    os.queueEvent("mineInt", true)
    sleep(120)
    mine.depositStop(map.rowAuto(), deposit)
    elseif id == "d" then
    os.queueEvent("mineInt", true)
    sleep(120)
    mine.depositStop(map.rowAuto(), deposit)
    os.shutdown()
    elseif id == "e" then
        repeat
        term.clear()
        term.setCursorPos(1,1)
        print("Please choose what you'd like to configure")
        print(" ")
        print("a - Row Status (enter as row, status)")
        print("b - Row Depth (enter as row, depth)")
        print("c - Current miner position (1 being closest, 16 being farthest")
        print("d - Deposit Row")
        print("e - change outptut locations")
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
        elseif id2 == "e" then
            print("Enter the side connected to the gantry axle")
            local gantSet = read()
            if gantSet ~= "right" or "left" or "front" or "back" or "top" or "bottom" then
                print("Incorrect side entered")
            else
				settings.set("gantryAxle", gantSet)
				print("Now enter the side the gearbox is on")
				local gearSet = read()
				if gearSet ~= "right" or "left" or "front" or "back" or "top" or "bottom" then
					print("Incorrect side entered")
				else
					settings.set("gearbox", gearSet)
					print("Lastly, enter the side the clutch is on")
					local clutchSet = read()
					if clutchSet ~= "right" or "left" or "front" or "back" or "top" or "bottom" then
						print(" Incorrect side entered")
					else settings.set("clutch", clutchSet)
					if settings.save() == true then
						print("Settings saved successfully!")
					else
						print("Something's gone TERRIBLY wrong. Settings not saved :(")
					end
				end
            
			end     
			end
		end
        until id2 == "x"
    end
until false

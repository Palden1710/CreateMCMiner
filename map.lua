local map = {}

local rowDepth = {}
local rowStatus = {}
local defaultRow = 16
local maxDepth = 256

local function buildStatus()
    repeat
        table.insert(rowStatus, false)
    until #rowStatus == 16
    repeat
        table.insert(rowDepth, 1)
    until #rowDepth == 16
    fs.delete("/coords.txt")
    fs.delete("/rowstatus.txt")
    local rowStat = fs.open("/rowstatus.txt", "w")
    rowStat.write(textutils.serialise(rowStatus))
    rowStat.close()
    local rowDepthStat = fs.open("rowdepth.txt", "w")
    rowDepthStat.write(textutils.serialise(rowDepth))
    rowDepthStat.close()
end
map.buildStatus = buildStatus

local function loadStatus()
    local rowStat = io.open("/rowstatus.txt", "r")
    local data = rowStat:read("*a")
    rowStatus = textutils.unserialize(data)
    rowStat:close()
end
map.loadStatus = loadStatus

local function loadDepth()
    local rowDepthStat = fs.open("/rowdepth.txt", "r")
    local data = rowDepthStat.readAll()
    rowDepth = textutils.unserialise(data)
    rowDepthStat.close()
end
map.loadDepth = loadDepth

local function updateStatus(row, status)
    loadStatus()
    rowStatus[row] = status
    local rowStat = fs.open("/rowstatus.txt", "w")
    rowStat.write(textutils.serialise(rowStatus))
    rowStat.close()
end
map.updateStatus = updateStatus

local function printStatus()
    for i = 1, #rowStatus, 1 do
    print(rowStatus[i])
    end
end
map.printStatus = printStatus

local function printDepth()
    for i = 1, #rowDepth, 1 do
    print(rowDepth[i])
    end
end

map.printDepth = printDepth

local function incDepth(row, amount)
    loadDepth() 
    rowDepth[row] = rowDepth[row] + amount
    if rowDepth[row] >= maxDepth then
        updateStatus(row, true)
    end
    rowDepthStat = fs.open("/rowdepth.txt", "w")
    rowDepthStat.write(textutils.serialise(rowDepth))
    rowDepthStat.close()
end
map.incDepth = incDepth

local function setDepth(row, depth)
    loadDepth()
    rowDepth[row] = depth
    if rowDepth[row] >= maxDepth then
        updateStatus(row,true)
    end
    rowDepthStat = fs.open("/rowdepth.txt", "w")
    rowDepthStat.write(textutils.serialise(rowDepth))
    rowDepthStat.close()
end
map.setDepth = setDepth

local function rowAuto()
    loadStatus()
    local i = #rowStatus
    repeat
    if rowStatus[i] == false then
        return i
    end
    i = i-1
    until i < 1
return false
end
map.rowAuto = rowAuto

local function retDepth(row)
    loadDepth()
    return rowDepth[row]
end
map.retDepth = retDepth

local function retStatus(row)
    loadStatus()
    return rowStatus[row]
end
map.retStatus = retStatus

return map

--these can be optimized but ehh
--part 1
local time = {}
local records
for line in love.filesystem.lines("input") do
    if not records then
        for v in string.gmatch(line, "(%d+)") do
            table.insert(time, tonumber(v))
        end
        records = {}
    else
        for v in string.gmatch(line, "(%d+)") do
            table.insert(records, tonumber(v))
        end
    end
end
local total = 1
for i = 1, #time do
    local sum = 0
    for j = 1, time[i] do
        if (time[i] - j) * j > records[i] then
            sum = sum + 1
        end
    end
    total = total*sum
end
print(total)

--part 2
local time = ""
local records
for line in love.filesystem.lines("input") do
    if not records then
        for v in string.gmatch(line, "(%d+)") do
            time = tonumber(time..v)
        end
        records = ""
    else
        for v in string.gmatch(line, "(%d+)") do
            records = tonumber(records..v)
        end
    end
end
local sum = 0
for j = 1, time do
    if (time - j) * j > records then
        sum = sum + 1
    end
end
print(sum)

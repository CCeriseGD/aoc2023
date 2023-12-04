--part 1
local sum = 0
for line in love.filesystem.lines("input") do
    local val = 0.5
    local card, winning = string.match(line, ":(.*)|(.*)")
    for n in string.gmatch(winning, "(%d+)") do
        for m in string.gmatch(card, "(%d+)") do
            if n == m then
                val = val*2
            end
        end
    end
    sum = sum + math.floor(val)
end
print(sum)

--part 2
local sum = 0
local copies = {}
for line in love.filesystem.lines("input") do
    local num = tonumber(string.match(line, "Card%s+(%d+):"))
    copies[num] = (copies[num] or 0) + 1
    local matches = 0
    local card, winning = string.match(line, ":(.*)|(.*)")
    for n in string.gmatch(winning, "(%d+)") do
        for m in string.gmatch(card, "(%d+)") do
            if n == m then
                matches = matches + 1
            end
        end
    end
    for i = 1, matches do
        local idx = num+i
        copies[idx] = (copies[idx] or 0) + copies[num]
    end
    sum = sum + copies[num]
end
print(sum)

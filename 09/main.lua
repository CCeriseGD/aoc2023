--part 1
local sum = 0
for line in love.filesystem.lines("input") do
    local values = {{}}
    for v in string.gmatch(line, "([%d%-]+)") do
        table.insert(values[1], tonumber(v))
    end
    while true do
        table.insert(values, {})
        local allzero = true
        for i = 1, #values[#values-1] - 1 do
            table.insert(values[#values], values[#values-1][i+1] - values[#values-1][i])
            if values[#values][#values[#values]] ~= 0 then
                allzero = false
            end
        end
        if allzero then break end
    end
    for i = #values-1, 1, -1 do
        table.insert(values[i], values[i][#values[i]] + values[i+1][#values[i+1]])
    end
    sum = sum + values[1][#values[1]]
end
print(sum)

--part 2
local sum = 0
for line in love.filesystem.lines("input") do
    local values = {{}}
    for v in string.gmatch(line, "([%d%-]+)") do
        table.insert(values[1], tonumber(v))
    end
    while true do
        table.insert(values, {})
        local allzero = true
        for i = 1, #values[#values-1] - 1 do
            table.insert(values[#values], values[#values-1][i+1] - values[#values-1][i])
            if values[#values][#values[#values]] ~= 0 then
                allzero = false
            end
        end
        if allzero then break end
    end
    for i = #values-1, 1, -1 do
        table.insert(values[i], 1, values[i][1] - values[i+1][1])
    end
    sum = sum + values[1][1]
end
print(sum)

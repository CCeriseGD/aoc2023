--part 1
local sum = 0
for line in love.filesystem.lines("input") do
    local n1, n2
    for i = 1, #line do
        local c1 = string.sub(line, i, i)
        local c2 = string.sub(line, -i, -i)
        if tonumber(c1) and not n1 then
            n1 = c1
        end
        if tonumber(c2) and not n2 then
            n2 = c2
        end
    end
    sum = sum + tonumber(n1..n2)
end
print(sum)

--part 2
local strnum = {
    one = 1,
    two = 2,
    three = 3,
    four = 4,
    five = 5,
    six = 6,
    seven = 7,
    eight = 8,
    nine = 9
}

local sum = 0
for line in love.filesystem.lines("input") do
    local n1, n2
    for i = 1, #line do
        local c1 = string.sub(line, i, i)
        local str13 = string.sub(line, i, i+2)
        local str14 = string.sub(line, i, i+3)
        local str15 = string.sub(line, i, i+4)
        if strnum[str13] or strnum[str14] or strnum[str15] then
            c1 = strnum[str13] or strnum[str14] or strnum[str15]
        end
        local c2 = string.sub(line, -i, -i)
        local str23 = string.sub(line, -i-2, -i)
        local str24 = string.sub(line, -i-3, -i)
        local str25 = string.sub(line, -i-4, -i)
        if strnum[str23] or strnum[str24] or strnum[str25] then
            c2 = strnum[str23] or strnum[str24] or strnum[str25]
        end
        if tonumber(c1) and not n1 then
            n1 = c1
        end
        if tonumber(c2) and not n2 then
            n2 = c2
        end
    end
    sum = sum + tonumber(n1..n2)
end
print(sum)

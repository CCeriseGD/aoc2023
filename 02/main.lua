function split(inputstr, sep)
    local sep = sep or "%s"
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

--part 1
local sum = 0
for line in love.filesystem.lines("input") do
    local game, cubes = unpack(split(line, ":"))
    local id = tonumber(string.sub(game, 6, -1))
    local rounds = split(cubes, ";")
    local possible = true
    for i = 1, #rounds do
        local t = split(rounds[i], ",")
        for j = 1, #t do
            local n, col = unpack(split(t[j]))
            n = tonumber(n)
            if (col == "red" and n > 12) or (col == "green" and n > 13) or (col == "blue" and n > 14) then
                possible = false
                break
            end
        end
    end
    if possible then
        sum = sum + id
    end
end
print(sum)

--part 2
local sum = 0
for line in love.filesystem.lines("input") do
    local game, cubes = unpack(split(line, ":"))
    local id = tonumber(string.sub(game, 6, -1))
    local rounds = split(cubes, ";")
    local min = {red = 0, green = 0, blue = 0}
    for i = 1, #rounds do
        local t = split(rounds[i], ",")
        for j = 1, #t do
            local n, col = unpack(split(t[j]))
            n = tonumber(n)
            min[col] = math.max(min[col], n)
        end
    end
    sum = sum + min.red * min.green * min.blue
end
print(sum)

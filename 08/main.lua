--part 1
local dirs
local nodes = {}
for line in love.filesystem.lines("input") do
    if line ~= "" then
        if not dirs then
            dirs = {}
            for d in string.gmatch(line, "([RL])") do
                table.insert(dirs, d)
            end
        else
            local n, l, r = string.match(line, "(%w%w%w) = %((%w%w%w), (%w%w%w)%)")
            nodes[n] = {L = l, R = r, n = n}
        end
    end
end
local node = "AAA"
local i = 1
while true do
    local idx = ((i-1)%#dirs)+1
    local dir = dirs[idx]
    local n = nodes[node]
    node = n[dir] --skilled
    if node == "ZZZ" then
        print(i)
        break
    end
    i = i + 1
end

--part 2
local dirs
local nodes = {}
local cur = {}
for line in love.filesystem.lines("input") do
    if line ~= "" then
        if not dirs then
            dirs = {}
            for d in string.gmatch(line, "([RL])") do
                table.insert(dirs, d)
            end
        else
            local n, l, r = string.match(line, "(%w%w%w) = %((%w%w%w), (%w%w%w)%)")
            nodes[n] = {L = l, R = r, n = n}
            if string.sub(n, -1, -1) == "A" then
                table.insert(cur, n)
            end
        end
    end
end
local lens = {}
local i = 1
for j = 1, #cur do
    print("start", cur[j])
    while true do
        local idx = ((i-1)%#dirs)+1
        local dir = dirs[idx]
        local n = nodes[cur[j]]
        cur[j] = n[dir] --skilled
        if string.sub(cur[j], -1, -1) == "Z" then
            print("end", cur[j], i)
            table.insert(lens, i)
            i = 1
            break
        end
        i = i + 1
    end
end
--was too lazy to calculate lcm, used a calculator thingy
--11283670395017

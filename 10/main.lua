--part 1
local maze = {}
local s
local y = 1
for line in love.filesystem.lines("input") do
    maze[y] = {}
    for x, c in string.gmatch(line, "()(.)") do
        maze[y][tonumber(x)] = c
        if c == "S" then
            s = {x = tonumber(x), y = y}
        end
    end
    y = y + 1
end

local open = {}
local closed = {}
closed[s.y] = {}
closed[s.y][s.x] = {}
if maze[s.y-1][s.x] == "|" or maze[s.y-1][s.x] == "7" or maze[s.y-1][s.x] == "F" then
    table.insert(open, {x = s.x, y = s.y-1})
end
if maze[s.y+1][s.x] == "|" or maze[s.y+1][s.x] == "J" or maze[s.y+1][s.x] == "L" then
    table.insert(open, {x = s.x, y = s.y+1})
end
if maze[s.y][s.x-1] == "-" or maze[s.y][s.x-1] == "F" or maze[s.y][s.x-1] == "L" then
    table.insert(open, {x = s.x-1, y = s.y})
end
if maze[s.y][s.x+1] == "-" or maze[s.y][s.x+1] == "7" or maze[s.y][s.x+1] == "J" then
    table.insert(open, {x = s.x+1, y = s.y})
end
local d = 1
while true do
    local len = #open
    for i = 1, len do
        local pipe = open[i]
        local c = maze[pipe.y][pipe.x]
        if (c == "|" or c == "J" or c == "L") and not (closed[pipe.y-1] and closed[pipe.y-1][pipe.x]) then
            table.insert(open, {x = pipe.x, y = pipe.y-1})
        elseif (c == "|" or c == "7" or c == "F") and not (closed[pipe.y+1] and closed[pipe.y+1][pipe.x]) then
            table.insert(open, {x = pipe.x, y = pipe.y+1})
        elseif (c == "-" or c == "7" or c == "J") and not (closed[pipe.y] and closed[pipe.y][pipe.x-1]) then
            table.insert(open, {x = pipe.x-1, y = pipe.y})
        elseif (c == "-" or c == "F" or c == "L") and not (closed[pipe.y] and closed[pipe.y][pipe.x+1]) then
            table.insert(open, {x = pipe.x+1, y = pipe.y})
        end
    end
    for i = 1, len do
        closed[open[1].y] = closed[open[1].y] or {}
        closed[open[1].y][open[1].x] = {}
        table.remove(open, 1)
    end
    if #open == 0 then
        print(d)
        break
    end
    d = d + 1
end

--part 2
local beeg = {}

local open = {}
local closed = {}
closed[s.y] = {}
closed[s.y][s.x] = {}
if maze[s.y-1][s.x] == "|" or maze[s.y-1][s.x] == "7" or maze[s.y-1][s.x] == "F" then
    table.insert(open, {x = s.x, y = s.y-1})
end
if maze[s.y+1][s.x] == "|" or maze[s.y+1][s.x] == "J" or maze[s.y+1][s.x] == "L" then
    table.insert(open, {x = s.x, y = s.y+1})
end
if maze[s.y][s.x-1] == "-" or maze[s.y][s.x-1] == "F" or maze[s.y][s.x-1] == "L" then
    table.insert(open, {x = s.x-1, y = s.y})
end
if maze[s.y][s.x+1] == "-" or maze[s.y][s.x+1] == "7" or maze[s.y][s.x+1] == "J" then
    table.insert(open, {x = s.x+1, y = s.y})
end
while true do
    local len = #open
    for i = 1, len do
        local pipe = open[i]
        local c = maze[pipe.y][pipe.x]
        if (c == "|" or c == "J" or c == "L") and not (closed[pipe.y-1] and closed[pipe.y-1][pipe.x]) then
            table.insert(open, {x = pipe.x, y = pipe.y-1})
        elseif (c == "|" or c == "7" or c == "F") and not (closed[pipe.y+1] and closed[pipe.y+1][pipe.x]) then
            table.insert(open, {x = pipe.x, y = pipe.y+1})
        elseif (c == "-" or c == "7" or c == "J") and not (closed[pipe.y] and closed[pipe.y][pipe.x-1]) then
            table.insert(open, {x = pipe.x-1, y = pipe.y})
        elseif (c == "-" or c == "F" or c == "L") and not (closed[pipe.y] and closed[pipe.y][pipe.x+1]) then
            table.insert(open, {x = pipe.x+1, y = pipe.y})
        end
    end
    for i = 1, len do
        closed[open[1].y] = closed[open[1].y] or {}
        closed[open[1].y][open[1].x] = true
        table.remove(open, 1)
    end
    if #open == 0 then
        break
    end
end

for y = 1, #maze[1] do
    beeg[y*2] = {}
    beeg[y*2-1] = {}
    for x = 1, #maze do
        if closed[y] and closed[y][x] then
            beeg[y*2][x*2] = true
            if maze[y][x] == "|" or maze[y][x] == "L" or maze[y][x] == "J" then
                beeg[y*2-1][x*2] = true
            end
            if maze[y][x] == "-" or maze[y][x] == "7" or maze[y][x] == "J" then
                beeg[y*2][x*2-1] = true
            end
        end
    end
end

local open = {{x = 1, y = 1}, {x = 280, y = 280}}
beeg[1][1] = "e"
beeg[280][280] = "e"
beeg[154][49] = "a" --very good bugfix
while true do
    local len = #open
    for i = 1, len do
        local o = open[i]
        if beeg[o.y-1] and not beeg[o.y-1][o.x] then
            table.insert(open, {x = o.x, y = o.y-1})
            beeg[o.y-1][o.x] = "e"
        end
        if beeg[o.y+1] and not beeg[o.y+1][o.x] then
            table.insert(open, {x = o.x, y = o.y+1})
            beeg[o.y+1][o.x] = "e"
        end
        if o.x-1 > 0 and not beeg[o.y][o.x-1] then
            table.insert(open, {x = o.x-1, y = o.y})
            beeg[o.y][o.x-1] = "e"
        end
        if o.x+1 <= #maze[1]*2 and not beeg[o.y][o.x+1] then
            table.insert(open, {x = o.x+1, y = o.y})
            beeg[o.y][o.x+1] = "e"
        end
    end
    for i = 1, len do
        table.remove(open, 1)
    end
    if #open == 0 then
        break
    end
end

local n = 0
for y = 1, #maze[1] do
    for x = 1, #maze do
        if not beeg[y*2][x*2] then
            n = n + 1
        end
    end
end
print(n)

function love.draw()
    for x = 1, 280 do
        for y = 1, 280 do
            if beeg[y][x] == "e" then
                love.graphics.setColor(1, 0, 0)
            elseif beeg[y][x] == "a" then
                love.graphics.setColor(0, 1, 1)
            else
                love.graphics.setColor(1, 1, 1)
            end
            if beeg[y][x] then
                love.graphics.rectangle("fill", x, y, 1, 1)
            end
        end
    end
end

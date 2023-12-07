--part 1
local hands = {}
for line in love.filesystem.lines("input") do
    local hand, bid = string.match(line, "(%w+)%s(%d+)")
    bid = tonumber(bid)
    local counts = {}
    for i = 1, #hand do
        local c = string.sub(hand, i, i)
        counts[c] = (counts[c] or 0) + 1
    end
    local groups = {}
    for k, v in pairs(counts) do
        groups[v] = (groups[v] or 0) + 1
    end
    local t
    if groups[5] == 1 then --five of a kind
        t = 6
    elseif groups[4] == 1 then --four of a kind
        t = 5
    elseif groups[3] == 1 and groups[2] == 1 then --full house
        t = 4
    elseif groups[3] == 1 then --three of a kind
        t = 3
    elseif groups[2] == 2 then --two pairs
        t = 2
    elseif groups[2] == 1 then --one pair
        t = 1
    else --high card
        t = 0
    end
    local v = tonumber(t..hand:gsub("A", "E"):gsub("K", "D"):gsub("Q", "C"):gsub("J", "B"):gsub("T", "A"), 15)
    table.insert(hands, {v = v, bid = bid})
end
function comp(c1, c2)
    return c1.v < c2.v
end
table.sort(hands, comp)
local sum = 0
for i = 1, #hands do
    sum = sum + i * hands[i].bid
end
print(sum)

--part 2
local hands = {}
for line in love.filesystem.lines("input") do
    local hand, bid = string.match(line, "(%w+)%s(%d+)")
    bid = tonumber(bid)
    local counts = {}
    local j = 0
    for i = 1, #hand do
        local c = string.sub(hand, i, i)
        if c == "J" then
            j = j + 1
        else
            counts[c] = (counts[c] or 0) + 1
        end
    end
    local groups = {0, 0, 0, 0, 0}
    for k, v in pairs(counts) do
        groups[v] = groups[v] + 1
    end
    local t
    if hand == "JJJJJ" or groups[5] == 1 or groups[5-j] >= 1 then --five of a kind
        t = 6
    elseif groups[4] == 1 or groups[4-j] >= 1 then --four of a kind
        t = 5
    elseif (groups[3] == 1 and groups[2] == 1) or (j >= 1 and (groups[2] == 2 or groups[3] == 1 and groups[1] > 0)) then --full house
        t = 4
    elseif groups[3] == 1 or groups[3-j] >= 1 then --three of a kind
        t = 3
    elseif groups[2] == 2 or (j >= 1 and groups[2] == 1 and groups[1] > 0) or (j > 1 and groups[1] > 1) then --two pairs
        t = 2
    elseif groups[2] == 1 or groups[2-j] >= 1 then --one pair
        t = 1
    else --high card
        t = 0
    end
    local v = tonumber(t..hand:gsub("A", "E"):gsub("K", "D"):gsub("Q", "C"):gsub("J", "1"):gsub("T", "A"), 15)
    table.insert(hands, {v = v, bid = bid})
end
function comp(c1, c2)
    return c1.v < c2.v
end
table.sort(hands, comp)
local sum = 0
for i = 1, #hands do
    sum = sum + i * hands[i].bid
end
print(sum)

--less than 251207195

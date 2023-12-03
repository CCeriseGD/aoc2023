--part 1
local sum = 0
local prevnums = {}
local prevsyms = {}
for line in love.filesystem.lines("input") do
    local nums = {}
    local syms = {}
    for s, n, e in string.gmatch(line, "()(%d+)()") do
        local e = e - 1
        for i = s, e do
            nums[i] = {n = n, s = s, e = e} 
        end
    end
    for p in string.gmatch(line, "()[^%d%.]") do
        syms[p] = true
    end

    local function removenum(i)
        if nums[i] then
            sum = sum + nums[i].n
            for j = nums[i].s, nums[i].e do
                nums[j] = nil
            end
        end
    end
    local function removeprevnum(i)
        if prevnums[i] then
            sum = sum + prevnums[i].n
            for j = prevnums[i].s, prevnums[i].e do
                prevnums[j] = nil
            end
        end
    end

    for i = 1, #line do
        if prevsyms[i] then
            removenum(i-1)
            removenum(i)
            removenum(i+1)
        end
        if syms[i] then
            removeprevnum(i-1)
            removeprevnum(i)
            removeprevnum(i+1)
            removenum(i-1)
            removenum(i+1)
        end
    end
    prevnums, prevsyms = nums, syms
end
print(sum)

--part 2
local sum = 0
local prevnums = {}
local prevsyms = {}
for line in love.filesystem.lines("input") do
    local nums = {}
    local syms = {}
    for s, n, e in string.gmatch(line, "()(%d+)()") do
        local e = e - 1
        for i = s, e do
            nums[i] = {n = n, s = s, e = e} 
        end
    end
    for p, s in string.gmatch(line, "()([^%d%.])") do
        syms[p] = {gear = s == "*"}
    end

    local function removenum(i)
        if nums[i] then
            local n = nums[i].n
            for j = nums[i].s, nums[i].e do
                nums[j] = nil
            end
            return n
        end
    end
    local function removeprevnum(i)
        if prevnums[i] then
            local n = prevnums[i].n
            for j = prevnums[i].s, prevnums[i].e do
                prevnums[j] = nil
            end
            return n
        end
    end
    local function gearstuff(n, sym)
        if n and type(sym) == "table" and sym.gear then
            if not sym.adj then
                sym.adj = n
            else
                sum = sum + sym.adj*n
            end
        end
        return sym
    end

    for i = 1, #line do
        if prevsyms[i] then
            prevsyms[i] = gearstuff(removenum(i-1), prevsyms[i])
            prevsyms[i] = gearstuff(removenum(i),   prevsyms[i])
            prevsyms[i] = gearstuff(removenum(i+1), prevsyms[i])
        end
        if syms[i] then
            syms[i] = gearstuff(removeprevnum(i-1), syms[i])
            syms[i] = gearstuff(removeprevnum(i),   syms[i])
            syms[i] = gearstuff(removeprevnum(i+1), syms[i])
            syms[i] = gearstuff(removenum(i-1), syms[i])
            syms[i] = gearstuff(removenum(i+1), syms[i])
        end
    end
    prevnums, prevsyms = nums, syms
end
print(sum)

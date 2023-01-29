local day3 = {}

function day3.solve()
    io.input("input")

    local priorities_part1 = 0
    local priorities_part2 = 0
    local lines = {}
    local endloop

    while true do
        for i = 1, 3 do
            lines[i] = io.read("L")
            if not lines[i] then
                endloop = true
                break
            end
            priorities_part1 = priorities_part1 + day3.part1(lines[i])
        end

        if endloop then break end

        priorities_part2 = priorities_part2 + day3.part2(lines)
    end

    return priorities_part1, priorities_part2
end

function day3.char_priority(string, pos)
    if string.byte(string, pos) < 97 then
        return string.byte(string, pos) - 64 + 26
    else
        return string.byte(string, pos) - 96
    end
end

function day3.part1(line)
    local first_half = string.sub(line, 1, #line//2)
    local second_half = string.sub(line, #line//2+1, #line)

    for i = 1,#first_half do
        local char = string.sub(first_half, i, i)

        if string.find(second_half, char) then
            return day3.char_priority(first_half, i)
        end
    end
    
    return 0
end

function day3.part2(lines)
    for i = 1,#lines[1] do
        local char = string.sub(lines[1], i, i)

        if string.find(lines[2], char) then
            if string.find(lines[3], char) then
                return day3.char_priority(lines[1], i)
            end
        end
    end

    return 0
end

print(day3.solve())


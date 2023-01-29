local day4 = {}

function day4.solve ()
    local filename = "input"
    return day4.part1(filename), day4.part2(filename)
end

function day4.create_interval_from_string (string)
    local intervals = {}

    for range in string.gmatch(string, "%d+-%d+") do
        local endpoints = {}
        for i in string.gmatch(range, "%d+") do
            table.insert(endpoints, tonumber(i))
        end
        table.insert(intervals, {left = endpoints[1], right = endpoints[2]})
    end

    return intervals
end

function day4.part1 (filename)
    io.input(filename)

    local count = 0

    for l in io.lines() do
        local intervals = day4.create_interval_from_string(l)

        if intervals[1].left <= intervals[2].left and intervals[1].right >= intervals[2].right then
            count = count + 1
        elseif intervals[1].left >= intervals[2].left and intervals[1].right <= intervals[2].right then
            count = count + 1
        end
    end

    return count
end

function day4.part2 (filename)
    io.input(filename)

    local count = 0

    for l in io.lines() do
        local intervals = day4.create_interval_from_string(l)

        if not (intervals[1].right < intervals[2].left or intervals[1].left > intervals[2].right) then
            count = count + 1
        end
    end

    return count
end

print(day4.solve())

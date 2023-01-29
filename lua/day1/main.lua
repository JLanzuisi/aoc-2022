local day1 = {}

function day1.solve()
    io.input("input")

    local current_elf = 0
    local elfs = {}

    for l in io.lines() do
        if l == "" then
            table.insert(elfs, current_elf)
            current_elf = 0
        else
            current_elf = current_elf + l
        end
    end


    return day1.part1(elfs), day1.part2(elfs)
end

function day1.part1 (t)
    return math.max(table.unpack(t))
end

function day1.part2 (t)
    table.sort(t)
    return t[#t] + t[#t-1] + t[#t-2]
end

print(day1.solve())


local day5 = {}

function day5.solve()
    return day5.part1(), day5.part2()
end

function day5.parse_input(filename)
    io.input(filename)

    local sentinel = "[a]"
    local stacks = {}
    local procedures = {}

    for l in io.lines() do
        local line = string.gsub(l, "    ", sentinel)
        local count = 0
        local procedure_line = {}

        -- construct stacks
        for crate in string.gmatch(line, "%[%g%]") do
            count = count + 1
            if stacks[count] == nil then
                stacks[count] = {}
            end
            if crate ~= sentinel then
                table.insert(stacks[count], crate)
            end
        end

        -- construct list of instructions
        if not string.find(l, "^ %d") then
            for procedure in string.gmatch(l, "%d+") do
                table.insert(procedure_line, tonumber(procedure))
            end

            if string.find(l, "%d+") then
                table.insert(procedures, procedure_line)
            end
        end
    end

    return stacks, procedures
end

function day5.print_top_crate(stacks)
    local result = ""

    for _,v in ipairs(stacks) do
        local s = string.gsub(v[1], "%[", "")
        local s = string.gsub(s, "%]", "")
        result = result .. s
    end

    return result
end

function day5.part1()
    local filename = "input"

    local stacks, procedures = day5.parse_input(filename)

    -- execute the instructions
    for _,inst in ipairs(procedures) do
        for i = 1,inst[1] do
            table.insert(stacks[inst[3]], 1, stacks[inst[2]][1])
            table.remove(stacks[inst[2]], 1)
        end
    end

    return day5.print_top_crate(stacks)

    -- print("Len:" .. #stacks)
    -- for _,v in ipairs(stacks) do
    --     for _,k in ipairs(v) do
    --         print(k)
    --     end
    --     print("=======")
    -- end
    -- for _,v in ipairs(procedures) do
    --     for _,k in ipairs(v) do
    --         print(k)
    --     end
    --     print("=======")
    -- end
end

function day5.part2(filename)
    local filename = "input"

    local stacks, procedures = day5.parse_input(filename)

    -- execute the instructions
    for _,inst in ipairs(procedures) do
        -- print(table.unpack(stacks[1]))
        -- print(table.unpack(stacks[2]))
        -- print(table.unpack(stacks[3]))
        -- print("====================")
        for i = 1,inst[1] do
            table.insert(stacks[inst[3]], 1, stacks[inst[2]][inst[1]-i+1])
            table.remove(stacks[inst[2]], inst[1]-i+1)
        end
    end
    -- print(table.unpack(stacks[1]))
    -- print(table.unpack(stacks[2]))
    -- print(table.unpack(stacks[3]))

    return day5.print_top_crate(stacks)
end

print(day5.solve())
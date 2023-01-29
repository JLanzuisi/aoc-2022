local day6 = {}

function day6.solve()
    return day6.part1(), day6.part2()
end

function day6.find_message(n)
    io.input("input")

    local transmission = io.read("l")
    local marker = ""
    local count = 0
    local pos = 0

    for i in string.gmatch(transmission, "%a") do
        count = count + 1
        pos = string.find(marker, i)
        
        if pos then
            marker = string.sub(marker, pos+1)
        end

        marker = marker .. i

        if string.len(marker) == n then
            break
        end
    end

    return count
end

function day6.part1()
    return day6.find_message(4)
end

function day6.part2()
    return day6.find_message(14)
end

print(day6.solve())
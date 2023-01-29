local day2 = {}

function day2.solve()
    io.input("input")

    local score_part1 = 0
    local score_part2 = 0

    for l in io.lines() do
        score_part1 = score_part1 + day2.round_score_part1(l)
        score_part2 = score_part2 + day2.round_score_part2(l)
    end

    return score_part1, score_part2
end

function day2.winner(n, k)
    if n == k then
        return 3
    elseif n == 1 then
        if k == 3 then
            return 0
        else
            return 6
        end
    elseif n == 2 then
        if k == 1 then
            return 0
        else
            return 6
        end
    elseif n == 3 then
        if k == 2 then
            return 0
        else
            return 6
        end
    end
end

function day2.shape_chosen(n, k)
    if k == 3 then
        return n
    elseif n == 1 then
        if k == 0 then
            return 3
        else
            return 2
        end
    elseif n == 2 then
        if k == 0 then
            return 1
        else
            return 3
        end
    elseif n == 3 then
        if k == 0 then
            return 2
        else
            return 1
        end
    end
end

function day2.round_score_part2(s)
    local p1 = string.byte(s, 1) - 64
    local p2 = (string.byte(s, -1) - 88) * 3
    local score = day2.shape_chosen(p1, p2) + p2
    
    return score
end

function day2.round_score_part1(s)
    local p1 = string.byte(s, 1) - 64
    local p2 = string.byte(s, -1) - 87
    local score = day2.winner(p1, p2) + p2
    
    return score
end

print(day2.solve())


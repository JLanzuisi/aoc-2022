local day7 = {}


function day7.parse_line(line, dir, folders)
    return current_dir
end

function day7.folder_size(folders, intial_val, dirs)
    local size = intial_val
    local subdirs

    print(table.unpack(dirs))
    for _,dir in ipairs(dirs) do
        for name,type in pairs(folders[dir]) do
            if name ~= "parent" then
                if type ~= "dir" then
                    size = size + type
                else
                    subdirs = {}
                    table.insert(subdirs, folders[dir])
                end
            end
        end
    end

    if subdirs then
        return day7.folder_size(folders, size, subdirs)
    else
        return size
    end
end

function day7.part1()
    io.input("example")
    local dir = ""
    local folders = {}
    local result = 0

    for l in io.lines() do
        local word1, word2, word3 = string.match(l, "([^%s]*)%s*([^%s]*)%s*([^%s]*)")
        if word1 == "$" then
            if word2 == "cd" then
                if word3 ~= ".." then
                    if not folders[word3] then
                        folders[word3] = {}
                    end
                    folders[word3].parent = dir
                    dir = word3
                else
                    dir = folders[dir].parent
                end
            end
        else
            if not folders[dir][word2] then
                folders[dir][word2] = word1
            end
        end
    end

    for name,_ in pairs(folders) do
        local size = day7.folder_size(folders, 0, { name } )
        if size < 100000 then
            result = result + size
        end
    end

    return result
    
    -- for namei,i in pairs(folders) do
    --     print(namei)
    --     for namek, k in pairs(i) do
    --         print("  " .. namek)
    --         print("    " .. k)
    --     end
    --     print"=========="
    -- end
end

function day7.part2()
    return "Not implemented"
end

function day7.solve()
    return day7.part1(), day7.part2()
end

print(day7.solve())

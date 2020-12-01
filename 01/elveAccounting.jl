using DelimitedFiles

data = readdlm("01/data.txt", Int)


function task1(list)
    for a ∈ list, b ∈ list
        if a + b == 2020
            return a * b
        end
    end
end

println(task1(data))


function task2(list)
    for a ∈ list, b ∈ list, c ∈ list
        if a + b + c == 2020
            return a * b * c
        end
    end
end

println(task2(data))

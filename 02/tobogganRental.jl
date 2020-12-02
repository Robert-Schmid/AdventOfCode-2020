using DataFrames


function parsePasswords(file)
    data = DataFrame(Min = Int[], Max = Int[], Letter = Char[], Password = String[])
    open(file) do io
        while !eof(io)
            line = readline(io)
            # do the magic
            rm = match(r"(?<min>\d+)-(?<max>\d+) (?<letter>\H): (?<pw>\H+)",line)

            push!(data, (parse(Int, rm[:min]),
                         parse(Int,rm[:max]),
                         rm[:letter][1],
                         rm[:pw]))
        end
    end
    return data
end


function count(c::Char, word::String)::Int64
    n = 0
    for i ∈ word
        if c == i
            n += 1
        end
    end
    return n
end


function valid(pos1, pos2, c::Char, word::String)::Bool
        return (c == word[pos1]) ⊻ (c == word[pos2])
end

data = parsePasswords("02/passwords.txt")
#print(data)
task1 = filter(row -> row.Min <= count(row.Letter, row.Password) <= row.Max, data)
task2 = filter(row -> valid(row.Min, row.Max, row.Letter, row.Password), data)

println("Task 1:")
println(nrow(task1))

println()

println("Task 2:")
println(nrow(task2))

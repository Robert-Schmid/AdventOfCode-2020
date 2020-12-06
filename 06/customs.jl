
function parse_custom_forms(file)
    data = Array{Tuple{String,Int},1}(undef,0)
    tmp = ""
    group_size = 0
    open(file) do io
        while !eof(io)
            line = readline(io)
            if line == ""
                append!(data, [(tmp,group_size)])
                tmp = ""
                group_size = 0
            else
                tmp = string(tmp,line)
                group_size += 1
            end
        end
        append!(data, [(tmp,group_size)])
    end
    return data
end


data = parse_custom_forms("06/customForms.txt")


function unique_chars(s)
    new = ""
    for c ∈ s
        if !occursin(c,new)
            new = string(new,c)
        end
    end
    return new
end

unique = map(x -> unique_chars(first(x)),data)

count = map(length,unique)

total = sum(count)


function at_least((s,n))
    dict = Dict{Char,Int}()
    for c ∈ s
        dict[c] = get(dict, c, 0) + 1
    end
    new = ""
    for (c,i) ∈ dict
        if i ≥ n
            new = string(new,c)
        end
    end
    return new
end

common = map(at_least, data)

task2_count = map(length, common)

task2 = sum(task2_count)

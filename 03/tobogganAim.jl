using DelimitedFiles

rawSlope = readdlm("03/slope.txt", String)

function encode_slope(data)
    slope = zeros(Bool, length(data), length(data[1]))

    m, n = size(slope)

    for i ∈ 1:n , j ∈ 1:m
        if data[j][i] == '#'
            slope[j, i] = true
        end
    end

    return slope
end

slope = encode_slope(rawSlope)


function task1(slope, d, r)
    m, n = size(slope)
    i, j = 1, 1
    trees = 0
    while i <= m
        if slope[i, ((j-1) % n)+1]
            trees += 1
        end
        j += r
        i += d
    end
    return trees
end

println("Number of trees on 1d3r angle:")
println(task1(slope,1,3))


function task2(slope)
    angles = [(1,1) (1,3) (1,5) (1,7) (2,1)]
    trees = Inf
    total = 1
    for i ∈ angles
        d, r = i
        t = task1(slope,d, r)
        total *= t
        trees = min(t, trees)
    end

    return (trees, total)
end

println(task2(slope))

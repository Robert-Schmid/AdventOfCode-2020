using DelimitedFiles
using OffsetArrays

data = readdlm("05/boardingPasses.txt", '\n', String,)


function decode_boardingpass(s::String)
    lower = 0
    upper = 127
    left = 0
    right = 7
    for i ∈ 1:7
        command = s[i]
        diff = ceil((upper - lower)/2)
        if s[i] == 'F'
            upper -= diff
        elseif s[i] == 'B'
            lower += diff
        end
    end
    for i ∈ 8:10
        command = s[i]
        diff = ceil((right - left)/2)
        if s[i] == 'L'
            right -= diff
        elseif s[i] == 'R'
            left += diff
        end
    end

    row = floor(Int, lower)
    column = floor(Int, left)
    id = row * 8 + column

    return (row, column, id)
end


println("Test cases:")
println((70,7,567) == decode_boardingpass("BFFFBBFRRR"))
println((14,7,119) == decode_boardingpass("FFFBBBFRRR"))
println((102,4,820) == decode_boardingpass("BBFFBBFRLL"))


max_id(a,b) = max(a,decode_boardingpass(b)[3])

maxId = foldl(max_id,data,init=0)

println("Maximum Id:")
println(maxId)

# ugly with a bit of manual searching, but who cares it was faster than coding and
# it's Saturday...

plane = ones(Bool,128,8)

plane = OffsetArray(plane,0:127,0:7)

passes = map(x -> setindex!(plane,false,x[1],x[2]),map(decode_boardingpass,data))

a = OffsetArray(plane[7:127,:],7:127,0:7)

findfirst(a)

a[70,2]

70*8+2

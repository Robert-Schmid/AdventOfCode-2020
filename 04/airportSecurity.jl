using DelimitedFiles

data = readdlm("04/passports.txt", '\n', String, skipblanks=false)


function valid_passport_task1(s::String)
    occursin("byr:",s) &&
    occursin("iyr:",s) &&
    occursin("eyr:",s) &&
    occursin("hgt:",s) &&
    occursin("hcl:",s) &&
    occursin("ecl:",s) &&
#    occursin("cid:",s) &&
    occursin("pid:",s)
end

function valid_passport_task2(s::String)
    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    byr = match(r"byr:(?<Year>\d+)",s)

    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    iyr = match(r"iyr:(?<Year>\d+)",s)

    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    eyr = match(r"eyr:(?<Year>\d+)",s)

    # hgt (Height) - a number followed by either cm or in:
        # If cm, the number must be at least 150 and at most 193.
        # If in, the number must be at least 59 and at most 76.
    hgt = match(r"hgt:(?<value>\d+)(?<unit>cm|in)",s)

    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    hcl = match(r"hcl:#(?<value>[0-9|a-f]+)",s)

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    ecl = match(r"ecl:(?<value>\w+)",s)

    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    pid = match(r"pid:(?<id>\d+)",s)

    # cid (Country ID) - ignored, missing or not.

    try
        a = 1920 ≤ parse(Int, byr[:Year]) ≤ 2002
        b = 2010 ≤ parse(Int, iyr[:Year]) ≤ 2020
        c = 2020 ≤ parse(Int, eyr[:Year]) ≤ 2030
        d = (hgt[:unit] == "cm" ? 150 ≤ parse(Int,hgt[:value]) ≤ 193 :
            hgt[:unit] == "in" && 59 ≤ parse(Int,hgt[:value]) ≤ 76)
        e = length(hcl[:value]) == 6
        f = occursin(ecl[:value], "amb blu brn gry grn hzl oth")
        g = length(pid[:id]) == 9

        return a && b && c && d && e && f && g
    catch e
        if isa(e, MethodError)
            return false
        else
            throw(e)
        end
    end
end

function custom_map(f, list)
    acc = ""
    out = Array{Bool}(undef,0)
    for s ∈ list
        if s == ""
            append!(out, f(acc))
            acc = ""
        else
            acc = string(acc," ",s)
        end
    end
    append!(out, f(acc))
    return out
end


valid = custom_map(x -> valid_passport_task1(x), data)

println("Number of valid passports:")
println(sum(valid))


verified = custom_map(x -> valid_passport_task2(x), data)

println("Number of verified passports:")
println(sum(verified))

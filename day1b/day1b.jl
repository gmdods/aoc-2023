#! /usr/local/bin/julia

const NUMBERS = ["one", "two", "three", "four",
        "five", "six", "seven", "eight", "nine"]

function findfirstnames(line::String)
        ranges = filter(!isnothing, findfirst.(NUMBERS, line))
        if isempty(ranges)
                nothing
        else
                minimum(ranges)
        end
end

function findlastnames(line::String)
        ranges = filter(!isnothing, findlast.(NUMBERS, line))
        if isempty(ranges)
                nothing
        else
                maximum(ranges)
        end
end


function calibrate_b(line::String)
        fs = findfirstnames(line)
        fd = findfirst(isdigit, line)
        f = (!isnothing(fd) && (isnothing(fs) || fd < fs.start)) ?
            (line[fd] - '0') : findfirst(==(line[fs]), NUMBERS)
        ls = findlastnames(line)
        ld = findlast(isdigit, line)
        l = (!isnothing(ld) && (isnothing(ls) || ld > ls.stop)) ?
            (line[ld] - '0') : findfirst(==(line[ls]), NUMBERS)
        return 10 * f + l
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day1/example_a.txt"
        local sum = 0
        for line = readlines(file)
                sum += calibrate_b(line)
        end
        println("Sum : ", sum)
end

main()

#! /usr/local/bin/julia

function calibrate_a(line::String)
        f = line[findfirst(isdigit, line)]
        l = line[findlast(isdigit, line)]
        return 10 * (f - '0') + (l - '0')
end


function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day1/example_1a.txt"
        local sum = 0
        for line = readlines(file)
                sum += calibrate_a(line)
        end
        println("Sum : ", sum)
end

main()

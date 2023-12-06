#! /usr/local/bin/julia

include("../day2/parse.jl")

majorize(lhs::RGB, rhs::RGB) =
        RGB(max(lhs.red, rhs.red),
                max(lhs.green, rhs.green), max(lhs.blue, rhs.blue))

power(r::RGB) = UInt(r.red) * UInt(r.green) * UInt(r.blue)

function result_b(line::String)
        game, plays = split(line, ':')
        colours = parse.(RGB, split(plays, ';'))
        power(reduce(majorize, colours))
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day2/example.txt"
        local sum = 0

        for line = readlines(file)
                sum += result_b(line)
        end
        println("Sum : ", sum)
end

main()

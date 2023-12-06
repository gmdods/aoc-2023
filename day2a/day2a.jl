#! /usr/local/bin/julia

include("../day2/parse.jl")

function bounded(lhs::RGB, rhs::RGB)
        (lhs.red <= rhs.red) &
        (lhs.green <= rhs.green) & (lhs.blue <= rhs.blue)
end

function result_a(limit::RGB, line::String)
        game, plays = split(line, ':')
        id = parse(Int, game[findfirst(isdigit, game):end])
        colours = parse.(RGB, split(plays, ';'))
        all(bounded.(colours, limit)) ? id : 0
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day2/example.txt"
        local sum = 0

        limit = RGB(12, 13, 14)
        for line = readlines(file)
                sum += result_a(limit, line)
        end
        println("Sum : ", sum)
end

main()

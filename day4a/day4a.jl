#! /usr/local/bin/julia

include("../aoc.jl")

function part_a(line::String)
	winning, mine = readstring.(split(readvalues(line), '|'))
        index = indexin(mine, winning)
	wins = sum(.!isnothing.(index))
	(wins > 0) ? (2^(wins-1)) : 0
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day4/example_4a.txt"
        local sum = 0

        for line = readlines(file)
                sum += part_a(line)
        end
        println("Sum : ", sum)
end

main()

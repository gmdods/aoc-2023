#! /usr/local/bin/julia

include("../aoc.jl")

function part_b(lines::Vector{String})
	local cards = zeros(Int, length(lines))
	for line = lines
		idstr = readkey(line)[findfirst(isdigit, line):end]
		id = parse(Int, idstr)
		winning, mine = readstring.(split(readvalues(line), '|'))
		index = indexin(mine, winning)
		wins = sum(.!isnothing.(index))
		cards[id .+ (1:wins)] .+= (cards[id] += 1)
	end
	cards
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day4/example_4b.txt"

        lines = readlines(file)
	println("Sum : ", sum(part_b(lines)))
end

main()

#! /usr/local/bin/julia

include("../day4/parse.jl")

function part_b(lines::Vector{String})
        table = readtable.(lines)
	local cards = zeros(Int, length(table))
	for (id, winning, mine) = table
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

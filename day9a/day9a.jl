#! /usr/local/bin/julia

include("../aoc.jl")


function extrapolate_a(history::Vector{Int})
	local remaining = 0
	while !iszero(history)
		remaining += last(history)
		history = diff(history)
	end
	return remaining
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day9/example.txt"

	local sum = 0
	for line = readlines(file)
		sum += extrapolate_a(readstring(line))
	end
	println("Sum : ", sum)
end

main()

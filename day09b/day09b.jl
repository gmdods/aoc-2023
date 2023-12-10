#! /usr/local/bin/julia

include("../aoc.jl")


function extrapolate_b(history::Vector{Int})
	local remaining = 0
	local offset = 0
	while !iszero(history)
		remaining = first(history) - remaining
		history = diff(history)
		offset += 1
	end
	return (offset % 2 == 0) ? -remaining : remaining
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day9/example.txt"

	local sum = 0
	for line = readlines(file)
		sum += extrapolate_b(readstring(line))
	end
	println("Sum : ", sum)
end

main()

#! /usr/local/bin/julia

include("../aoc.jl")

function possibilities_b(time::Int, distance::Int)
	times = (0:time)
	sum(times .* (time .- times) .> distance)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day6/example.txt"

        lines = readlines(file)
	parsed = (line -> parse(Int, filter(!isspace, readvalues(line))))
	time, distance = parsed(lines[1]), parsed(lines[2])
	println("Prod : ", possibilities_b(time, distance))
end

main()

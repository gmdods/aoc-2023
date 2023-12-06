#! /usr/local/bin/julia

spaced(line::AbstractString) = parse.(Int, split(line))
valued(line::AbstractString) = split(line, ':')[2]

function possibilities_a(time::Int, distance::Int)
	times = (0:time)
	sum(times .* (time .- times) .> distance)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day5/example_5a.txt"

        lines = readlines(file)
	parsed = spaced ∘ valued
	time, distance = parsed(lines[1]), parsed(lines[2])
	println("Prod : ", prod(possibilities_a.(time, distance)))
end

main()

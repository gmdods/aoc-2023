#! /usr/local/bin/julia

include("../aoc.jl")

function arrangements_a(layout::Vector{Char}, division::Vector{Int})
	unknown = findall(layout .== '?')
	damaged = (layout .== '#')
	tokens = sum(division) - sum(damaged)

	local num = 0
	accept = copy(damaged)
	for i = UInt(0):UInt((1 << length(unknown))-1)
		count_ones(i) == tokens || continue
		subset = unknown[bitvec(i)[1:length(unknown)]]
		copy!(accept, damaged)
		accept[subset] .= true
		num += (contiguous(accept) == division)
	end
	return num
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day12/example.txt"

	local sum = 0
	for text = readlines(file)
		layout, description = split(text, ' ')
		division = readstring(description, ',')
		sum += arrangements_a(collect(layout), division)
	end
	println("Sum : ", sum)
end

main()

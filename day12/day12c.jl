#! /usr/local/bin/julia

# TIME COMPLEXITY too large for input; Solve differently!

include("../aoc.jl")

function arrangements(damaged::BitVector, unknown::Vector{Int}, division::Vector{Int})
	tokens = sum(division) - sum(damaged)
	width = length(unknown)
	local num = 0
	accept = copy(damaged)
	for i = UInt((1 << tokens) - 1):UInt((1 << width) - 1)
		count_ones(i) == tokens || continue
		subset = unknown[bitvec(i)[1:width]]
		copy!(accept, damaged)
		accept[subset] .= true
		num += (contiguous(accept) == division)
	end
	num
end

function arrangements_b(layout::Vector{Char}, division::Vector{Int})
	unknown = findall(layout .== '?')
	damaged = (layout .== '#')
	depth = length(layout)

	num1 = arrangements(damaged, unknown, division)

	if layout[end] == '.'
		pushfirst!(damaged, false)
		pushfirst!(unknown, 0)
		unknown .+= 1

		num2 = arrangements(damaged, unknown, division)
		return num1 * num2^4
	else
		push!(damaged, false)
		append!(damaged, damaged)
		push!(unknown, depth+1)
		append!(unknown, unknown .+ (depth + 1))
		append!(division, division)

		num2 = arrangements(damaged, unknown, division)
		return num1 * num2^2
	end
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day12/example.txt"

	local sum = 0
	local i = 0
	for text = readlines(file)
		println("I = ", i += 1) # Stops at I = 3
		i < 3 || break
		layout, description = split(text, ' ')
		division = readstring(description, ',')
		sum += arrangements_b(collect(layout), division)
	end
	println("Sum : ", sum)
end

main()

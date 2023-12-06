#! /usr/local/bin/julia

include("../day3/parse.jl")

function part_a(matrix::Matrix{Char})
        digits = isdigit.(matrix)
	symbols = .~(digits .| (matrix .== '.'))
	numbers = contiguous(digits)
	isclose = (i, j) -> checkbounds(Bool, symbols, i, j) && any(symbols[i, j])
	closes = broadcast(index -> neighbours(isclose, index...), numbers)
	part = broadcast(index -> matrix[index[1], index[2]], numbers[closes])
	parse.(Int, String.(part))
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day3/example.txt"

        text = filter(!isempty, readlines(file))
	matrix = reduce(hcat, collect.(text))
	println("Sum : ", sum(part_a(matrix)))
end

main()

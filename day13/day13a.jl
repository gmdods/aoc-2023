#! /usr/local/bin/julia

include("../aoc.jl")

function same(matrix, revert, i; dims)
	ndim = size(matrix, dims)
	w = min(i, ndim - i) - 1
	return selectdim(matrix, dims, (i-w):(i+w+1)) ==
		selectdim(revert, dims, (ndim-i-w):(ndim+1-i+w))
end

function symmetries(matrix::BitMatrix; dims)
	ndim = size(matrix, dims)
	revert = reverse(matrix; dims)
	@assert ndim % 2 == 1
	return sum(i for i = 1:ndim-1 if same(matrix, revert, i; dims); init=0)
end

function symmetry_a(matrix::BitMatrix)
	100 * symmetries(matrix; dims=1) + symmetries(matrix; dims=2)
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day13/example.txt"

	local sum = 0
        for text = partitioned(isempty, readlines(file))
		matrix = BitMatrix(reduce(hcat, collect.(text)) .== '#')
		sum += symmetry_a(permutedims(matrix))
	end
	println("Sum : ", sum)
end

main()

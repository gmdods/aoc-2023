#! /usr/local/bin/julia

include("../aoc.jl")

function mismatch(matrix, revert, i; dims)
	ndim = size(matrix, dims)
	w = min(i, ndim - i) - 1
	sum(selectdim(matrix, dims, (i-w):(i+w+1)) .!=
		selectdim(revert, dims, (ndim-i-w):(ndim+1-i+w)))
end

function offsymmetries(matrix::BitMatrix; dims)
	ndim = size(matrix, dims)
	revert = reverse(matrix; dims)
	@assert ndim % 2 == 1

	for i = 1:ndim-1
		refl = mismatch(matrix, revert, i; dims)
		refl in 1:2 && return i
	end
	return 0
end

function symmetry_b(matrix::BitMatrix)
	return 100 * offsymmetries(matrix; dims=1) + offsymmetries(matrix; dims=2)
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day13/example.txt"

	local sum = 0
        for text = partitioned(isempty, readlines(file))
		matrix = BitMatrix(reduce(hcat, collect.(text)) .== '#')
		sum += symmetry_b(permutedims(matrix))
	end
	println("Sum : ", sum)
end

main()

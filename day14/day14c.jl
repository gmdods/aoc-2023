#! /usr/local/bin/julia

# TIME COMPLEXITY too large for input; Solve differently!

include("../aoc.jl")
include("day14a.jl")

const CYCLES = 1_000_000_000

stacking(x, y) = ((y < 0) ? 0 : (x + (y > 0)))

function tilt(rock::BitMatrix, stop::AbstractMatrix{Bool}, index::AbstractMatrix{Int})
	rows = size(stop, 2)
	stacks = accumulate(stacking, rock .- stop; dims=2, init=0)
	rock .= false
	rock[@view CartesianIndex.(1:rows, index .+ stacks)[rock]] .= true
end


function load_b(matrix::Matrix{Char})
	stop = matrix .== '#'
	ignoring = (x, y) -> ((y == 0) ? x : y)

	cols, rows = size(stop)

	stops = BitArray(undef, (cols, rows, 4))
	for k = 0:3
		stops[:, :, 1+k] = rotr90(stop, k)
	end

	index = Array{Int}(undef, (cols, rows, 4))
	index[:, :, 1] = accumulate(ignoring, (1:rows)' .* stop; dims=2, init=0)
	index[:, :, 2] = accumulate(ignoring, (1:cols)' .* stop; dims=1, init=0)
	index[:, :, 3] = reverse!(accumulate(ignoring,
					reverse!((1:rows)' .* stop; dims=2);
					dims=2, init=0); dims=2)
	index[:, :, 4] = reverse!(accumulate(ignoring,
					reverse!((1:cols)' .* stop; dims=1);
					dims=1, init=0); dims=1)

	index = Array{Int}(undef, (cols, rows, 4))

	rock = matrix .== 'O'
	for i = 1:CYCLES
		i >= 10_000_000 == 0 && break # TOO FAR
		o = 1+mod(i, 4)
		tilt(rock, view(stops, :, :, o), view(index, : ,:, o))
		rock = rotr90(rock)
	end
	load_a(matrix)
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day14/example.txt"

        text = filter(!isempty, readlines(file))
	matrix = reduce(hcat, collect.(text))
	println("Sum : ", sum(load_b(matrix)))
end

main()

#! /usr/local/bin/julia

include("../aoc.jl")

Base.reverse(index::CartesianIndex{2}) = CartesianIndex(index[2], index[1])

const Opt = ["|LJ", "-J7", "|F7", "-LF"]

function corner(c::Char, delta::CartesianIndex{2})
	if c in "|-"
		return 2 * delta[2] # "LJ7F" are half horizontal
	elseif c == 'L'
		return 2 * delta[1] - 1 # 1 => 1, 0 => -1
	elseif c == 'J'
		return -2 * delta[1] + 1 # 1 => -1, 0 => 1
	elseif c == '7'
		return 2 * delta[1] + 1 # -1 => -1, 0 => 1
	elseif c == 'F'
		return -2 * delta[1] - 1 # -1 => 1, 0 => -1
	else
		@assert false
	end
end

function distance_b(area::Matrix{Char})
	nrows, ncols = size(area)
	s = findfirst(==('S'), area)

	neighbours = [
		(s[1] < nrows) ? CartesianIndex(s[1]+1, s[2]+0) : nothing, # 00
		(s[2] < ncols) ? CartesianIndex(s[1]+0, s[2]+1) : nothing, # 01
		(s[1] > 1) ? CartesianIndex(s[1]-1, s[2]-0) : nothing, # 10
		(s[2] > 1) ? CartesianIndex(s[1]-0, s[2]-1) : nothing, # 11
	]
	valids = findall(t -> !isnothing(t) && area[t] != '.', neighbours)

	found = neighbours[findfirst(v -> area[neighbours[v]] in Opt[v], valids)]
	local follow = found
	local delta = follow - s

	A = zeros(Int, size(area))
	B = falses(size(area))
	while follow != s
		c = area[follow]
		B[follow] = true
		A[follow] = corner(c, delta)

		if c in "|-"
			offset = delta
		elseif c in "L7"
			offset = reverse(delta)
		elseif c in "JF"
			offset = -reverse(delta)
		else
			@assert false
		end

		follow = follow + offset
		delta = offset
	end

	A[follow] = (found - s)[2] + delta[2]
	B[follow] = true

	sum(mod.(cumsum(A; dims=1) .÷ 2, 2) .> B)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day10/example_b.txt"

	area = reduce(hcat, collect.(readlines(file))) |> permutedims
	println("Sum : ", distance_b(area))
end

main()

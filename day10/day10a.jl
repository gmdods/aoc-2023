#! /usr/local/bin/julia

include("../aoc.jl")

Base.reverse(index::CartesianIndex{2}) = CartesianIndex(index[2], index[1])

const Opt = ["|LJ", "-J7", "|F7", "-LF"]

function distance_a(area::Matrix{Char})
	nrows, ncols = size(area)
	s = findfirst(==('S'), area)

	neighbours = [
		(s[1] < nrows) ? CartesianIndex(s[1]+1, s[2]+0) : nothing, # 00
		(s[2] < ncols) ? CartesianIndex(s[1]+0, s[2]+1) : nothing, # 01
		(s[1] > 1) ? CartesianIndex(s[1]-1, s[2]-0) : nothing, # 10
		(s[2] > 1) ? CartesianIndex(s[1]-0, s[2]-1) : nothing, # 11
	]
	valids = findall(t -> !isnothing(t) && area[t] != '.', neighbours)

	local follow = neighbours[findfirst(v -> area[neighbours[v]] in Opt[v], valids)]
	local delta = follow - s
	local step = 1
	while follow != s
		c = area[follow]
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
		step += 1
	end
	step÷2
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day10/example_a.txt"

	area = reduce(hcat, collect.(readlines(file))) |> permutedims
	println("Sum : ", distance_a(area))
end

main()

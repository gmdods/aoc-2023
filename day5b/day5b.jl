#! /usr/local/bin/julia

include("../aoc.jl")

within(r::UnitRange{Int}, lim::Int) = (r.stop >= 0) & (r.start < lim)

inrange(r::UnitRange{Int}, lim::Int) =
	[r.start:-1, max(r.start, 0):min(r.stop, lim-1), lim:r.stop]

add(r::UnitRange{Int}, d::Int) = r .+ d

function recurse(start::Vector{UnitRange{Int}}, maps::Vector{Matrix{Int}})
	for map = maps
		dest, src, sets = map[1, :], map[2, :], map[3, :]
		iter = copy(start)
		start = UnitRange{Int}[]
		for _ = 1:4
			!isempty(iter) || break
			offset = broadcast((s, c) -> s .- c, permutedims(iter), src)
			closed = inrange.(offset, sets)
			index = findall(within.(offset, sets))
			if isempty(index)
				continue
			end
			parts = reduce(hcat, closed[index])
			found, pass = getindex.(index, 1), getindex.(index, 2)
			anew  = add.(parts[2, :], dest[found])
			left  = add.(parts[1, :], src[found])
			right = add.(parts[3, :], src[found])
			rest = filter(s -> !(s in pass), 1:length(iter))
			append!(start, [anew; iter[rest]])
			iter = filter(!isempty, [left; right])
		end
		append!(start, iter)
	end
	minimum(start).start
end

function location_b(lines::Vector{String})
	tables = partitioned(isempty, lines)
	(seeds, maps) = Iterators.peel(tables)
	seedling = readstring(readvalues(only(seeds)))
	reseed = reshape(seedling, (2, length(seedling) ÷ 2))
	seeded = range.(reseed[1, :], reseed[1, :] .+ reseed[2, :] .- 1)

	map = [reduce(hcat, readstring.(@view text[2:end])) for text = maps]
	recurse(seeded, map)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day5/example_5a.txt"

        lines = readlines(file)
	println("Min : ", location_b(lines))
end

main()

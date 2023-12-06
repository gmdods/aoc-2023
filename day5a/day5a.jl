#! /usr/local/bin/julia

include("../aoc.jl")

indexable(_::AbstractArray{T}, _::Nothing, default::T) where {T} = default
indexable(A::AbstractArray{T}, i::Int, _::T) where {T} = A[i]

within(r::Int, lim::Int) = (r >= 0) & (r < lim)

function recurse(start::Vector{Int}, maps::Vector{Matrix{Int}})
        for map = maps
                dest, src, sets = map[1, :], map[2, :], map[3, :]
		offset = permutedims(start) .- src
                index = findfirst.(eachcol(within.(offset, sets)))
                start = indexable.(eachcol(offset .+ dest), index, start)
        end
        minimum(start)
end

function location_a(lines::Vector{String})
        tables = partitioned(isempty, lines)
        (seeds, maps) = Iterators.peel(tables)
	seedling = readstring(readvalues(only(seeds)))
        map = [reduce(hcat, readstring.(@view text[2:end])) for text = maps]
        recurse(seedling, map)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day5/example.txt"

        lines = readlines(file)
        println("Min : ", location_a(lines))
end

main()

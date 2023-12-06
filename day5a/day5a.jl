#! /usr/local/bin/julia

include("../day5/parse.jl")

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
        tables = partitioned(lines)
        (seeds, maps) = Iterators.peel(tables)
        seedling = spaced(split(only(seeds), ':')[2])
        map = [reduce(hcat, spaced.(@view text[2:end])) for text = maps]
        recurse(seedling, map)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day5/example_5a.txt"

        lines = readlines(file)
        println("Min : ", location_a(lines))
end

main()

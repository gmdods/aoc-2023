#! /usr/local/bin/julia

include("../aoc.jl")

within(r::UnitRange{Int}, lim::Int) = (r.stop >= 0) & (r.start < lim)

inrange(r::UnitRange{Int}, lim::Int) =
	UnitRange{Int}[r.start:-1, max(r.start, 0):min(r.stop, lim - 1), lim:r.stop]

add(r::UnitRange{Int}, d::Int) = r .+ d

function recurse(start::Vector{UnitRange{Int}}, maps::Vector{Matrix{Int}})
        for map = maps
                dest, src, sets = map[1, :], map[2, :], map[3, :]
                iter = copy(start)
                resize!(start, 0)
                for _ = 1:4
                        !isempty(iter) || break
                        offset = broadcast((s, c) -> s .- c, permutedims(iter), src)
                        index = findall(within.(offset, sets))
                        !isempty(index) || break
                        parts = reduce(hcat, inrange.(offset, sets)[index])
                        found, pass = getindex.(index, 1), getindex.(index, 2)
                        move, keep = dest[found], src[found]

                        remaining = iter[broadcast(s -> !(s in pass), 1:length(iter))]
                        append!(start, add.(parts[2, :], move), remaining)

                        iter = [add.(parts[1, :], keep)
                                add.(parts[3, :], keep)]
                        filter!(!isempty, iter)
                end
        end
        minimum(start).start
end

function location_b(lines::Vector{String})
        tables = partitioned(isempty, lines)
        (seeds, maps) = Iterators.peel(tables)
        seedling = readstring(readvalues(only(seeds)))
        seeded = range.(seedling[1:2:end], seedling[1:2:end] .+ seedling[2:2:end] .- 1)

        map = [reduce(hcat, readstring.(@view text[2:end])) for text = maps]
        recurse(seeded, map)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day5/example.txt"

        lines = readlines(file)
        println("Min : ", location_b(lines))
end

main()

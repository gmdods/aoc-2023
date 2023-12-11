#! /usr/local/bin/julia

function paths_a(space::BitMatrix)
	rows = findall(reduce(&, space; dims=1) |> vec)
	cols = findall(reduce(&, space; dims=2) |> vec)
	galaxies = findall(.~space)
	expansion = (rng, i) -> i + searchsortedfirst(rng, i) - 1
	expanded = broadcast(g -> CartesianIndex(expansion(cols, g[1]), expansion(rows, g[2])),
				galaxies)
	mapreduce(i -> abs(i[1]) + abs(i[2]), +,
		expanded .- permutedims(expanded)) ÷ 2
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day11/example.txt"

        text = filter(!isempty, readlines(file))
	matrix = BitMatrix(reduce(hcat, collect.(text)) .== '.')
	println("Sum : ", sum(paths_a(matrix)))
end

main()

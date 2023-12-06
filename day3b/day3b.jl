#! /usr/local/bin/julia

include("../day3/parse.jl")

function part_b(matrix::Matrix{Char})
        digits = isdigit.(matrix)
        asterisk = findall(matrix .== '*')
        numbers = contiguous(digits)
        isclose = (index, gear) ->
                (gear[1] in neighbours(index[1])) & (index[2] in neighbours(gear[2]))
        closes = isclose.(numbers, permutedims(asterisk))
        gears = (sum(closes; dims=1) .== 2) |> vec |> BitVector

	stringify = index -> matrix[index[1], index[2]]
        part = mapslices(pair -> stringify.(numbers[pair]), closes[:, gears]; dims=1)
        gear_part = parse.(Int, String.(part))
	prod(gear_part; dims=1)
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day3/example.txt"

        text = filter(!isempty, readlines(file))
        matrix = reduce(hcat, collect.(text))
        println("Sum : ", sum(part_b(matrix)))
end

main()

#! /usr/local/bin/julia

function load_a(matrix::Matrix{Char})
	rows = size(matrix, 2)
	ignoring = (x, y) -> ((y == 0) ? x : y)
	index = accumulate(ignoring, (rows-1:-1:0)' .* (matrix .== '#'); dims=2, init=rows)
	stacking = (x, y) -> ((y == '#') ? 0 : (x + (y == 'O')))
	stacks = accumulate(stacking, matrix; dims=2, init=0)
	sum((index .- stacks .+ 1)[matrix .== 'O'])
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day14/example.txt"

        text = filter(!isempty, readlines(file))
	matrix = reduce(hcat, collect.(text))
	println("Sum : ", sum(load_a(matrix)))
end

main()

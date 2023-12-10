#! /usr/local/bin/julia

include("../aoc.jl")


const Map = Dict{Char,Int}('L' => false, 'R' => true)
encode(str::AbstractString) = BitVector(broadcast(s -> Map[s], collect(str)))

const SubStr = SubString{String}
function steps_a(directions::BitVector, walk::Dict{SubStr, Tuple{SubStr, SubStr}})
	local iter = "AAA"
	local steps = 0
	while true
		for dir = directions
			iter = walk[iter][1+dir]
			steps += 1
			(iter == "ZZZ") && return steps
		end
	end
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day8/example_a.txt"

	open(file, "r") do io
		directions = readline(io) .|> encode
		@assert isempty(readline(io))

		delim = collect("= (,)")
		parse = line -> filter(!isempty, split(line, delim))
		fmt = triple -> triple[1] => (triple[2], triple[3])
		walk = Dict(readlines(io) .|> parse .|> fmt)
		println("Sum : ", steps_a(directions, walk))
	end
end

main()

#! /usr/local/bin/julia

include("../aoc.jl")


const Map = Dict{Char,Int}('L' => false, 'R' => true)
encode(str::AbstractString) = BitVector(broadcast(s -> Map[s], collect(str)))

const SubStr = SubString{String}
function steps_b(directions::BitVector, walk::Dict{SubStr,Tuple{SubStr,SubStr}})
	local iters = collect(filter(s -> endswith(s, 'A'), keys(walk)))
        local steps = 0
	local mut = [Dict{SubStr, Vector{Int}}() for _ = eachindex(iters)]
        while true
                for dir = directions
                        steps += 1
                        broadcast!(i -> walk[i][1+dir], iters, iters)
			for (i, iter) = enumerate(iters)
				if (endswith(iter, 'Z'))
					push!(get!(mut[i], iter, Int[]), steps)
				end
			end
                        all(s -> endswith(s, 'Z'), iters) && return steps
                end
		if steps > 1_000_000
			return mapreduce(d -> only(d)[2][1], lcm, mut)
		end
        end
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day8/example_b.txt"

        open(file, "r") do io
                directions = readline(io) .|> encode
                @assert isempty(readline(io))

                delim = collect("= (,)")
                parse = line -> filter(!isempty, split(line, delim))
                fmt = triple -> triple[1] => (triple[2], triple[3])
                walk = Dict(readlines(io) .|> parse .|> fmt)
                println("Sum : ", steps_b(directions, walk))
        end
end

main()

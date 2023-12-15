#! /usr/local/bin/julia

include("../aoc.jl")

function hash_a(ascii::AbstractString)
	local current = UInt(0x0)
	for c = codeunits(ascii)
		current += c
		current *= UInt(17)
		current &= UInt(0xff) # mod 256
	end
	Int(current)
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day15/example.txt"

	local sum = 0
	text = readline(file)
	for ascii = split(text, ',')
		sum += hash_a(ascii)
	end
	println("Sum : ", sum)
end

main()

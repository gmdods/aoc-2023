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

function hash_b(table, ascii::AbstractString)
	i = findfirst(!isletter, ascii)
	@assert !isnothing(i) && i > 1
	label = ascii[1:i-1]
	h = hash_a(label)
	found = findfirst(el -> el[1] == label, table[1+h])

	if ascii[i] == '='
		elt = label => parse(Int, ascii[i+1:end])
		if isnothing(found)
			push!(table[1+h], elt)
		else
			table[1+h][found] = elt
		end
	elseif ascii[i] == '-'
		if !isnothing(found)
			deleteat!(table[1+h], found)
		end
	else
		@assert false
	end
end

function main()
        file = (length(ARGS) > 0) ? ARGS[1] : "day15/example.txt"

	text = readline(file)
	local table = Vector{Vector{Pair{AbstractString, Int}}}(undef, 256)
	for i = eachindex(table)
		table[i] = Int[]
	end
	for ascii = split(text, ',')
		hash_b(table, ascii)
	end
	rank = box -> sum(i * el[2] for (i, el) = enumerate(box); init=0)
	println("Sum : ", sum(broadcast(rank, table) .* eachindex(table)))
end

main()

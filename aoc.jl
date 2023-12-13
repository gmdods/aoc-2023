#! /usr/local/bin/julia

readstring(line::AbstractString) = parse.(Int, split(line))
readstring(line::AbstractString, char::Char) = parse.(Int, split(line, char))
readkey(line::AbstractString) = split(line, ':')[1]
readvalues(line::AbstractString) = split(line, ':')[2]

function contiguous(bit::BitVector)
        sequence = diff(vcat(0, bit, 0))
        findall(sequence .< 0) .- findall(sequence .> 0)
end

function contiguous(positions::Vector{Int}, last)
        range.([0; positions], [positions .- 1; last])
end

function partitioned(by::Pred, lines::Vector{T}) where {Pred<:Function} where {T}
        f = findall(by.(lines))
	r = range.([0; f .+ 1], [f .- 1; length(lines)])
	getindex.(Ref(lines), r)
end

# common idiom
function bitvec(u::UInt)
	r = BitVector(undef, sizeof(u) * 8)
	r.chunks[1] = u
	r
end


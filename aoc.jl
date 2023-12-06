#! /usr/local/bin/julia

readstring(line::AbstractString) = parse.(Int, split(line))
readkey(line::AbstractString) = split(line, ':')[1]
readvalues(line::AbstractString) = split(line, ':')[2]

function partitioned(by::Pred, lines::Vector{T}) where {Pred<:Function} where {T}
        f = findall(by.(lines))
        r = range.([0; f] .+ 1, [f .- 1; length(lines)])
        getindex.(Ref(lines), r)
end



spaced(line::AbstractString) = parse.(Int, split(line))

function partitioned(lines::Vector{String})
        f = findall(isempty.(lines))
        r = range.([0; f] .+ 1, [f .- 1; length(lines)])
        getindex.(Ref(lines), r)
end

indexable(_::AbstractArray{T}, _::Nothing, default::T) where {T} = default
indexable(A::AbstractArray{T}, i::Int, _::T) where {T} = A[i]


within(r::Int, lim::Int) = (r >= 0) & (r < lim)
within(r::UnitRange{Int}, lim::Int) = (r.stop >= 0) & (r.start < lim)


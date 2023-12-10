function contiguous(bit::BitMatrix; dims=2)
        ncols = size(bit, dims)
        pad = falses(1, ncols)
        sequence = diff(vcat(pad, bit, pad); dims=1)
        broadcast((p, n) -> (p[1]:(n[1]-1), p[2]),
                findall(sequence .> 0), findall(sequence .< 0))
end


neighbours(I::UnitRange) = (I.start-1:I.stop+1)
neighbours(I::Int) = I .+ (-1:1)

function neighbours(isok::P, I::UnitRange, J::Int) where {P<:Function}
        A = neighbours(I)
        B = neighbours(J)
        isok(I, B.start) | isok(I, B.stop) |
        any(isok.(A.start, B)) | any(isok.(A.stop, B))
end

struct RGB <: Integer
        red::UInt8
        green::UInt8
        blue::UInt8
        RGB(red, green, blue) = new(red, green, blue)
        RGB(; red=0, green=0, blue=0) = new(red, green, blue)
end

function Base.parse(::Type{RGB}, str::Str) where {Str<:AbstractString}
        fields = split(str, ',')
        space = findlast.(isdigit, fields)
        count = parse.(Int, broadcast((f, s) -> f[1:s], fields, space))
        colours = broadcast((f, s) -> Symbol(replace(f[s+1:end], ' ' => "")), fields, space)
        RGB(; NamedTuple(zip(colours, count))...)
end

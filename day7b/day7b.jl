#! /usr/local/bin/julia

include("../aoc.jl")

const Map = Dict{Char,Int}('A' => 14, 'K' => 13, 'Q' => 12, # 'J' => 11,
        'T' => 10, '9' => 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2,
        'J' => 1)
encode(str::AbstractString) = broadcast(s -> Map[s], collect(str))

function point_b(c::Vector{Int})
        joker = sum(c .== 1)
        equals = broadcast(u -> sum(c .== u), unique(c[c.!=1]))
        !isempty(equals) || return  2 * joker - 1
        equals[argmax(equals)] += joker
        equals = filter(>(1), equals)
        maximum(equals; init=0) + sum(equals) - length(equals)
        # [5] -> 5 + 5 - 1	= 9;
        # [4] -> 4 + 4 - 1	= 7;
        # [3, 2] -> 3 + 5 - 2	= 6;
        # [3] -> 3 + 3 - 1	= 5;
        # [2, 2] -> 2 + 4 - 2	= 4;
        # [2] -> 2 + 2 - 1	= 3;
        # [] -> 0 + 0 - 0	= 0;
end

function winnings(cards::Vector{SubString{String}}, bids::Vector{Int})
        I = sortperm(encode.(cards); lt=(x, y) ->
                let px = point_b(x), py = point_b(y)
                        isless(px, py) || ((px == py) && isless(x, y))
                end)
        bids .* invperm(I)
end

function main()
        local file = (length(ARGS) > 0) ? ARGS[1] : "day7/example.txt"

        lines = readlines(file)
        terms = split.(lines)
        cards = getindex.(terms, 1)
        bids = parse.(Int, getindex.(terms, 2))
        println("Sum : ", sum(winnings(cards, bids)))
end

main()

function readtable(line::String)
        card, numbers = split(line, ':')
        id = parse(Int, card[findfirst(isdigit, card):end])
        winning, mine = split(numbers, '|')
        id, parse.(Int, split(winning)), parse.(Int, split(mine))
end

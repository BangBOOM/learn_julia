using Test

function roman_to_integer(s::AbstractString)::Int
    symbol_value = Dict{Char,Int}([['I', 1], ['V', 5], ['X', 10], ['L', 50], ['C',100],['D', 500],['M', 1000]])
    res = 0
    pre_symbol = NaN
    for symbol in s
        res += symbol_value[symbol]
        if pre_symbol == 'I' && in(symbol, Set(['V', 'X'])) || pre_symbol == 'X' && in(symbol, Set(['L', 'C'])) || pre_symbol == 'C' && in(symbol, Set(['D', 'M']))
            res -= 2symbol_value[pre_symbol]
        end
        pre_symbol = symbol
    end
    return res
end

@testset "13.roman-to-integer.jl" begin
    @test roman_to_integer("III") == 3
    @test roman_to_integer("IV") == 4
    @test roman_to_integer("IX") == 9
    @test roman_to_integer("LVIII") == 58
    @test roman_to_integer("MCMXCIV") == 1994
end
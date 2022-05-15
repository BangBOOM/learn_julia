using Test

function letter_combinations(digits::String)::Vector{String}
    isempty(digits) && return String[]
    digit_str =Dict{Char,String}(
        '2'=>"abc",
        '3'=>"def",
        '4'=>"ghi",
        '5'=>"jkl",
        '6'=>"mno",
        '7'=>"pqrs",
        '8'=>"tuv",
        '9'=>"wxyz"
    )
    res = [""]
    for digit in digits
        res = [s1 * s2 for s1 in res for s2 in digit_str[digit]]
    end
    res
end

@testset "0017.letter-combinations-of-a-phone-number.jl" begin
    @test letter_combinations("23") ==
        ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
    @test isempty(letter_combinations(""))
    @test letter_combinations("8") == ["t", "u", "v"]
end
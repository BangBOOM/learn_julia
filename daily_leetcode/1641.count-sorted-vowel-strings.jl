using Test

function count_vowel_string(n::Int)::Int
    res = [1,1,1,1,1]
    while n > 1
        for i in 2:5
            res[i] += res[i-1]
        end
        n -= 1
    end
    sum(res)
end

@testset "1641.count-sorted-vowel-strings.jl" begin
    @test count_vowel_string(1) == 5
    @test count_vowel_string(2) == 15
    @test count_vowel_string(33) == 66045
end
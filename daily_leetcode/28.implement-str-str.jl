using Test

function str_Str(haystack::String, needle::String) :: Int
    needle_length = length(needle)
    for i in 1:length(haystack) - needle_length + 1
        if haystack[i:i+needle_length-1] == needle
            return i
        end
    end
    return -1
end

@testset "28.implement-str-str.jl" begin
    @test str_Str("hello", "ll") == 3
    @test str_Str("aaaaa", "bba") == -1
    @test str_Str("", "") == 1
    @test str_Str("a", "a") == 1
end
using Test

function is_palindrome(x::Int)::Bool
    if x < 0
        return false
    end

    x_cop = x
    x_rev = 0
    while x_cop > 0
        x_cop, lef = divrem(x_cop, 10)
        x_rev = 10x_rev + lef
    end
    
    x_rev == x
end

@testset "9.palindrome-number.jl" begin
    @test is_palindrome(121) == true
    @test is_palindrome(-121) == false
    @test is_palindrome(10) == false
end
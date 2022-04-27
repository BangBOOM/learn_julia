using Test

function two_sum(nums::Vector{Int}, target::Int)::Union{Nothing,Tuple{Int,Int}}
    seen = Dict{Int,Int}()
    for (index,value) in enumerate(nums)
        number_to_find = target - value
        if haskey(seen,number_to_find)
            return seen[number_to_find], index
        else
            seen[value] = index
        end
    end
end

@testset begin
    @test two_sum([2, 7, 11, 15], 9) == (1, 2)
    @test two_sum([3, 2, 4], 6) == (2, 3)
    @test two_sum([3, 3], 6) == (1, 2)
end


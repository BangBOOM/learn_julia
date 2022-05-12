using Test

function permute_unique(nums::Vector{Int})::Vector{Vector{Int}}
    res = Vector{Vector{Int}}()
    n = length(nums)

    function back_trace(first::Int=1)
        first == n+1 && append!(res,[nums[:]])

        for i in first:n
            nums[i] in nums[first:i-1] && continue
            nums[first],nums[i] = nums[i],nums[first]
            back_trace(first+1)
            nums[first],nums[i] = nums[i],nums[first]
        end
    end
    back_trace()
    return res
end

@testset "47.permutations_2.jl" begin
    @test permute_unique([1,1,2]) == [[1,1,2],[1,2,1],[2,1,1]]
end

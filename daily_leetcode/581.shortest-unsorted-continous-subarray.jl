using Test

function find_unsorted_subarray(nums::Vector{Int})::Int
    min_value = last(nums)
    start_idx = 0
    for idx in length(nums):-1:1
        nums[idx] > min_value ? start_idx = idx : min_value = nums[idx]
    end

    max_value = first(nums)
    end_idx = 0
    for idx in 1:length(nums)
        nums[idx] < max_value ? end_idx = idx + 1 : max_value = nums[idx]
    end

    end_idx - start_idx
end


@testset "581.shortest-unsorted-continous-subarray.jl" begin
    @test find_unsorted_subarray([2,6,4,8,10,9,15]) == 5
    @test find_unsorted_subarray([1,2,3,4]) == 0
    @test find_unsorted_subarray([1]) == 0
    @test find_unsorted_subarray([18, 17, 1, 12, 10, 9, 19, 2, 11, 28, 7, 21, 8, 3, 27, 30,
    0, 14, 26, 4, 15, 29, 6, 16, 20, 24, 23, 5, 13, 25, 22]) ==
31
end
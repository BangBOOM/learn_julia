using Test
function remove_duplicates1!(nums::Vector{Int})::Int
    pre = nothing
    idx = 1
    for n in nums 
        if n != pre
            nums[idx] = n
            pre = n
            idx += 1
        end
    end
    return idx-1
end


@testset "26.remove-duplicates-from-sorted-array.jl" begin
    nums1 = [1, 1, 2]
    @test remove_duplicates1!(nums1) == 2 && nums1[1: 2] == [1, 2]
    nums2 = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
    @test remove_duplicates1!(nums2) == 5 && nums2[1: 5] == [0, 1, 2, 3, 4]
end

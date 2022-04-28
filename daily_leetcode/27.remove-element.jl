using Test

function remove_element!(nums::Vector{Int}, val::Int)::Int
    i = 1
    for n in nums
        if n != val
            nums[i] = n
            i += 1
        end
    end
    return i-1
end


@testset "27.remove-element.jl" begin
    nums1 = [3, 2, 2, 3]
    nums2 = [0, 1, 2, 2, 3, 0, 4, 2]
    nums3 = [1, 2, 3, 4]
    @test remove_element!(nums1, 3) == 2 && nums1[1:2] == [2, 2]
    @test remove_element!(nums2, 2) == 5 && nums2[1:5] == [0, 1, 3, 0, 4]
    @test remove_element!(nums3, 0) == 4 && nums3[1:4] == [1, 2, 3, 4]
end

using Test

function longest_common_prefix(strs::Array{String,1})::String
    prefix = ""
    for v in zip(strs...)
        if all(v .== v[1])
            prefix *= v[1]
        else
            break
        end
    end
    prefix
end

@testset "14.longest-common-prefix.jl" begin
    @test longest_common_prefix(["flower", "flow", "flight"]) == "fl"
    @test longest_common_prefix(["dog", "racecar", "car"]) == ""
    @test longest_common_prefix(["reflower", "flow", "flight"]) == ""
end
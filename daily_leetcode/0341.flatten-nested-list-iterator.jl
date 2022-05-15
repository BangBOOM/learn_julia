using Test

function flatten_vector(x::Vector{Any})::Vector{Any}
    res = []
    while ! isempty(x)
        last_one = pop!(x)
        typeof(last_one) <: Vector ? append!(x,last_one) : append!(res,last_one) 
    end
    reverse!(res)
end

@testset "0341.flatten-nested-list-iterator.jl" begin
    @test flatten_vector([[1,1],2,[1,1]]) == [1,1,2,1,1]
    @test flatten_vector([1,2,[3,[4,[5,[6,7,8]]]]]) == [1,2,3,4,5,6,7,8]
end
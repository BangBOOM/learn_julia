using Test

function combination_sum(k::Int, n::Int)::Vector{Vector{Int}}
    n<sum(1:k) || n>sum(9:-1:10-k) && return []
    q1 = [[i] for i in 1:10-k]
    q2 = []

    for i in 1:k-1
        while ! isempty(q1)
            x = popfirst!(q1)
            append!(
                q2,
                [x...,j] for j in x[end]+1:10-k+i
            )
        end
        q1 = q2
        q2 = []
    end
    filter(x->sum(x)==n,q1)
end


@testset "0216.combination_sum_3.jl" begin
    @test combination_sum(3,7) == [[1,2,4]]
    @test combination_sum(3,9) == [[1,2,6],[1,3,5],[2,3,4]]
    @test combination_sum(4,1) == []
    @test combination_sum(9,46) == []
    @test combination_sum(9,45) == [[1,2,3,4,5,6,7,8,9]]
end
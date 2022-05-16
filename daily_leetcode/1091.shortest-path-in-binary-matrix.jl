using Test

function shortest_path_binary_matrix(grid::Vector{Vector{Int}})::Int
    grid[1][1]==0 || return -1

    n = length(grid)

    queue = [(1,1)]
    labeled = fill(-1, n, n)
    labeled[1,1] = 1
    while ! isempty(queue)
        x,y = popfirst!(queue)
        for (i,j) in [(-1,-1),(-1,0),(-1,1),(1,1),(1,0),(1,-1),(0,1),(0,-1)]
            if 0<x+i<=n && 0<y+j<=n && grid[x+i][y+j] == 0 && labeled[x+i,y+j] == -1
                labeled[x+i,y+j] = labeled[x,y] + 1
                append!(queue,[(x+i,y+j)])
            end
        end

    end
    labeled[end,end]

end

@testset "1091.shortest-path-in-binary-matrix.jl" begin
    @test shortest_path_binary_matrix([[0,1],[1,0]]) == 2
    @test shortest_path_binary_matrix([[0,0,0],[1,1,0],[1,1,0]]) == 4
    @test shortest_path_binary_matrix([[1,0,0],[1,1,0],[1,1,0]]) == -1
end
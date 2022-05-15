using Test
using DataStructures

mutable struct DQStack{T}
    queue1::Deque{T}
    queue2::Deque{T}

    DQStack{T}() where T = new(Deque{T}(),Deque{T}())
end

function Base.push!(s::DQStack,val::Any)
    push!(s.queue2, val)
    while !isempty(s.queue1)
        push!(s.queue2,popfirst!(s.queue1))
    end
    s.queue1,s.queue2 = s.queue2, s.queue1
end


Base.pop!(s::DQStack) = popfirst!(s.queue1)

top(s::DQStack) = first(s.queue1)

Base.isempty(s::DQStack) = isempty(s.queue1)


@testset "0225.implement-stack-using-queues.jl" begin
    qs = DQStack{Int}()
    @test isempty(qs) == true
    push!(qs,1)
    push!(qs,2)
    @test pop!(qs) == 2
    push!(qs,3)
    push!(qs,4)
    @test pop!(qs) == 4
    @test isempty(qs) == false
end
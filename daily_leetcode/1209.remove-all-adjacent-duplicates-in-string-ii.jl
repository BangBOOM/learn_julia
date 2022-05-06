using Test

function remove_duplicates(s::String, k::Integer)::String
    str_stack = Vector{Union{Nothing,Char}}(nothing,1)
    cnt_stack = Vector{Int}(undef,1)
    for c in s
        last(str_stack) == c ? cnt_stack[end] += 1 : (push!(str_stack, c); push!(cnt_stack,1))
        last(cnt_stack) == k ? (pop!(cnt_stack); pop!(str_stack)) : ()
    end

    join([repeat(a,b) for (a,b) in zip(str_stack[2:end], cnt_stack[2:end])])

end

@testset "1209.remove-all-adjacent-duplicates-in-string-ii.jl" begin
    @test remove_duplicates("abcd", 2) == "abcd"
    @test remove_duplicates("deeedbbcccbdaa", 3) == "aa"
    @test remove_duplicates("pbbcggttciiippooaais", 2) == "ps"
end
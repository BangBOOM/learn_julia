using Test

function is_valid_parentheses(s::String)::Bool
    parent_map = Dict{Char,Char}('[' => ']', '(' => ')', '{' => '}')
    p_stack = Vector{Char}()
    for c in s
        if haskey(parent_map,c)
            push!(p_stack, c)
        else
            if isempty(p_stack) || parent_map[last(p_stack)] != c
                return false
            end
            pop!(p_stack)
        end
    end
    return isempty(p_stack)
end

@testset "0020.valid-parentheses.jl" begin
    @test is_valid_parentheses("()") == true
    @test is_valid_parentheses("()[]{}") == true
    @test is_valid_parentheses("(]") == false
    @test is_valid_parentheses("([)]") == false
    @test is_valid_parentheses("{[]}") == true
end

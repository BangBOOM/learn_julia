using Test
using Base

mutable struct ListNode{T}
    val::T
    next::Union{ListNode{T},Nothing}
    ListNode{T}() where {T} = (x=new();x.next=nothing;x)
    ListNode{T}(value::T, next::Union{ListNode{T},Nothing}) where T = new(value,next)
    ListNode{T}(values::Vector{T}) where T = (
        head = x = new();
        for val in values
            x.next = new(val,nothing)
            x = x.next
        end;
        head.next
    )
end


function next(node::ListNode{T}) where T
    node.next
end

Base.:(==)(l1::ListNode{Int},l2::ListNode{Int}) = (
    if isnothing(l1) && isnothing(l2) && l1.val == l2.val
        true
    elseif (isnothing(l1) && !isnothing(l2)) || (! isnothing(l1) && isnothing(l2)) || (l1.val != l2.val)
        false
    else
        next(l1) == next(l2)
    end
)


function merge_two_lists(
    list1::Union{ListNode,Nothing}, list2::Union{ListNode,Nothing})::Union{ListNode,Nothing}
    isnothing(list1) && isnothing(list2) && return nothing
    node = fake_head = ListNode{Int}()
    while !(isnothing(list1) || isnothing(list2))
        if list1.val < list2.val
            node.next = list1
            list1 = next(list1)
        else
            node.next = list2
            list2 = next(list2)
        end
        node = next(node)
    end

    node.next = isnothing(list1) ? list2 : list1
    return next(fake_head)
end

@testset "21.merge-two-sorted-lists.jl" begin
    list1 = ListNode{Int}([1, 2, 4])
    list2 = ListNode{Int}([1, 3, 4])
    expected = ListNode{Int}([1, 1, 2, 3, 4, 4])
    @test merge_two_lists(list1, list2) == expected
    @test merge_two_lists(nothing, ListNode{Int}(0,nothing)) == ListNode{Int}(0,nothing)
    @test merge_two_lists(nothing, nothing) === nothing
end
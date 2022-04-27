mutable struct ListNode{T}
    val::T
    next::Union{ListNode{T}, Nothing}

    ListNode{T}() where T = (x = new();x.next=nothing;x)
    ListNode{T}(value::T,next::Union{ListNode{T},Nothing}) where T = new(value,next)
    ListNode{T}(values::Vector{T}) where T = (
        head = x = new();
        for val in values
            x.next = new(val,nothing)
            x = x.next
        end;
        head.next
    )
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
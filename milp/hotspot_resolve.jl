using JuMP
using HiGHS
using DataFrames

function cal_c(omega::Int, lx::Int)::BigFloat
    if lx == 0 || lx == omega
        return 1.0 / big(2)^omega
    end

    c = omega * log(omega / 2 / (omega - lx)) + lx * log((omega - lx) / lx)
    c = exp(c)
    c = c * √(omega / (omega - lx) / lx)
    c = c / √(2π)
    return big(c)
end

function probability_given_n_gamma(n::Int, gamma::Int)::Float64
    v = (n + gamma) / 2.0
    v_f = Int(floor(v))
    μ = v - v_f
    formula_part1 = (1 - μ) * cal_c(n, v_f)
    formula_part2 = sum(cal_c(n, ll) for ll in v_f+1:n)
    return formula_part1 + formula_part2
end

function robust(n::Int)::DataFrame
    df = DataFrame(
        n=[j for j in 1:n for i in 0:j-1],
        g=[i for j in 1:n for i in 0:j-1],
        p=[probability_given_n_gamma(j, i) for j in 1:n for i in 0:j-1]
    )
    return df
end

function milp_solver(vm_count::Int, p_violate::Float64)
    gr_frame = robust(vm_count)
    gr_frame = gr_frame[gr_frame.p.<p_violate, :]

    for i in 1:first(gr_frame.n)-1
        push!(gr_frame, [i, i, 0])
    end

    gamma = [last(gr_frame[gr_frame.n.==i, 2]) for i in 1:vm_count]

    uc = rand(Float64, vm_count) * 30 .+ 5
    ur = rand(Float64, vm_count) .* rand(Float64, vm_count)

    mem = rand(Float64, vm_count) * 50 .+ 20
    max_ur = maximum(ur)
    cap = 1500

    model = Model(HiGHS.Optimizer)
    @variable(model, kvm[1:vm_count], Int)
    @variable(model, x[1:vm_count], Bin)
    @variable(model, y[1:vm_count], Bin)
    @variable(model, s, lower_bound = 0.0)
    @constraint(model, [i in 1:vm_count], x[i] + y[i] <= 1)
    @constraint(model, sum(x .+ y) == transpose(1:vm_count) * kvm)
    @constraint(model, sum(y) == transpose(gamma) * kvm)
    @constraint(model, [i in 1:vm_count], s >= x[i] * ur[i])
    @constraint(model, [i in 1:vm_count], max_ur - s >= y[i] * (max_ur) - ur[i])
    @constraint(model, sum((x .+ y) .* uc + y .* ur) <= cap)
    @objective(model, Max, sum((x .+ y) .* mem))

    optimize!(model)

    println(value.(x))
    println(value.(y))
end


# milp_solver(50, 0.02)


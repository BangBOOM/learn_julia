using JuMP, GLPK

m = Model(GLPK.Optimizer)
A = [-1 1 3
    1 3 -7]

b = [-5; 10]

c = [1; 2; 5;]

@variable(m, x[1:3] >= 0)
@constraint(m, bound, x[1] <= 10)

@constraint(
    m,
    constraint[j in 1:2],
    transpose(A[j, :]) * x <= b[j]
)

@objective(m, Max, transpose(c) * x)

optimize!(m)

println("Optimal Solutions:")
for i in 1:3
    println("x[$i] = ", value(x[i]))
end

println("Dual Variables:")
for j in 1:2
    println("dual[$j] = ", shadow_price(constraint[j]))
end

# @variable(m, 0 <= x1 <= 10)
# @variable(m, 0 <= x2)
# @variable(m, 0 <= x3)

# @objective(m, Max, x1 + 2x2 + 5x3)

# @constraint(m, constraint1, -x1 + x2 + 3x3 <= -5)
# @constraint(m, constraint2, x1 + 3x2 - 7x3 <= 10)

# print(m)

# optimize!(m)

# println("Optimal Solutions:")
# println("x1 = ", value(x1))
# println("x2 = ", value(x2))
# println("x3 = ", value(x3))

# println("Dual Variables:")
# println("dual1 = ", shadow_price(constraint1))
# println("dual2 = ", shadow_price(constraint2))

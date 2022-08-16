using JuMP, GLPK

m = Model(GLPK.Optimizer)
@variable(m, 0 <= x1 <= 10)
@variable(m, x2 >= 0, Int)
@variable(m, x3, Bin)

@objective(m, Max, x1 + 2x2 + 5x3)

@constraint(m, constraint1, -x1 +  x2 + 3x3 <= -5)
@constraint(m, constraint2,  x1 + 3x2 - 7x3 <= 10)

print(m)

optimize!(m)

@show dual_status(m)
@show value(x1)
@show value(x2)
@show value(x3)
@show shadow_price(constraint1)
@show shadow_price(constraint2)

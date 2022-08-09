function LinearRegression(X, y, lr, iterate_nums)
    X = hcat(X, ones(Float64,(size(X)[1],1)))
    θ = zeros(Float64, size(X)[2])
    for i = 1:iterate_nums
        y_hat = X * θ
        θ = θ - lr * transpose(transpose(y_hat - y) * X)
    end
    return θ
end



train_x = [1. 1.; 1. 2.; 2. 2.;2. 3.]
train_y = train_x * [1.,2.] .+ 3.

theta = LinearRegression(train_x, train_y, 0.05, 2000)

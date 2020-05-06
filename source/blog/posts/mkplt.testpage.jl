
# This is not a good Julia script,
# just a quick and dirty 3d plot

using Plots
theme(:juno)
plotly()

# Create arrays
x = Float64[]
y = Float64[]
z = Float64[]

function myrand()::Float64
    return 2.0 * rand() - 1.0
end

# set initial values
push!(x, myrand())
push!(y, myrand())
push!(z, myrand())

for _ in 1:100
    push!(x, x[end] + myrand())
    push!(y, y[end] + myrand())
    push!(z, z[end] + myrand())
end

plot3d(x, y, z)
savefig("test.html")

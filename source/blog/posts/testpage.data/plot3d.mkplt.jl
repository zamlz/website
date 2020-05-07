
# This is not a good Julia script,
# just a quick and dirty 3d plot

using Random
using Plots
theme(:solarized)
plotly()

OUTFILE = ARGS[1]

function myrand()::Float64
    return 2.0 * rand() - 0.9
end

function create_xyz()

    # Create arrays
    x = Float64[]
    y = Float64[]
    z = Float64[]

    # set initial values
    push!(x, myrand())
    push!(y, myrand())
    push!(z, myrand())

    for _ in 1:30
        push!(x, x[end] + myrand())
        push!(y, y[end] + myrand())
        push!(z, z[end] + myrand())
    end

    return x, y, z
end

x, y, z = create_xyz()
plot3d(x, y, z,
    plot_title="3D Random Walk",
    background_color=:black,
    background_outside_color=:black,
    background_color_legend=:black,
    foreground_color=:white,
    foreground_color_subplot=:white,
)
x, y, z = create_xyz()
plot3d!(x, y, z)
x, y, z = create_xyz()
plot3d!(x, y, z)
x, y, z = create_xyz()
plot3d!(x, y, z)

savefig(OUTFILE)

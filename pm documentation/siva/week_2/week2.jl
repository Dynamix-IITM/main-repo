# Uncomment the following to use Plots package
#using Pkg
#Pkg.add("Plots")

using Plots
Plots.default(show = true)

# Taking initial values
println("Enter a0, m0, k1, k2, n, x limit, and delta x separated by spaces: ")
inputs = split(readline())
a0 = parse(Float64, inputs[1])
m0 = parse(Float64, inputs[2])
k1 = parse(Float64, inputs[3])
k2 = parse(Float64, inputs[4])
n  = parse(Float64, inputs[5])
x  = parse(Float64, inputs[6])
del_x = parse(Float64, inputs[7])

# Calculate number of iterations
iter = Int(x / del_x)

# Initialize arrays
a = zeros(Float64, iter+1)
m = zeros(Float64, iter+1)
s = zeros(Float64, iter+1)
a[1]=a0
m[1]=m0
s[1] = 1.0 - (a[1] + m[1])

# Iterate to fill arrays (solving the DEs)
for i in 1:iter
    a[i+1] = (1 - a[i] - m[i] - k1 * (m[i]^2) * a[i]) * del_x + a[i]
    m[i+1] = (k1 * (m[i]^2) * a[i] + k2 * (m[i]^n) * (a[i] - 1 + m[i])) * del_x + m[i]
    s[i+1] = 1.0 - (a[i+1] + m[i+1])
end

# x-axis values
x_values = 0:del_x:x

# Plot a vs time
plot(x_values, a, label="Atomic Fraction (a)", xlabel="x ∝ time", ylabel="Atomic Fraction (a)", title="a vs time", xlim=(0,50), markersize=15)
savefig("a_vs_time.png")

# Plot m vs time
plot(x_values, m, label="Molecular Fraction (m)", xlabel="x ∝ time", ylabel="Molecular Fraction (m)", title="m vs time", xlim=(0,50), markersize=15)
savefig("m_vs_time.png")

# Plot s vs time
plot(x_values, s, label="Stellar Fraction (s)", xlabel="x ∝ time", ylabel="Stellar Fraction (s)", title="s vs time", xlim=(0,50), markersize=15)
savefig("s_vs_time.png")

# Plot a vs m
plot(m, a, label="Atomic Fraction (a) vs Molecular Fraction (m)", xlabel="Molecular Fraction (m)", ylabel="Atomic Fraction (a)", title="a vs m", markersize=15)
savefig("a_vs_m.png")

# Plot a vs s
plot(s, a, label="Atomic Fraction (a) vs Stellar Fraction (s)", xlabel="Stellar Fraction (s)", ylabel="Atomic Fraction (a)", title="a vs s", markersize=15)
savefig("a_vs_s.png")

# Plot s vs m
plot(m, s, label="Molecular Fraction (m) vs Stellar Fraction (s)", xlabel="Molecular Fraction (m)", ylabel="Stellar Fraction (s)", title="s vs m", markersize=15)
savefig("s_vs_m.png")

# Uncomment to plot 3D Plot of a, m, s
#plot(a, m, s, seriestype = :scatter3d, label="3D Plot of a, m, s", xlabel="Atomic Fraction (a)", ylabel="Molecular Fraction (m)", zlabel="Stellar Fraction (s)", title="3D Plot of a, m, s")
#savefig("3d_plot.png")
#gui()
#wait()  # Wait until all plots are closed
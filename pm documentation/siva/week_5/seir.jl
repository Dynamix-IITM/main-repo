using Plots

# Taking initial values
println("Enter S0, E0, I0, R0, β, γ, μ, a, t_limit, and delta_t separated by spaces: ")
inputs = split(readline())
S0 = parse(Float64, inputs[1])
E0 = parse(Float64, inputs[2])
I0 = parse(Float64, inputs[3])
R0 = parse(Float64, inputs[4])
β  = parse(Float64, inputs[5])
γ  = parse(Float64, inputs[6])
μ  = parse(Float64, inputs[7])
a  = parse(Float64, inputs[8])
t_limit  = parse(Float64, inputs[9])
delta_t = parse(Float64, inputs[10])

# Calculate number of iterations
iter = Int(t_limit / delta_t)

# Initialize arrays
S = zeros(Float64, iter+1)
E = zeros(Float64, iter+1)
I = zeros(Float64, iter+1)
R = zeros(Float64, iter+1)
N = S0 + E0 + I0 + R0

S[1] = S0
E[1] = E0
I[1] = I0
R[1] = R0

# Iterate to fill arrays (solving the DEs)
for i in 1:iter
    S[i+1] = S[i] + (μ * N - μ * S[i] - β * S[i] * I[i] / N) * delta_t
    E[i+1] = E[i] + (β * S[i] * I[i] / N - (μ + a) * E[i]) * delta_t
    I[i+1] = I[i] + (a * E[i] - (γ + μ) * I[i]) * delta_t
    R[i+1] = R[i] + (γ * I[i] - μ * R[i]) * delta_t
end

# Calculate R_0
R_0 = β * (1 / (μ + γ)) * (a / (a + γ))

# Time values
t_values = 0:delta_t:t_limit

# Plot S, E, I, R vs time in one graph with different colors
plot(t_values, S, label="Susceptible (S)", xlabel="Time", ylabel="Population", title="SEIR Model", color=:blue, legend=:outertopright)
plot!(t_values, E, label="Exposed (E)", color=:orange)
plot!(t_values, I, label="Infectious (I)", color=:red)
plot!(t_values, R, label="Recovered (R)", color=:green)

# Combine all the R₀ values into a single text block
r0_text = "S(0) = $(round(S0, digits=2))\n" *
          "E(0) = $(round(E0, digits=2))\n" *
          "I(0) = $(round(I0, digits=2))\n" *
          "R(0) = $(round(R0, digits=2))\n\n" *
          "R₀ = $(round(R_0, digits=2))"

# Annotate the plot with the text block and position it under the legend
annotate!(4.5*t_limit/4, N/4, text(r0_text, :left, 12, :black))

savefig("SEIR_model.png")

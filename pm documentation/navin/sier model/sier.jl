using DifferentialEquations
using Plots

# parameters are constant for now, should in reality be functions of the state
μ = 2 
α = 3 
β = 12
γ = 1

# basic reproduction number for the system
R₀ = α/(μ + α) * β/(μ + γ)

"""
du - state differentials 

u - state of the population [S; I; E; R; N]

p - parameters governing the model [μ; α; β; γ]
"""
function sier!(du, u, p, t)
    du[1] = p[1] * u[5] - p[1] * u[1] - p[3] * u[1] * u[3] / u[5] 
    du[2] = p[3] * u[1] * u[3] / u[5] - (p[1] + p[2]) * u[2]
    du[3] = p[2] * u[2] - (p[4] + p[1]) * u[3]
    du[4] = p[4] * u[3] - p[1] * u[4]
    du[5] = 0  # assume death rate = birth rate
end

# set up the model with initial conditions
u0 = [2, 1, 0, 0, 3]
tspan = (0.0, 10.0)
prob = ODEProblem(sier!, u0, tspan, [μ; α; β; γ])
sol = solve(prob)

# plot pretty stuff
p = plot(sol, title="SIER Model", label=["S" "I" "E" "R" "N"], size=(1000,1000))
xlabel!(p, "Time")
ylabel!(p, "Population")

savefig(p, "sier.png")
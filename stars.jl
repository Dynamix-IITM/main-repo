
"""
Function to numerically solve the stellar formation model

### Inputs

- a0: Mass fraction of atomic cloud (inital)
- m0: Mass fraction of molecular cloud (inital)
- k1, k2: Reduced rate parameters

### Output

[a0, ... an], [m0, ... mn]

### Parameters for the FDE

- N: Number of steps to take
- dx: Modified time step

"""
function solveModel(a0, m0, k1, k2, dx, N)

    # set up the system
    a = zeros(N)
    m = zeros(N)
    a[1] = a0
    m[1] = m0    

    # governing equations
    da_dx = (a, m) -> 1 - a - m - k1*(m^2)*a
    dm_dx = (a, m) -> k1*(m^2)*a + k2*(m^n)*(a - 1 + m)
    
    # solve iteratively using FDE
    for i in 1:N-1
        a[i+1] = a[i] + dx * da_dx(a[i], m[i])
        m[i+1] = m[i] + dx * dm_dx(a[i], m[i])
    end

    # return the solution
    return a, m

end


"""
Function to numerically solve the stellar formation model

### Inputs

- A0: Mass of atomic cloud (inital)
- M0: Mass of molecular cloud (inital)
- T: Total mass of the system
- K1, K2, K3, K4: Rate parameters
- n: Paramter for star formation (between 0.5 and 3.5)

### Output

[[..., t, ...], [..., A(t), ...], [..., M(t), ...], [...,S(t), ...]]

(as an array in t from 0 to tmax)

### Parameters for the FDE

- N: Number of iterations
- tmax: End time to stop solving 

"""
function solveModel(A0, M0, T, K1, K2, K3, K4, n, tmax, N = 100)

    # convert to reduced system
    k1 = K3 * T^2 / (K1 + K2)
    k2 = K4 * T^n / (K1 + K2)
    dt = tmax / N
    dx = (K1 + K2) * dt

    # solve the model
    a, m = solveModel(A0/T, M0/T, k1, k2, dx, N)

    # return the solution
    return [(0:1:N-1) * dt, a*T, m*T, (1 .-a.-m)*T]

end

"""
# Parameter Set 1:

# parameters defining the system
n = 1.7
K1 = 0.5; K2 = 0.5; K3 = 20; K4 = 25;

# initial conditions
A = 0.1; M = 0.7; S = 0.2;
T = A + M + S
"""

## Parameter Set 2:

# parameters defining the system
n = 1.0
K1 = 0.5; K2 = 0.5; K3 = 10; K4 = 1;

# initial conditions
A = 0.15; M = 0.15; S = 0.75;
T = A + M + S

soln = solveModel(A, M, T, K1, K2, K3, K4, n, 100, 100000)

# plot pretty stuff

using Plots

p = plot(soln[1], [soln[2], soln[3], soln[4]], title="Time evolution of Stellar System", label=["A" "M" "S"], size=(1000, 1000))
plot!(p, legend=:outerbottom, legendcolumns=3)
xlabel!(p, "t")
ylabel!(p, "Mass")

q = plot(soln[3]/T, soln[2]/T, title="Phase diagram", legend=false, size=(1000, 1000))
xlabel!(q, "MF")
ylabel!(q, "AF")

plt = plot(p, q, layout=(2,1))
savefig(plt, "stars.pdf")

using Plots

n = 1.0
k1 = 8.75
k2 = 2.5
m0 = 0.15
a0 = 0.15
s0 = 0.70

t0 = 0.0
tend = 100.0
dt = 0.001  # Time step
N = Int((tend - t0) / dt)  # Number of time steps

a = zeros(N + 1)
m = zeros(N + 1)
s = zeros(N + 1)
t = range(t0, tend, length = N + 1)

a[1] = a0
m[1] = m0
s[1] = 1 - a0 - m

for i in 1:N
    a_new = a[i] + dt * (1 - a[i] - m[i] - k1 * (m[i]^2 * a[i]))  # da/dt
    m_new = m[i] + dt * (k1 * (m[i]^2)*a[i] + k2 * (m[i]^n) * (a[i] + m[i] - 1))  # dm/dt
    
    a_new = max(a_new, 0.0)
    m_new = max(m_new, 0.0)
    
    a[i + 1] = a_new
    m[i + 1] = m_new
    s[i + 1] = max(1 - a[i + 1] - m[i + 1], 0.0)
end

p1 = plot(t, a, label="a(t)", xlabel="Time (t)", ylabel="Concentration", title="a(t), m(t), and s(t) vs Time")
plot!(p1, t, m, label="m(t)")
plot!(p1, t, s, label="s(t)")

p2 = plot(a, m, label="Phase diagram (a vs m)", xlabel="a(t)", ylabel="m(t)", title="Phase diagram (a vs m)")
p3 = plot(m, s, label="Phase diagram (a vs s)", xlabel="a(t)", ylabel="s(t)", title="Phase diagram (a vs s)")
p4 = plot(s, a, label="Phase diagram (m vs s)", xlabel="m(t)", ylabel="s(t)", title="Phase diagram (m vs s)")

plot(p1, p2, p3, p4, layout=(2, 2), size=(800, 800))


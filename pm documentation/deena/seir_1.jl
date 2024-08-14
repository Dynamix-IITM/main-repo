using Plots
Plots.default(show = true)

# Initialising the values

E0=0.0000766
S0=1-E0
I0,R0=0,0

#Parameters

σ=0.02
γ=0.01
β=0.85


dx=0.048
N=10000

#Initialising the arrays
S=zeros(Float32,N)
E=zeros(Float32,N)
I=zeros(Float32,N)
R=zeros(Float32,N)

S[1]=S0
E[1]=E0
I[1]=I0
R[1]=R0


x_val=0:dx:(N*dx-dx)

for i in 2:N

    S[i]=(-β*S[i-1]*I[i-1])*dx + S[i-1]
    E[i]=((β*S[i-1]*I[i-1])-(σ*E[i-1]))*dx + E[i-1]
    I[i]=((σ*E[i-1])-(γ*I[i-1]))*dx + I[i-1]
    R[i]=(γ*I[i-1])*dx + R[i-1]

end


plot(x_val,S,label="Susceptible")
plot!(x_val,E,label="Exposed")
plot!(x_val,I,label="Infected")
xlims!(0,500)
plot!(x_val,R,label="Recovered")
xlabel!("Days")
ylabel!("Fraction of people")
title!("SEIR MODEL")
savefig("img.png")  

<details>
<summary>Fourth Order Runge-Kutta Method</summary>

#RKM-4
using Plots

function f(A)::Float64
  return 1-A-M-k1*M*M*A
end;

function g(M)::Float64
  return k1*M*M*A+k2*(M^n)*(A-1+M)
end;

function rkmx(x)::Float64
  a=f(x)*t
  b=f(x+0.5*a)*t
  c=f(x+0.5*b)*t
  d=f(x+c)*t
  x=x+(1/6)*(a+2*b+2*c+d)
  return x
end;

function rkmy(y)::Float64
  a=g(y)*t
  b=g(y+0.5*a)*t
  c=g(y+0.5*b)*t
  d=g(y+c)*t
  y=y+(1/6)*(a+2*b+2*c+d)
  return y
end;

t=0.1
A=0.4
M=0.3
S=1-A-M

k1=8
k2=15
n=1.5

tpts=[0]
Apts=[A]
Mpts=[M]
Spts=[S]

for i in range(0,1000)
    A=rkmx(A)
    M=rkmy(M)
    append!(tpts,i)
    append!(Apts,A)
    append!(Mpts,M)
    S=1-A-M
    append!(Spts,S)
end

y=[Apts Mpts Spts]
Agif=[]
Mgif=[]

@gif for i in 1:500
    append!(Agif,Apts[i])
    append!(Mgif,Mpts[i])
    plot(Agif,Mgif)
end #this is only M vs A

</details>

<details>
<summary>Euler Method</summary>
#Euler's Method
using Plots

function f(A)::Float64
     return 1-A-M-k1*M*M*A
end;

function g(M)::Float64
  return k1*M*M*A+k2*(M^n)*(A-1+M)
end;

function ex(x)::Float64
  x=x+f(x)*t
  return x
end;

function ey(y)::Float64
  y=y+g(y)*t
  return y
end;

t=0.1
A=0.4
M=0.3
S=1-A-M

k1=8
k2=15
n=1.5

tpts=[0]
Apts=[A]
Mpts=[M]
Spts=[S]

for i in range(0,1000)
    A=rkmx(A)
    M=rkmy(M)
    append!(tpts,i)
    append!(Apts,A)
    append!(Mpts,M)
    S=1-A-M
    append!(Spts,S)
end

y=[Apts Mpts Spts]
Agif=[]
Mgif=[]

@gif for i in 1:500
    append!(Agif,Apts[i])
    append!(Mgif,Mpts[i])
    plot(Agif,Mgif)
end #this is only M vs A

</details>


# 28 June 2024

### Star Formation and Julia
- Wrote a julia script to solve the Star Formation model given in "A mathematical model of star formation in the Galaxy - M.A. Sharaf, R. Ghoneim, I.A. Hassan"
- Read a bit about documentation standards in Julia, apparently markdown + docstrings are used, implemented the same
- Wrote two functions to solve the two variants of the Start Formation Model (absolute masses, mass fraction)
- Found a possible error in the paper - The parameters given for the plots in 2a, 2b don't make sense, consequently the plots don't match as well
- The plots in figures 3 and 4 however agree well

![image](./../../stars.png)

### Reading
- ~Will start reading lawvere Part III - Categories of structured sets from tomorrow~
- Missed out Brouwer's Theorems

# 29 June 2024

### Tweaked the Paramters for obtaining Eqm
- Solving for a general equilibrium is very trivial: set $\frac{da}{dx}$ and $\frac{dm}{dx}$ to zero and solve the two equations that you get
- The expressions for a, m in terms of k1 and k2 are very nice
- Figured out k1 = 8.75, k2 = 2.5 is ideal for an eqm of a = 0.25, m = 0.4, s = 3.5

# 1 July 2024

### Reading
- Read up on Brouwer's Theorems till page 126
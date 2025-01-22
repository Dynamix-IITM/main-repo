### Definition 
A **symmetric monoidal structure** on a preorder $(X, \leq)$ consists of two constituents:

1. An element $I \in X$, called the **monoidal unit**, and  
2. A function $\otimes: X \times X \to X$, called the **monoidal product**.

These constituents must satisfy the following properties, where we write $\otimes(x_1, x_2) = x_1 \otimes x_2$:

$$
\text{(a) For all } x_1, x_2, y_1, y_2 \in X, \text{ if } x_1 \leq y_1 \text{ and } x_2 \leq y_2, \text{ then } x_1 \otimes x_2 \leq y_1 \otimes y_2.
$$

$$
\text{(b) For all } x \in X, \text{ the equations } I \otimes x = x \text{ and } x \otimes I = x \text{ hold.}
$$

$$
\text{(c) For all } x, y, z \in X, \text{ the equation } (x \otimes y) \otimes z = x \otimes (y \otimes z) \text{ holds.}
$$

$$
\text{(d) For all } x, y \in X, \text{ the equation } x \otimes y = y \otimes x \text{ holds.}
$$

We call these conditions **monotonicity**, **unitality**, **associativity**, and **symmetry** respectively.

A preorder equipped with a symmetric monoidal structure, $(X, \leq, I, \otimes)$, is called a **symmetric monoidal preorder**.

# Wiring Diagrams

We denote the relationship $x \leq y$ by the following diagram:


Diagram to be added


To get a bit more rigorous about the connection, let’s start with a monoidal preorder 
$(X, \leq, I, \otimes)$ as in Definition 2.2. Wiring diagrams have wires on the left and the right. 
Each element $x \in X$ can be made the label of a wire. 

Note that given two objects $x, y$, we can either draw two wires in parallel—one labeled $x$ and one labeled $y$—or we can draw one wire labeled $x \otimes y$.


The validity of the second box corresponds to the inequality 
$x_1 \otimes x_2 \leq y_1 \otimes y_2 \otimes y_3$. 

Before going on to the properties from Definition , let us pause for an example of what we’ve discussed so far.


### Proposition 
Suppose $\mathcal{X} = (X, \leq)$ is a preorder and $\mathcal{X}^\text{op} = (X, \geq)$ is its opposite. 
If $(X, \leq, I, \otimes)$ is a symmetric monoidal preorder, then so is its opposite, $(X, \geq, I, \otimes)$.

---

### Definition 
Let $\mathcal{P} = (P, \leq_P, I_P, \otimes_P)$ and $\mathcal{Q} = (Q, \leq_Q, I_Q, \otimes_Q)$ be monoidal preorders.  

A **monoidal monotone** from $\mathcal{P}$ to $\mathcal{Q}$ is a monotone map 
$f : (P, \leq_P) \to (Q, \leq_Q)$, satisfying two conditions:

- **(a)** $I_Q \leq_Q f(I_P)$, and  
- **(b)** $f(p_1) \otimes_Q f(p_2) \leq_Q f(p_1 \otimes_P p_2)$ for all $p_1, p_2 \in P$.

There are strengthenings of these conditions that are also important.  

If $f$ satisfies the following conditions, it is called a **strong monoidal monotone**:

- **(a')** $I_Q \cong f(I_P)$, and  
- **(b')** $f(p_1) \otimes_Q f(p_2) \cong f(p_1 \otimes_P p_2)$.

If it satisfies the following conditions, it is called a **strict monoidal monotone**:

- **(a'')** $I_Q = f(I_P)$, and  
- **(b'')** $f(p_1) \otimes_Q f(p_2) = f(p_1 \otimes_P p_2)$.


### Definition 
Let $\mathcal{V} = (V, \leq, I, \otimes)$ be a symmetric monoidal preorder.  

A **$\mathcal{V}$-category** $\mathcal{X}$ consists of two constituents, satisfying two properties. To specify $\mathcal{X}$:  
1. One specifies a set $\text{Ob}(\mathcal{X})$, elements of which are called **objects**;  
2. For every two objects $x, y$, one specifies an element $\mathcal{X}(x, y) \in V$, called the **hom-object**.

The above constituents are required to satisfy two properties:  
- **(a)** For every object $x \in \text{Ob}(\mathcal{X})$, we have $I \leq \mathcal{X}(x, x)$, and  
- **(b)** For every three objects $x, y, z \in \text{Ob}(\mathcal{X})$, we have  
  $$\mathcal{X}(x, y) \otimes \mathcal{X}(y, z) \leq \mathcal{X}(x, z).$$

We call $\mathcal{V}$ the **base of the enrichment** for $\mathcal{X}$ or say that $\mathcal{X}$ is **enriched in** $\mathcal{V}$.

---

### Theorem 
There is a one-to-one correspondence between preorders and **Bool-categories**.

---

### Definition 
A **metric space** $(X, d)$ consists of:
1. A set $X$, elements of which are called **points**, and  
2. A function $d : X \times X \to \mathbb{R}_{\geq 0}$, where $d(x, y)$ is called the **distance between $x$ and $y$**.


These constituents must satisfy four properties:

- **(a)** For every $x \in X$, we have $d(x, x) = 0$.  
- **(b)** For every $x, y \in X$, if $d(x, y) = 0$ then $x = y$.  
- **(c)** For every $x, y \in X$, we have $d(x, y) = d(y, x)$.  
- **(d)** For every $x, y, z \in X$, we have $d(x, y) + d(y, z) \geq d(x, z)$.  

The fourth property is called the **triangle inequality**.

If we ask instead in (ii) for a function $d : X \times X \to [0, \infty] = \mathbb{R}_{\geq 0} \cup \{\infty\}$, we call $(X, d)$ an **extended metric space**.

### Definition
Let $\mathcal{X}$ and $\mathcal{Y}$ be $\mathcal{V}$-categories.  

A **$\mathcal{V}$-functor** from $\mathcal{X}$ to $\mathcal{Y}$, denoted $F : \mathcal{X} \to \mathcal{Y}$, consists of one constituent:
1. A function $F : \text{Ob}(\mathcal{X}) \to \text{Ob}(\mathcal{Y})$

subject to one constraint:
- **(a)** For all $x_1, x_2 \in \text{Ob}(\mathcal{X})$, one has  
  $$\mathcal{X}(x_1, x_2) \leq \mathcal{Y}(F(x_1), F(x_2)).$$
  ### Definition
Let $\mathcal{X}$ and $\mathcal{Y}$ be $\mathcal{V}$-categories. Define their **$\mathcal{V}$-product**, or simply **product**, to be the $\mathcal{V}$-category $\mathcal{X} \times \mathcal{Y}$ with:
1. $\text{Ob}(\mathcal{X} \times \mathcal{Y}) := \text{Ob}(\mathcal{X}) \times \text{Ob}(\mathcal{Y})$,  
2. $(\mathcal{X} \times \mathcal{Y})((x, y), (x', y')) := \mathcal{X}(x, x') \otimes \mathcal{Y}(y, y')$,

for two objects $(x, y)$ and $(x', y')$ in $\text{Ob}(\mathcal{X} \times \mathcal{Y})$.

---

### Definition 
A **symmetric monoidal preorder** $\mathcal{V} = (V, \leq, I, \otimes)$ is called **symmetric monoidal closed** (or just **closed**) if, for every two elements $v, w \in V$, there is an element $v \multimap w$ in $\mathcal{V}$, called the **hom-element**, with the property:

$$
(a \otimes v) \leq w \iff a \leq (v \multimap w),
$$

for all $a, v, w \in V$.

### Proposition 
Suppose $\mathcal{V} = (V, \leq, I, \otimes, \multimap)$ is a symmetric monoidal preorder that is closed. Then:

1. **(a)** For every $v \in V$, the monotone map $-\otimes v : (V, \leq) \to (V, \leq)$ is left adjoint to $v \multimap - : (V, \leq) \to (V, \leq)$.  
2. **(b)** For any element $v \in V$ and set of elements $A \subseteq V$, if the join $\bigvee_{a \in A} a$ exists, then so does $\bigvee_{a \in A} (v \otimes a)$ and we have:
   $$
   \bigg(v \otimes \bigvee_{a \in A} a\bigg) \cong \bigvee_{a \in A} (v \otimes a). \tag{2.88}
   $$
3. **(c)** For any $v, w \in V$, we have $v \otimes (v \multimap w) \leq w$.  
4. **(d)** For any $v \in V$, we have $v \cong (I \multimap v)$.  
5. **(e)** For any $u, v, w \in V$, we have $(u \multimap v) \otimes (v \multimap w) \leq (u \multimap w)$.

---

### Definition 
A **unital commutative quantale** is a symmetric monoidal closed preorder $\mathcal{V} = (V, \leq, I, \otimes, \multimap)$ that has all joins: $\bigvee A$ exists for every $A \subseteq V$. In particular, we often denote the empty join by $0 := \bigvee \varnothing$.

---

### Definition 
Let $\mathcal{V} = (V, \leq, \otimes, I)$ be a quantale.  

Given sets $X$ and $Y$, a **matrix with entries in $\mathcal{V}$**, or simply a **$\mathcal{V}$-matrix**, is a function $M : X \times Y \to V$.  

For any $x \in X$ and $y \in Y$, we call $M(x, y)$ the $(x, y)$-entry.
# Chapter-1

## Ordering Systems

### Joining Simple Systems

#### Definition

Joining two systems $A$ and $B$ is performed simply by combining their connections. The join of systems $A$ and $B$, denoted as $A \vee B$, has a connection between points $x$ and $y$ if there are some points $z_1, \ldots, z_n$ such that each of the following are true in at least one of $A$ or $B$:

- $x$ is connected to $z_i$.
- $z_i$ is connected to $z_{i+1}$.
- $z_n$ is connected to $y$.

### Partition and Equivalence Relation

#### Definition of Partition

##### Definition

If $A$ is a set, a partition of $A$ consists of a set $P$ and, for each $p \in P$, a nonempty subset $A_p \subseteq A$, such that:

$$
A = \bigcup_{p \in P} A_p \quad \text{and} \quad \text{if } p \neq q \text{ then } A_p \cap A_q = \emptyset.
$$

We may denote the partition by $\{A_p\}_{p \in P}$. We refer to $P$ as the set of part labels, and if $p \in P$ is a part label, we refer to $A_p$ as the $p^\text{th}$ part. The condition (1.15) says that each element $a \in A$ is in exactly one part.

We consider two different partitions $\{A_p\}_{p \in P}$ and $\{A'_{p'}\}_{p' \in P'}$ of $A$ to be the same if for each $p \in P$ there exists a $p' \in P'$ with $A_p = A'_{p'}$. In other words, if two ways to divide $A$ into parts are exactly the same—the only change is in the labels—then we don't make a distinction between them.

There is a one-to-one correspondence between a partition and an equivalence relation.

### Preorder

#### Definition

A preorder relation on a set $X$ is a binary relation on $X$, here denoted with infix notation $\leq$, such that:

1. $x \leq x$ (reflexivity), and
2. if $x \leq y$ and $y \leq z$, then $x \leq z$ (transitivity).

If $x \leq y$ and $y \leq x$, we write $x \cong y$ and say $x$ and $y$ are equivalent. We call a pair $(X, \leq)$ consisting of a set equipped with a preorder relation a **preorder**.

#### Remark (Partial Orders Are Skeletal Preorders)

A preorder is a **partial order** if we additionally have that:

3. $x \cong y$ implies $x = y$.

In category theory terminology, the requirement that $x \cong y$ implies $x = y$ is known as **skeletality**, so partial orders are **skeletal preorders**. For short, we also use the term **poset**, a contraction of partially ordered set.

#### Definition

A graph $G = (V, A, s, t)$ consists of a set $V$ whose elements are called vertices, a set $A$ whose elements are called arrows, and two functions $s, t: A \to V$ known as the source and target functions, respectively. Given $a \in A$ with $s(a) = v$ and $t(a) = w$, we say that $a$ is an arrow from $v$ to $w$.

By a path in $G$, we mean any sequence of arrows such that the target of one arrow is the source of the next. This includes sequences of length $1$, which are just arrows $a \in A$ in $G$, and sequences of length $0$, which just start and end at the same vertex $v$, without traversing any arrows.

### Definition

A **monotone map** between preorders $(A, \leq_A)$ and $(B, \leq_B)$ is a function $f : A \to B$ such that, for all elements $x, y \in A$,

$$
x \leq_A y \implies f(x) \leq_B f(y).
$$

### Definition

Let $(P, \leq)$ be a preorder, and let $A \subseteq P$ be a subset. We say that an element $p \in P$ is a **meet** of $A$ if:

1. For all $a \in A$, $p \leq a$.
2. For all $q$ such that $q \leq a$ for all $a \in A$, $q \leq p$.

We write:

$$
p = \bigwedge A, \quad p = \bigwedge_{a \in A} a,
$$
or, if the dummy variable $a$ is clear from context, simply:

$$
p = \bigwedge A.
$$

If $A$ consists of just two elements, say $A = \{a, b\}$, we denote $\bigwedge A$ as $a \wedge b$.

Similarly, we say that $p$ is a **join** of $A$ if:

1. For all $a \in A$, $a \leq p$.
2. For all $q$ such that $a \leq q$ for all $a \in A$, $p \leq q$.

We write:

$$
p = \bigvee A, \quad p = \bigvee_{a \in A} a,
$$
or, when $A = \{a, b\}$, we may simply write:

$$
p = a \vee b.
$$

### Definition

A **Galois connection** between preorders $P$ and $Q$ is a pair of monotone maps $f : P \to Q$ and $g : Q \to P$ such that:

$$
f(p) \leq q \iff p \leq g(q).
$$

We say that $f$ is the **left adjoint** and $g$ is the **right adjoint** of the Galois connection.

#### 1.Basic Theory of Galois Connections

**Proposition**  
Suppose that $f : P \to Q$ and $g : Q \to P$ are monotone maps. The following are equivalent:

1. $f$ and $g$ form a Galois connection where $f$ is left adjoint to $g$.
2. For every $p \in P$ and $q \in Q$, we have:

$$
p \leq g(f(p)) \quad \text{and} \quad f(g(q)) \leq q.
$$



# Conceptual Mathematics - _Lawvere and Schanuel_

### Galileo's idea 
By understanding the motion of objects, he schematically represented it as a map between time and space, like for motion of birds at each time it maps to specific position in space 
 
Now,  **SPACE = PLANE X LINE** - This states that each point in space can represented precisely by knowing it's level(= on a line) and it's shadow(= on a plane) so space does map to line and plane.

By this we cap map time to space and space to plane and line or simply time to line and plane directly.

>The takeaway is that we get space by knowing its level and shadow which  gives sense of multiplication.

### Category of Sets
Object - Finite set or collection
Internal map :
- for each element in domain there is exactly one arrow leaving
- no of arrows entering to a obj in codomain can be any

Endomap - A map in which domain and codomain are same
> indentity map is a special endomap with each element mapped to itself

Data for a **Category** --
Objects , Maps , Identity Maps and Composition rules
Rules -
- identity law 
- associative law { ho(gof) = (hog)of

Def : Point of a set is a **map** from 1 to the set (a map to one element in a set)

### Sets , Maps and Composition
 _Equality of Maps_ :
 Two maps are said to be equal iff they have same domain and codomain and same maps between elements
 
 Say there are two maps from A to B, f and g,
 A test for their equality is ; if for each point 1 to A say map 'a', 
 f(a) = g(a) then f = g
 > Note : Composition of two maps f and g is gof (not fog)

 External diagrams - They don't show inside of a map , just objects and the morphism
 
 - _**Weird**_ : There is precisely one map from a domain with no elements and a codomain with any no. of elements
 
Counting of Maps -
  No of maps from A to B is equal to **B^A^**, where B,A are no. of elements in B and A resp.

Let there be maps 'f' from A to B and 'g' from B to C

An **Identity Map  - 1~B~** is a map from B to B such that it follows,
> 1~B~ o f = f   &nbsp; and  &nbsp;  g o 1~B~ = g

### Isomorphisms 
or _Invertible Map_ is a map 'f' from A to B if there is a map 'g' from B to A for which g o f = 1~A~ and f o g = 1~B~

It satisfies Reflexivity, Symmetricity and Transitivity
> Composition = Multiplication (except for commutative law)
and Inverse = Division (except here we need two equations)

_Division problems in maps_:
 1. A 'determination' problem
 2. A 'choice' problem

First composition is generally multiplication, divison can be seen as solution to a missing value in multiplication, like 3 x _ = 15 gives _ = 5 as solution which simply is 15/3. Determination and choice problems are similar to these.

For example on these refer [My Notes](https://online.publuu.com/555867/1249532)

**Retractions**: A retraction for a map f from A to B is a map 'r' B to A for which r o f = 1~A~
These are actually determination problems 

**Sections**: A section for a map f from A to B is a map 's' B to A for which f o s = 1~B~
These are choice problems

There are some propositions -

**1.** If a map f from A to B has a section, then for any T and any map y from T to b there exist a map x from T to A for which f o x = y
(vice versa for retraction)

A map satisfying above proposition is surjective

**2.** Suppose a map f from A to B has a retraction, then for any T and pair of maps x1,x2 from T to A 
if f o x1 = f o x2 then x1 = x2
> This means left cancellable

Functions satisifying this is called  _injective_ or _**monomorphism**_

and for sections : if a map f from A to B has a section, then for any T and any pair of x1,x2 from B to T 
if x1 o f = x2 o f then x1 = x2
> Right cancellable

and functions satisfying above are called _**epimorphisms**_

- An endomap e is called idempotent if e o e = e 

- If a map has both section and retraction then both are equal to inverse of the map f, such map is a _isomorphism_
- An endomap that is a isomorphism is called _automorphism_
- Automorphisms is category is called a _permutation_

A summary:
[Image](https://ibb.co/TqDdBMw)

##### An Example of a Category and its Maps

In algebra, we can consider a category with objects a set and a combining rule (*)   
Ex : (R , +) , (R(~>0~) , x ) ...

A map in this category must obey this rule :
  - A map from an object (A,*) to (A', *') which respects
  -    f(a*b) = {f(a) *' f(b)}
  
  ###### Refer book for sorting, stacking examples and further explainations of sections and retractions.


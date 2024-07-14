# <ins>Categories of Structured Sets </ins> <br><br>
### <ins> The Category of Endomaps of Sets </ins> <br>
One thing we must notice till now that each point in a set is identical, we really don't bother distingushing one from another. All that changes when we talk about the endomaps of sets-interesting structure often arises in this context. <br>

This category of endomaps, call it S', what are its objects? And how are maps defined? Let's answer all this below:

For any objects X and Y, $\alpha: X \rightarrow X$ and $\beta: Y \rightarrow Y$ we define a specific map $f$ as follows:<br>

![image](https://github.com/Dynamix-IITM/Dhruv/assets/168696502/2fb62fe7-c8c3-46d0-92d6-1e3e0d010448) <br>

Note that this map is not arbitrary. Since morphisms must "preserve structure", such an _equivariant map_ $f$ must satisfy the following:<br><br>
![image](https://github.com/Dynamix-IITM/Dhruv/assets/168696502/c340d3ae-c683-47f3-b876-72e2a5727355) <br>

The internal diagram of an object may look like: <br><br>
![image](https://github.com/Dynamix-IITM/Dhruv/assets/168696502/6fc3b5b0-0929-4c14-b801-a697fc92f227) <br>

In the above diagram, the idea is that when we apply $\alpha$ to any point in the set, the "arrow" will point towards another point (as the mapping is an endomap so the source and target elements belong to the same set). So we may observe chains of arrows, cycles, fixed points, etc. It should be noted that if two objects in this category are isomorphic, then the structure is mirrored (same number of  same length cycles, same chains, etc.). <br><br>

### <ins> Involutions and Idempotents </ins> <br>
Similar to how we defined these terms for matrices, an involution is a morphism $\theta: X \rightarrow X$ such that $\theta \circ \theta = 1_X$. It's internal diagram looks like: ![image](https://github.com/user-attachments/assets/493cf52a-2019-4a39-a42d-f118cb489d56) <br>

An idempotent is a morphism $e: X \rightarrow X$ such that $e \circ e = e$. It's internal diagram looks like: ![image](https://github.com/user-attachments/assets/6ef3aa39-1104-42e0-a07d-e0ef53932811) <br>

All the above discussed kinds of morphisms may be related as follows: 
![image](https://github.com/user-attachments/assets/bfe01eb2-095c-4177-9cd2-b56b9ac90af6) <br><br>

### <ins>The Category of Irreflexive Graphs</ins><br>

These are _directed_ graphs, where a pair of maps point from one set to another. Specifically, we define maps $s$ and $t$ from $X$, the set of 'arrows' to $P$, the set of 'dots'. <br> 
<div align="center"> ![image](https://github.com/user-attachments/assets/bf0e8b7c-33fe-4010-857f-1f11a7a22b80) </div>


















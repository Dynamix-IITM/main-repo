import re
import networkx as nx
import matplotlib.pyplot as plt
import random

class SATSolver:
    def __init__(self, formula: str):
        self.clauses = self.parse_formula(formula)
        self.variables = {abs(var) for clause in self.clauses for var in clause}
        self.state = {var: random.choice([0, 1]) for var in self.variables}

    def parse_formula(self, formula: str):
        # Remove spaces
        formula = formula.replace(" ", "")

        # Extract clauses inside parentheses
        clause_strings = re.findall(r"\((.*?)\)", formula)
        clauses = []

        for clause_str in clause_strings:
            literals = clause_str.split("∨")
            clause = []
            for literal in literals:
                if "∼" in literal:
                    clause.append(-int(literal.replace("∼x", "")))  # Negation
                else:
                    clause.append(int(literal.replace("x", "")))  # Positive literal
            clauses.append(clause)

        return clauses

    def compute_Oi_Ai(self):
        """Computes Oi and Ai for each variable xi."""
        Oi = {var: [] for var in self.variables}
        Ai = {var: [] for var in self.variables}

        for clause in self.clauses:
            for literal in clause:
                var = abs(literal)
                if literal > 0:
                    Oi[var].append(clause)
                else:
                    Ai[var].append(clause)

        return Oi, Ai

    def transition(self, num_v):
        """Applies the transition function to update variable states."""
        Oi, Ai = self.compute_Oi_Ai()
        new_state = self.state.copy()

        var = list(self.variables)[num_v]  # Fix here: select the actual variable based on num_v
        # Compute And[Oi] and And[Ai]
        and_Oi = all(any(self.state[abs(lit)] if lit > 0 else not self.state[abs(lit)] for lit in clause) for clause in Oi[var])
        and_Ai = all(any(self.state[abs(lit)] if lit > 0 else not self.state[abs(lit)] for lit in clause) for clause in Ai[var])

        # Apply transition function: Fi = (xi ∧ And[Ai]) ∨ ∼And[Oi]
        new_state[var] = (self.state[var] and and_Ai) or (not and_Oi)

        self.state = new_state  # Update the state

    def iter(self, max_iter=100):
        """Runs the transition function iteratively to find a new state for one index
         - It shuffles n variables and finds the new state in that order
        """

        for i in range(max_iter):
            previous_state = self.state.copy()
            # Shuffle the list of variables indices and iterate over them
            lst = list(range(len(self.variables)))  # Create a list of variable indices
            random.shuffle(lst)  # Shuffle the list in place

            for idx in lst:
                self.transition(idx)

            if self.state == previous_state:
                print(f"Fixed point reached at iteration {i}")
                return self.state  # Return stable state

        print(f"Max iterations ({max_iter}) reached, returning last state.")
        return self.state  # Return last state after max iterations

# Example usage
formula = " (x1∨x2)∧(x1∨∼x3)∧(∼x1∨∼x3)∧(x2∨x3)∧(x1∨x3) "
solver = SATSolver(formula)

print("Clauses:", solver.clauses)
print("Variables:", solver.variables)
print("State before transition:", solver.state)
print("A_i and O_i:", solver.compute_Oi_Ai())
fixed_state = solver.iter(max_iter=100)
print("Fixed state:", fixed_state)

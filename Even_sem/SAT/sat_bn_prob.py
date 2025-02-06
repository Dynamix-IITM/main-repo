import re
import random
import sympy
from sympy import symbols
from sympy.logic.boolalg import to_cnf

class SATSolver:
    def __init__(self, expr: str, firing_probability: float):
        self.clauses, self.var_names = self.parse_expression(expr)
        self.variables = {abs(var) for clause in self.clauses for var in clause}
        self.state = {var: random.choice([0, 1]) for var in self.variables}
        self.p = firing_probability

    def parse_expression(self, expr: str):

        # Parse all the variables (assumed to be single letter)
        tokens = re.findall(r'\b[a-zA-Z_]\w*\b', expr)
        var_names = list(set(tokens))

        # Assign indices to each variable
        var_ids = {name: symbols(str(var_names.index(name)+1)) for name in var_names}

        # Replace according to sympy conventions
        expr = expr.replace('∧', '&').replace('∨', '|').replace('!', '~').replace('∼', '~')
        expr = expr.replace('<=>', '==').replace('=>', '>>')

        # Convert the expression to CNF
        formula = str(to_cnf(sympy.sympify(expr, locals=var_ids), simplify=False))
        if formula == 'True' or formula == 'False':
            print("Expression is always", formula)
            exit()

        print(formula)

        # Remove spaces and brackets
        formula = formula.replace(" ", "").replace("(", "").replace(")", "")

        # Extract clauses inside parentheses
        clause_strings = formula.split("&")  
        clauses = []

        for clause_str in clause_strings:
            literals = clause_str.split("|")
            clause = []
            for literal in literals:
                if "~" in literal:
                    clause.append(-int(literal[1]))  # Negation
                else:
                    clause.append(int(literal))  # Positive literal
            clauses.append(clause)

        return clauses, var_names

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

    def transition(self):
        """Applies the transition function to update variable states."""
        Oi, Ai = self.compute_Oi_Ai()
        new_state = {}

        for var in self.variables:
            # Compute And[Oi] and And[Ai]
            and_Oi = all(any(self.state[abs(lit)] if lit > 0 else not self.state[abs(lit)] for lit in clause) for clause in Oi[var])
            and_Ai = all(any(self.state[abs(lit)] if lit > 0 else not self.state[abs(lit)] for lit in clause) for clause in Ai[var])

            r = random.random()

            if r < self.p:
                # Apply transition function: Fi = (xi ∧ And[Ai]) ∨ ∼And[Oi]
                new_state[var] = (self.state[var] and and_Ai) or (not and_Oi)
            else:
                # Apply the identity transition
                new_state[var] = (self.state[var])

        self.state = new_state  # Update the state

    def iter(self, max_iter=100):
        """Runs the transition function iteratively to find a fixed state.
        
        - Stops if a stable state is reached.
        """

        for i in range(max_iter):
            
            previous_state = self.state.copy()
            self.transition()

            if self.state == previous_state:
                if self.check_if_satisfied() == True:
                    print(f"Fixed point reached at iteration {i}")
                    return self.add_var_names(self.state)  # Return stable state

            self.print_state(previous_state)

        print(f"Max iterations ({max_iter}) reached, returning last state.")
        return self.add_var_names(self.state) # Return last state after max iterations

    def check_if_satisfied(self):
        """Check if the current state satisfies the expression"""

        # Final evaluation of the expression
        expr = False
        
        for clause in self.clauses:

            # Evaluate each clause
            clause_expr = True

            for var in clause:
                if var > 0:                
                    expr *= self.state[var]
                else:
                    expr *= not self.state[-var]
            
            # Update the expresssion
            expr |= clause_expr

        return expr

    def add_var_names(self, state):
        """Adds original variable names to the indexed variables"""

        # State decorated with variable names
        named_state = {}

        for var in state:
            named_state[self.var_names[var-1]] = state[var]
        
        return named_state

    def print_state(self, state):
        """Displays the state on the terminal using 1s and 0s"""

        print_expr = ''
        for var in state:
            print_expr += str(int(state[var]))
        
        print(print_expr)

# Example usage
formula = "x14 & x16 & x23 & x27 & x3 & x32 & x35 & x37 & x38 & x40 & x49 & x5 & x50 & x62 & x63 & x64 & x66 & x73 & x88 & x93 & ~x14 & ~x15 & ~x18 & ~x19 & ~x22 & ~x25 & ~x27 & ~x31 & ~x33 & ~x4 & ~x42 & ~x43 & ~x52 & ~x55 & ~x56 & ~x6 & ~x68 & ~x69 & ~x7 & ~x77 & ~x86 & ~x9 & ~x90 & ~x94 & (x11 | x23) & (x13 | x83) & (x24 | x45) & (x35 | x90) & (x40 | x49) & (x41 | x58) & (x58 | x92) & (x70 | x72) & (x76 | x92) & (x82 | x95) & (x11 | ~x55) & (x20 | ~x14) & (x28 | ~x72) & (x30 | ~x26) & (x31 | ~x52) & (x31 | ~x62) & (x33 | ~x6) & (x36 | ~x2) & (x38 | ~x92) & (x42 | ~x57) & (x5 | ~x29) & (x54 | ~x8) & (x60 | ~x47) & (x63 | ~x12) & (x63 | ~x30) & (x71 | ~x54) & (x74 | ~x28) & (x75 | ~x44) & (x80 | ~x49) & (x85 | ~x20) & (x100 | x53 | x74) & (x24 | x69 | x85) & (x4 | x48 | x62) & (x5 | x63 | x64) & (~x11 | ~x7) & (~x11 | ~x78) & (~x13 | ~x76) & (~x2 | ~x7) & (~x21 | ~x89) & (~x36 | ~x62) & (~x38 | ~x74) & (~x48 | ~x87) & (~x76 | ~x81) & (~x80 | ~x86) & (x10 | x64 | ~x34) & (x12 | x39 | ~x69) & (x17 | x34 | ~x50) & (x17 | x80 | ~x85) & (x24 | x32 | ~x74) & (x35 | x58 | ~x14) & (x4 | x53 | ~x20) & (x40 | x49 | ~x43) & (x40 | x56 | ~x44) & (x58 | x86 | ~x59) & (x1 | x25 | x69 | x91) & (x15 | x24 | x29 | x65) & (x16 | x29 | x84 | x95) & (x16 | x3 | x44 | x95) & (x22 | x32 | x58 | x82) & (x31 | x35 | x48 | x52) & (x15 | ~x60 | ~x96) & (x17 | ~x7 | ~x99) & (x25 | ~x38 | ~x71) & (x26 | ~x55 | ~x68) & (x47 | ~x63 | ~x7) & (x67 | ~x42 | ~x47) & (x67 | ~x6 | ~x83) & (x70 | ~x1 | ~x62) & (x77 | ~x65 | ~x81) & (x8 | ~x45 | ~x56) & (x84 | ~x2 | ~x80) & (x100 | x48 | x53 | ~x37) & (x14 | x39 | x67 | ~x72) & (x25 | x29 | x50 | ~x40) & (x26 | x45 | x67 | ~x8) & (x34 | x4 | x89 | ~x83) & (x59 | x77 | x85 | ~x56) & (x84 | x85 | x94 | ~x83) & (x85 | x94 | x96 | ~x10) & (x25 | x34 | x43 | x59 | x63) & (~x16 | ~x7 | ~x91) & (~x17 | ~x23 | ~x52) & (~x19 | ~x40 | ~x53) & (~x35 | ~x87 | ~x96) & (~x39 | ~x53 | ~x76) & (~x53 | ~x77 | ~x82) & (x1 | x57 | ~x6 | ~x88) & (x10 | x45 | ~x80 | ~x83) & (x100 | x97 | ~x32 | ~x86) & (x11 | x26 | ~x14 | ~x89) & (x24 | x38 | ~x20 | ~x37) & (x24 | x47 | ~x52 | ~x77) & (x25 | x50 | ~x51 | ~x87) & (x3 | x33 | ~x10 | ~x41) & (x30 | x4 | ~x47 | ~x95) & (x71 | x92 | ~x54 | ~x75) & (x80 | x83 | ~x61 | ~x89) & (x87 | x98 | ~x39 | ~x80) & (x90 | x95 | ~x83 | ~x94) & (x10 | x19 | x22 | x78 | ~x44) & (x10 | x49 | x53 | x65 | ~x6) & (x15 | x38 | x78 | x97 | ~x79) & (x16 | x74 | x85 | x89 | ~x2) & (x18 | x23 | x31 | x47 | ~x1) & (x31 | x5 | x50 | x80 | ~x22) & (x10 | ~x58 | ~x74 | ~x78) & (x13 | ~x100 | ~x26 | ~x60) & (x61 | ~x1 | ~x16 | ~x97) & (x69 | ~x46 | ~x8 | ~x90) & (x70 | ~x35 | ~x56 | ~x57) & (x82 | ~x13 | ~x6 | ~x74) & (x86 | ~x100 | ~x82 | ~x91) & (x91 | ~x13 | ~x49 | ~x79) & (x96 | ~x17 | ~x73 | ~x86) & (x1 | x19 | x41 | ~x34 | ~x44) & (x15 | x35 | x6 | ~x29 | ~x50) & (x2 | x25 | x45 | ~x28 | ~x39) & (x21 | x66 | x68 | ~x78 | ~x97) & (x24 | x60 | x86 | ~x26 | ~x49) & (x25 | x32 | x55 | ~x14 | ~x28) & (x28 | x81 | x85 | ~x17 | ~x71) & (x32 | x35 | x8 | ~x2 | ~x83) & (x36 | x60 | x77 | ~x11 | ~x8) & (x4 | x40 | x59 | ~x27 | ~x45) & (x40 | x49 | x52 | ~x29 | ~x90) & (x78 | x8 | x93 | ~x20 | ~x48) & (~x12 | ~x46 | ~x47 | ~x80) & (~x20 | ~x31 | ~x83 | ~x85) & (~x29 | ~x49 | ~x64 | ~x67) & (~x44 | ~x55 | ~x77 | ~x85) & (~x51 | ~x62 | ~x82 | ~x9) & (~x55 | ~x7 | ~x70 | ~x83) & (~x74 | ~x80 | ~x92 | ~x96) & (x19 | x93 | ~x29 | ~x39 | ~x71) & (x24 | x60 | ~x12 | ~x31 | ~x68) & (x24 | x84 | ~x18 | ~x45 | ~x47) & (x3 | x49 | ~x50 | ~x62 | ~x88) & (x31 | x95 | ~x46 | ~x6 | ~x92) & (x32 | x7 | ~x17 | ~x3 | ~x31) & (x65 | x83 | ~x40 | ~x61 | ~x77) & (x69 | x76 | ~x16 | ~x6 | ~x82) & (x71 | x88 | ~x20 | ~x44 | ~x5) & (x72 | x8 | ~x40 | ~x46 | ~x58) & (x73 | x76 | ~x13 | ~x47 | ~x61) & (x12 | ~x14 | ~x6 | ~x80 | ~x83) & (x58 | ~x100 | ~x18 | ~x25 | ~x6) & (x61 | ~x100 | ~x15 | ~x41 | ~x46) & (x70 | ~x6 | ~x7 | ~x78 | ~x80) & (x98 | ~x12 | ~x22 | ~x43 | ~x8) & (~x14 | ~x17 | ~x32 | ~x66 | ~x8)"
solver = SATSolver(formula, 0.8)

print("Clauses:", solver.clauses)
print("Variables:", solver.variables)
print("state befre transition:", solver.state)
solver.transition()
print("A_i and O_i:", solver.compute_Oi_Ai())
fixed_state = solver.iter(max_iter=100)
print('\n')
print("Fixed state:", fixed_state)

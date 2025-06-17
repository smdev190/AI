# Map Coloring using CSP (Backtracking)

# Define variables (regions) and their neighbors
neighbors = {
    'WA': ['NT', 'SA'],
    'NT': ['WA', 'SA', 'Q'],
    'SA': ['WA', 'NT', 'Q', 'NSW', 'V'],
    'Q': ['NT', 'SA', 'NSW'],
    'NSW': ['SA', 'Q', 'V'],
    'V': ['SA', 'NSW', 'T'],
    'T': ['V']
}

# Define domains (colors)
colors = ['Red', 'Green', 'Blue']

# Initial assignment (empty)
assignment = {}

# Constraint: No neighboring regions can have the same color
def is_valid(region, color, assignment):
    for neighbor in neighbors[region]:
        if neighbor in assignment and assignment[neighbor] == color:
            return False
    return True

# Backtracking algorithm
def backtrack(assignment):
    # If all regions are assigned, return the assignment
    if len(assignment) == len(neighbors):
        return assignment

    # Select unassigned region
    unassigned = [r for r in neighbors if r not in assignment]
    region = unassigned[0]

    for color in colors:
        if is_valid(region, color, assignment):
            assignment[region] = color
            result = backtrack(assignment)
            if result:
                return result
            # Backtrack
            del assignment[region]

    return None

# Run CSP
solution = backtrack(assignment)

# Output the solution
if solution:
    print("✅ Map Coloring Solution:")
    for region in sorted(solution):
        print(f"{region}: {solution[region]}")
else:
    print("❌ No solution found.")

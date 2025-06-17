import random

# Objective: 2x^3 + 7y = 147
def fitness(x, y):
    return abs(147 - (2 * x**3 + 7 * y))

# Generate random individual (x, y)
def create_individual():
    return random.randint(-20, 20), random.randint(-20, 20)

# Crossover: Swap parts of parents
def crossover(p1, p2):
    return (p1[0], p2[1]), (p2[0], p1[1])

# Mutation: Small random change
def mutate(individual):
    if random.random() < 0.5:
        return (individual[0] + random.choice([-1, 1]), individual[1])
    else:
        return (individual[0], individual[1] + random.choice([-1, 1]))

# Genetic Algorithm
def genetic_algorithm():
    population_size = 100
    generations = 1000

    population = [create_individual() for _ in range(population_size)]

    for generation in range(generations):
        population.sort(key=lambda ind: fitness(ind[0], ind[1]))
        
        if fitness(population[0][0], population[0][1]) == 0:
            print(f"✅ Solution found in generation {generation}: x = {population[0][0]}, y = {population[0][1]}")
            return

        next_generation = population[:20]  # keep top 20
        top_half = population[:population_size // 2]
        # create children through crossover and mutation
        while len(next_generation) < population_size:
            p1 = random.choice(top_half)
            p2 = random.choice(top_half)
            child1, child2 = crossover(p1, p2)
            next_generation.extend([mutate(child1), mutate(child2)])

        population = next_generation

    print("❌ No exact solution found.")

# Run it
genetic_algorithm()
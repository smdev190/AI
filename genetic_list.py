import random

# Configuration
TARGET = [3, 1, 4, 1, 5]
POPULATION = 100
MUTATION_RATE = 0.1
GENERATIONS = 100
GENE_POOL = list(range(10))  # Allowed values: 0-9

def random_list_gen(length):
    return [random.choice(GENE_POOL) for _ in range(length)]

def get_fitness(candidate, target):
    score = 0
    for i in range(len(target)):
        if candidate[i] == target[i]:
            score += 1
    return score

def sort_population_by_fit(population, target):
    for i in range(len(population)):
        for j in range(i + 1, len(population)):
            if get_fitness(population[j], target) > get_fitness(population[i], target):
                population[i], population[j] = population[j], population[i]
    return population

def crossover(p1, p2):
    cut = random.randint(1, len(p1) - 1)
    child = []
    for i in range(len(p1)):
        if i < cut:
            child.append(p1[i])
        else:
            child.append(p2[i])
    return child

def mutation(chrom):
    if random.random() < MUTATION_RATE:
        idx = random.randint(0, len(chrom) - 1)
        new_val = random.choice(GENE_POOL)
        chrom[idx] = new_val
    return chrom

def genetic_algo(target):
    population = []
    for _ in range(POPULATION):
        population.append(random_list_gen(len(target)))

    for generation in range(GENERATIONS):
        sorted_population = sort_population_by_fit(population, target)
        best = sorted_population[0]
        best_fit = get_fitness(best, target)
        print("Generation", generation, ":", best, "(Fitness:", best_fit, ")")

        if best_fit == len(target):
            print("Target Matched!")
            return best

        next_gen = []
        top_half = sorted_population[:POPULATION // 2]

        while len(next_gen) < POPULATION:
            p1 = random.choice(top_half)
            p2 = random.choice(top_half)
            child = crossover(p1, p2)
            child = mutation(child)
            next_gen.append(child)

        population = next_gen

    print("Max generations reached.\nTarget:", target, "\nBest match:", population[0], "Fitness:", best_fit)
    return population[0]

# Run the algorithm
result = genetic_algo(TARGET)
print("Target:", TARGET)
print("Final Result:", result)

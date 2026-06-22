"""Self-contained Artificial Algae Algorithm (AAA) implementation.

This module contains both the public optimizer and its internal AAA helper
routines: greatness calculation, friction surface, energy ordering, tournament
selection, and normalization. Benchmark objective functions intentionally live
in ``benchmarks.py`` because they are not part of the algorithm itself.
"""

import math
import random


class ArtificialAlgaeAlgorithm:
    """AAA with helical movement, evolutionary process, and adaptation.

    The implementation follows the MATLAB reference files supplied for this
    repository. ``optimize`` returns ``(best_position, best_value, history)``.
    """

    def __init__(self, max_evaluations=10_000, population_size=40, shear_force=2.0,
                 energy_loss=0.3, adaptation_probability=0.5, seed=None):
        if max_evaluations < population_size or population_size < 2:
            raise ValueError("max_evaluations must be >= population_size >= 2.")
        self.max_evaluations = max_evaluations
        self.population_size = population_size
        self.shear_force = shear_force
        self.energy_loss = energy_loss
        self.adaptation_probability = adaptation_probability
        self.seed = seed

    def optimize(self, objective, bounds):
        """Minimize ``objective`` over at least three bounded dimensions."""
        if len(bounds) < 3 or any(lower >= upper for lower, upper in bounds):
            raise ValueError("bounds needs at least three valid (lower, upper) pairs.")
        rng = random.Random(self.seed)
        population = [[rng.uniform(lower, upper) for lower, upper in bounds]
                      for _ in range(self.population_size)]
        costs = [objective(candidate) for candidate in population]
        evaluations = self.population_size
        starvation = [0] * self.population_size
        greatness = self._calculate_greatness([1.0] * self.population_size, costs)
        best_index = min(range(self.population_size), key=costs.__getitem__)
        best_position = population[best_index][:]
        best_value = costs[best_index]
        history = [best_value]

        while evaluations < self.max_evaluations:
            energy = self._greatness_order(greatness)
            surface = self._friction_surface(greatness)
            for index in range(self.population_size):
                starved = True
                while energy[index] >= 0 and evaluations < self.max_evaluations:
                    neighbor = self._tournament_selection(costs, rng)
                    while neighbor == index:
                        neighbor = self._tournament_selection(costs, rng)
                    dimensions = rng.sample(range(len(bounds)), 3)
                    candidate = population[index][:]
                    shear = self.shear_force - surface[index]
                    difference = [population[neighbor][dimension] - candidate[dimension]
                                  for dimension in dimensions]
                    candidate[dimensions[0]] += difference[0] * shear * (2 * rng.random() - 1)
                    candidate[dimensions[1]] += difference[1] * shear * math.cos(rng.random() * 360)
                    candidate[dimensions[2]] += difference[2] * shear * math.sin(rng.random() * 360)
                    candidate = [max(lower, min(upper, value))
                                 for value, (lower, upper) in zip(candidate, bounds)]
                    candidate_cost = objective(candidate)
                    evaluations += 1
                    energy[index] -= self.energy_loss / 2
                    if candidate_cost <= costs[index]:
                        population[index] = candidate
                        costs[index] = candidate_cost
                        starved = False
                    else:
                        energy[index] -= self.energy_loss / 2
                if starved:
                    starvation[index] += 1

            current_index = min(range(self.population_size), key=costs.__getitem__)
            if costs[current_index] < best_value:
                best_value = costs[current_index]
                best_position = population[current_index][:]
            history.append(best_value)
            greatness = self._calculate_greatness(greatness, costs)
            largest = max(range(self.population_size), key=greatness.__getitem__)
            smallest = min(range(self.population_size), key=greatness.__getitem__)
            dimension = rng.randrange(len(bounds))
            population[smallest][dimension] = population[largest][dimension]
            most_starved = max(range(self.population_size), key=starvation.__getitem__)
            if rng.random() < self.adaptation_probability:
                population[most_starved] = [
                    max(lower, min(upper, value + (source - value) * rng.random()))
                    for value, source, (lower, upper) in zip(
                        population[most_starved], population[largest], bounds)
                ]
        return best_position, best_value, history

    # Internal AAA mechanisms. They remain in this file so the optimizer is
    # portable as a single algorithm module, analogous to MATLAB's aaa.m.
    @staticmethod
    def _normalize(values):
        low, high = min(values), max(values)
        return [0.0] * len(values) if high == low else [(value - low) / (high - low) for value in values]

    def _calculate_greatness(self, greatness, costs):
        fitness = self._normalize([1 - value for value in self._normalize(costs)])
        updated = []
        for size, value in zip(greatness, fitness):
            growth = value / (abs(size / 2) + value) if value else 0.0
            updated.append(size + growth * size)
        return updated

    def _greatness_order(self, greatness):
        order = sorted(range(len(greatness)), key=greatness.__getitem__)
        energy = [0.0] * len(greatness)
        for rank, index in enumerate(order, start=1):
            energy[index] = rank * rank
        return self._normalize(energy)

    def _friction_surface(self, greatness):
        surface = [2 * math.pi * ((3 * size) / (4 * math.pi)) ** (2 / 3) for size in greatness]
        return self._normalize(surface)

    @staticmethod
    def _tournament_selection(costs, rng):
        first, second = rng.sample(range(len(costs)), 2)
        return first if costs[first] < costs[second] else second

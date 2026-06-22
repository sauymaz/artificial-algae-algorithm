"""Standard continuous optimization benchmark functions."""

import math


def sphere(x):
    return sum(value * value for value in x)


def rastrigin(x):
    return 10 * len(x) + sum(value * value - 10 * math.cos(2 * math.pi * value) for value in x)


def rosenbrock(x):
    return sum(100 * (x[i + 1] - x[i] ** 2) ** 2 + (1 - x[i]) ** 2 for i in range(len(x) - 1))


def ackley(x):
    n = len(x)
    if n == 0:
        raise ValueError("Ackley requires at least one dimension.")
    mean_square = sum(value * value for value in x) / n
    mean_cosine = sum(math.cos(2 * math.pi * value) for value in x) / n
    return -20 * math.exp(-0.2 * math.sqrt(mean_square)) - math.exp(mean_cosine) + 20 + math.e

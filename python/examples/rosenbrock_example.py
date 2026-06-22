"""Intended AAA usage with the Rosenbrock benchmark."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from aaa import ArtificialAlgaeAlgorithm
from aaa.benchmarks import rosenbrock

optimizer = ArtificialAlgaeAlgorithm(max_evaluations=10_000, population_size=40, seed=42)
best_position, best_value, history = optimizer.optimize(rosenbrock, [(-5.0, 10.0)] * 10)
print("Best value:", best_value)
print("Best position:", best_position)

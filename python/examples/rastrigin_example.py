"""Intended AAA usage with the Rastrigin benchmark."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from aaa import ArtificialAlgaeAlgorithm
from aaa.benchmarks import rastrigin

optimizer = ArtificialAlgaeAlgorithm(max_evaluations=10_000, population_size=40, seed=42)
best_position, best_value, history = optimizer.optimize(rastrigin, [(-5.12, 5.12)] * 10)
print("Best value:", best_value)
print("Best position:", best_position)

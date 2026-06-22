"""Intended AAA usage with the Ackley benchmark."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from aaa import ArtificialAlgaeAlgorithm
from aaa.benchmarks import ackley

optimizer = ArtificialAlgaeAlgorithm(population_size=30, max_iterations=500, seed=42)
try:
    print(optimizer.optimize(ackley, [(-32.768, 32.768)] * 10))
except NotImplementedError as error:
    print(error)

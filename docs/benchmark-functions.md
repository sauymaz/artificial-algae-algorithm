# Benchmark functions

Continuous benchmark suites provide controlled landscapes for comparing optimizers. The CEC'05 real-parameter optimization context is commonly referenced for shifted, rotated, hybrid, and composition functions designed to test robustness beyond simple textbook cases.

This repository includes common introductory functions:

- **Sphere:** smooth, convex, and unimodal; minimum at the origin.
- **Rastrigin:** highly multimodal with regularly spaced local minima.
- **Rosenbrock:** a narrow curved valley that tests search coordination.
- **Ackley:** a multimodal landscape with a broad nearly flat outer region.

Benchmark reports should state dimension, bounds, stopping budget, random seeds, number of independent runs, and the statistic reported. CEC'05 functions and definitions should be obtained from their official distribution or applicable benchmark documentation.

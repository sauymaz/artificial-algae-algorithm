# Artificial Algae Algorithm (AAA)

Academic reference material and implementation scaffolding for the **Artificial Algae Algorithm (AAA)**, a bio-inspired population-based metaheuristic for nonlinear global optimization. AAA models microalgal behavior through helical movement, an evolutionary process, and an adaptation process.

## Original publication

Uymaz, S. A., Tezel, G., & Yel, E. (2015). *Artificial algae algorithm (AAA) for nonlinear global optimization*. Applied Soft Computing, 31, 153–171. https://doi.org/10.1016/j.asoc.2015.03.003

The original article is available through its [DOI](https://doi.org/10.1016/j.asoc.2015.03.003) and [ScienceDirect record](https://www.sciencedirect.com/science/article/abs/pii/S1568494615001465). It is not redistributed here; access or redistribute the article only where copyright permissions allow.

## Repository layout

- `matlab/` — runnable simplified MATLAB optimizer and examples.
- `python/` — runnable simplified Python optimizer, benchmarks, and examples.
- `docs/` — algorithm notes, pseudocode, and benchmark context.
- `data/references.bib` — BibTeX reference for the original publication.

## Citation

Please cite the original publication when using AAA. See [CITATION.cff](CITATION.cff) or `data/references.bib`.

## MATLAB usage

```matlab
addpath('matlab')
sphere_example
```

`aaa.m` implements the AAA helical movement, evolutionary process, adaptation process, greatness calculation, friction surface, and tournament selection from the supplied reference code.

## Python usage

No third-party dependencies are required. From the repository root:

```bash
python python/examples/sphere_example.py
```

The Python optimizer is a dependency-free translation of the MATLAB AAA reference implementation.

## Benchmark examples

Included examples cover Sphere, Rastrigin, Rosenbrock, and Ackley functions. See [benchmark documentation](docs/benchmark-functions.md) for context.

## Disclaimer

This repository is intended for academic reference and reproducibility work. Validate parameter choices, benchmark protocols, and results independently before drawing scientific or engineering conclusions.

# High-level pseudocode

```text
Input: objective function f, bounds, population size, stopping criterion
Initialize a population of algae within bounds
Evaluate every alga and record the best solution

while stopping criterion is not met:
    for each alga:
        generate a candidate using a helical-movement update
        enforce bounds and evaluate the candidate
        retain it according to the chosen selection rule

    apply the evolutionary process using population fitness information
    apply the adaptation process to maintain search diversity
    enforce bounds, evaluate changed algae, and update the best solution

return best solution and optimization history
```

The update equations, selection rules, and parameter semantics should follow the original AAA publication when implementing this outline.

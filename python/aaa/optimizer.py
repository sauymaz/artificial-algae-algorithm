"""Placeholder optimizer interface for the Artificial Algae Algorithm."""


class ArtificialAlgaeAlgorithm:
    """API skeleton for a future AAA implementation.

    A complete implementation should model population initialization, helical
    movement, evolutionary process, and adaptation process. This class does
    not provide validated optimization behavior.
    """

    def __init__(self, population_size=30, max_iterations=500, seed=None):
        self.population_size = population_size
        self.max_iterations = max_iterations
        self.seed = seed

    def optimize(self, objective, bounds):
        """Optimize ``objective`` over ``bounds`` after AAA is implemented."""
        raise NotImplementedError(
            "ArtificialAlgaeAlgorithm is a placeholder, not a validated AAA implementation."
        )

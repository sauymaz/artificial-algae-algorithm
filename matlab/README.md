# MATLAB implementation

`aaa.m` is self-contained: it includes the main algorithm plus local functions for greatness calculation, friction surface, energy order, tournament selection, and normalization. It implements AAA using helical movement, evolutionary process, and adaptation process.

Run `sphere_example` or `rastrigin_example` from MATLAB. The optimizer requires a function handle and a parameter structure containing `MaxFEVs`, `N`, `D`, `LB`, `UB`, `K`, `le`, and `Ap`.

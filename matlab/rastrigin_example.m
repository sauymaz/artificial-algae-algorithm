% RASTRIGIN_EXAMPLE Demonstrates the intended AAA call pattern.
addpath(fileparts(mfilename('fullpath')));
n = 10;
objective = @(x) 10*n + sum(x.^2 - 10*cos(2*pi*x));
lowerBounds = -5.12 * ones(1, n);
upperBounds = 5.12 * ones(1, n);
options = struct('populationSize', 30, 'maxIterations', 500);

% aaa is currently a placeholder and will report NotImplemented.
[bestPosition, bestValue, history] = aaa(objective, lowerBounds, upperBounds, options); %#ok<NASGU>

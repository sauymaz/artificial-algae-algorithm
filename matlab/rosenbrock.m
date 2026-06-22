function value = rosenbrock(candidate)
%ROSENBROCK Rosenbrock benchmark function with global minimum 0 at ones.
value = sum(100 * (candidate(2:end) - candidate(1:end-1) .^ 2) .^ 2 ...
    + (1 - candidate(1:end-1)) .^ 2);
end

function value = ackley(candidate)
%ACKLEY Ackley benchmark function with global minimum 0 at the origin.
dimension = numel(candidate);
value = -20 * exp(-0.2 * sqrt(sum(candidate .^ 2) / dimension)) ...
    - exp(sum(cos(2 * pi * candidate)) / dimension) + 20 + exp(1);
end

function value = rastrigin(candidate)
%RASTRIGIN Rastrigin benchmark function with global minimum 0 at the origin.
value = 10 * numel(candidate) + sum(candidate .^ 2 - 10 * cos(2 * pi * candidate));
end

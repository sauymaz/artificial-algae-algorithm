function value = griewank(candidate)
%GRIEWANK Griewank benchmark function with global minimum 0 at the origin.
indices = 1:numel(candidate);
value = sum(candidate .^ 2) / 4000 - prod(cos(candidate ./ sqrt(indices))) + 1;
end

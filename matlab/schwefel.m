function value = schwefel(candidate)
%SCHWEFEL Schwefel 2.26 objective (unshifted; minimum is negative).
value = -sum(candidate .* sin(sqrt(abs(candidate))));
end

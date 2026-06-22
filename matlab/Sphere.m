function value = Sphere(candidate)
%SPHERE Sphere benchmark function with global minimum 0 at the origin.
value = sum(candidate .^ 2);
end

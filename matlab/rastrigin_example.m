% RASTRIGIN_EXAMPLE Run the published AAA mechanism on Rastrigin.
addpath(fileparts(mfilename('fullpath')));
parameters = struct('MaxFEVs', 10000, 'N', 40, 'D', 10, ...
    'LB', -5.12, 'UB', 5.12, 'K', 2, 'le', 0.3, 'Ap', 0.5);
[bestValue, bestPosition, history] = aaa(@rastrigin, parameters);
fprintf('Best value: %.6g\n', bestValue);
disp('Best position:');
disp(bestPosition);
plot(history); xlabel('Iteration'); ylabel('Best fitness'); grid on;

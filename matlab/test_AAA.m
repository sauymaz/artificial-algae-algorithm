% TEST_AAA Repeat AAA runs and summarize Rastrigin results.
clearvars;
addpath(fileparts(mfilename('fullpath')));
parameters = struct('MaxFEVs', 10000, 'N', 40, 'D', 10, ...
    'LB', -5.12, 'UB', 5.12, 'K', 2, 'le', 0.3, 'Ap', 0.5);
runs = 3;
values = zeros(1, runs);
times = zeros(1, runs);
for run = 1:runs
    tic;
    values(run) = aaa(@rastrigin, parameters);
    times(run) = toc;
    fprintf('Run = %d error = %1.8e\n', run, values(run));
end
fprintf('AAA\n');
fprintf('AvgFitness = %1.10e BestFitness = %1.10e WorstFitness = %1.10e Std = %1.10e Median = %1.10e\n', ...
    mean(values), min(values), max(values), std(values), median(values));
fprintf('Avg. time = %1.5e (%1.5e)\n', mean(times), std(times));

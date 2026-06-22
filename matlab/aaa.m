function [bestValue, bestPosition, history] = aaa(objectiveFunction, parameters)
%AAA Artificial Algae Algorithm for bounded continuous minimization.
%   BESTVALUE = AAA(OBJECTIVEFUNCTION, PARAMETERS) runs the AAA formulation
%   described by Uymaz, Tezel and Yel (2015). OBJECTIVEFUNCTION accepts one
%   row-vector candidate and returns its scalar cost.
%
%   PARAMETERS fields: MaxFEVs, N, D, LB, UB, K, le, Ap. D must be at least 3.
%   Optional outputs are the best position and a best-so-far history.

validateParameters(parameters);
lowerBounds = expandBounds(parameters.LB, parameters.D, 'LB');
upperBounds = expandBounds(parameters.UB, parameters.D, 'UB');
if any(lowerBounds >= upperBounds)
    error('aaa:InvalidBounds', 'Each lower bound must be below its upper bound.');
end

evaluations = parameters.N;
algae = lowerBounds + (upperBounds - lowerBounds) .* rand(parameters.N, parameters.D);
starvation = zeros(1, parameters.N);
greatness = ones(1, parameters.N);
costs = evaluatePopulation(objectiveFunction, algae);
[bestValue, bestIndex] = min(costs);
bestPosition = algae(bestIndex, :);
greatness = calculateGreatness(greatness, costs);
history = bestValue;

while evaluations < parameters.MaxFEVs
    energy = greatnessOrder(greatness);
    surface = frictionSurface(greatness);

    for index = 1:parameters.N
        starvedThisCycle = true;
        while energy(index) >= 0 && evaluations < parameters.MaxFEVs
            neighbor = tournamentSelection(costs);
            while neighbor == index
                neighbor = tournamentSelection(costs);
            end
            dimensions = randperm(parameters.D, 3);
            candidate = algae(index, :);
            shear = parameters.K - surface(index);
            difference = algae(neighbor, dimensions) - candidate(dimensions);
            candidate(dimensions(1)) = candidate(dimensions(1)) + difference(1) * shear * (2 * rand - 1);
            candidate(dimensions(2)) = candidate(dimensions(2)) + difference(2) * shear * cos(rand * 360);
            candidate(dimensions(3)) = candidate(dimensions(3)) + difference(3) * shear * sin(rand * 360);
            candidate = min(max(candidate, lowerBounds), upperBounds);

            candidateCost = objectiveFunction(candidate);
            evaluations = evaluations + 1;
            energy(index) = energy(index) - parameters.le / 2;
            if candidateCost <= costs(index)
                algae(index, :) = candidate;
                costs(index) = candidateCost;
                starvedThisCycle = false;
            else
                energy(index) = energy(index) - parameters.le / 2;
            end
        end
        if starvedThisCycle
            starvation(index) = starvation(index) + 1;
        end
    end

    [currentValue, currentIndex] = min(costs);
    if currentValue < bestValue
        bestValue = currentValue;
        bestPosition = algae(currentIndex, :);
    end
    history(end + 1, 1) = bestValue; %#ok<AGROW>

    greatness = calculateGreatness(greatness, costs);
    dimension = randi(parameters.D);
    [~, largest] = max(greatness);
    [~, smallest] = min(greatness);
    algae(smallest, dimension) = algae(largest, dimension);

    [~, mostStarved] = max(starvation);
    if rand < parameters.Ap
        algae(mostStarved, :) = algae(mostStarved, :) + ...
            (algae(largest, :) - algae(mostStarved, :)) .* rand(1, parameters.D);
        algae(mostStarved, :) = min(max(algae(mostStarved, :), lowerBounds), upperBounds);
    end
end
end

function validateParameters(parameters)
required = {'MaxFEVs', 'N', 'D', 'LB', 'UB', 'K', 'le', 'Ap'};
for index = 1:numel(required)
    if ~isfield(parameters, required{index})
        error('aaa:MissingParameter', 'Parameters.%s is required.', required{index});
    end
end
if parameters.N < 2 || parameters.D < 3 || parameters.MaxFEVs < parameters.N
    error('aaa:InvalidParameters', 'Require N >= 2, D >= 3, and MaxFEVs >= N.');
end
end

function bounds = expandBounds(bounds, dimension, name)
bounds = bounds(:)';
if isscalar(bounds)
    bounds = repmat(bounds, 1, dimension);
elseif numel(bounds) ~= dimension
    error('aaa:InvalidBounds', 'Parameters.%s must be scalar or have D elements.', name);
end
end

function costs = evaluatePopulation(objectiveFunction, population)
costs = zeros(1, size(population, 1));
for index = 1:size(population, 1)
    costs(index) = objectiveFunction(population(index, :));
end
end

function greatness = calculateGreatness(greatness, costs)
%CALCULATEGREATNESS Update colony sizes from normalized inverse costs.
fitness = normalize01(1 - normalize01(costs));
for index = 1:numel(greatness)
    saturationConstant = abs(greatness(index) / 2);
    growth = fitness(index) / (saturationConstant + fitness(index));
    greatness(index) = greatness(index) + growth * greatness(index);
end
end

function surface = frictionSurface(greatness)
%FRICTIONSURFACE Calculate normalized colony friction-surface areas.
radius = ((3 .* greatness) ./ (4 * pi)).^(1 / 3);
surface = normalize01(2 * pi .* radius.^2);
end

function energy = greatnessOrder(greatness)
%GREATNESSORDER Assign normalized squared energy ranks by colony size.
[~, order] = sort(greatness, 'ascend');
energy = zeros(size(greatness));
energy(order) = (1:numel(greatness)).^2;
energy = normalize01(energy);
end

function choice = tournamentSelection(costs)
%TOURNAMENTSELECTION Select the better of two randomly selected colonies.
candidates = randperm(numel(costs), 2);
if costs(candidates(1)) < costs(candidates(2))
    choice = candidates(1);
else
    choice = candidates(2);
end
end

function values = normalize01(values)
minimum = min(values);
maximum = max(values);
if maximum == minimum
    values = zeros(size(values));
else
    values = (values - minimum) / (maximum - minimum);
end
end

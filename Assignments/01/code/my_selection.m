function parentIds = my_selection(fitness, p)
%Selection - Returns indices of parents for crossover
% - Tournament selection:
%   1) N individuals are chosen randomly (N is selection pressure)
%   2) The individual in this subset with the highest fitness is chosen as
%   a parent
%   3) Another N individuals are chosen randomly
%   4) The individual in this subset with the highest fitness is chosen as
%   the other parent
%   5) Repeat steps 1-4 until you have one _pair_ of parents for each child
%   you plan on producing.
%
% Syntax:  parentIds = selection(fitness, p)
%
% Inputs:
%    fitness    - [M X 1] - Fitness of every individual in the population
%    p          - _struct - Hyperparameter struct
%     .sp                   - Selection Pressure
%
% Outputs:
%    parentIds  - [M X 2] - Indices of each pair of parents
%
% See also: crossover, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% This is 'random' selection of parent pairs, can you do better?
parentIds = randi(p.popSize, [p.popSize 2]);

%% TOURNAMENT SELECTION SOLUTION
for child_count = 1:p.popSize
    group = randi(p.popSize, [p.sp,2]); % Get two sets of random individuals
    [~, winner_index] = max(fitness(group)); % Get a parent from each set based on highest fitness
    
    first_parent_index = group(winner_index(1,1), 1);   % Get the first parent
    second_parent_index = group(winner_index(1,2), 2);  % Get the second parent
    
    parentIds(child_count, :) = [first_parent_index second_parent_index];
end
%------------- END OF CODE --------------
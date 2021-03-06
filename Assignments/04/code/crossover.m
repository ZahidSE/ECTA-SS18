function children  = crossover(pop, parentIds, p)
%Crossover - Creates child solutions by combining genes of parents
% - Single Point Crossover:
%   1) For each set of parents:
%   2) Determine whether or not to perform crossover (p.xoverChance)
%   3) If not, take first parent as child
%   4) If yes, choose random point along genome and:
%   5) Create child from genes behind point from parent A and in front of
%   that point from parent B
%
% Syntax:  children  = crossover(pop, parentIds, p)
%
% Inputs:
%    pop        - [M X N] - Population of M individuals
%    parentIds  - [M X 2] - Parent pair indices
%    p          - _struct - Hyperparameter struct
%     .crossProb            - Chance of performing crossover
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% No crossover happening, can you do better?
children = pop( parentIds(:,1) ,:);

%% ONE POINT CROSSOVER SOLUTION
for index=1:size(pop,1)
    doCrossOver = rand(1) < p.crossProb;    % Determine whether to do cross over or not
    
    if(doCrossOver)
        crossOverPoint = randi(size(pop,2));    % Define cross over point in case of cross over
        
        first_parent_index = parentIds(index,1);
        first_part = pop(first_parent_index,1:crossOverPoint);  % Take first part from the first parent
        
        second_parent_index = parentIds(index,2);
        second_part = pop(second_parent_index, crossOverPoint+1: size(pop,2));  % Take second part from second parent
        
        children(index,:) = [first_part second_part];   % combine the two parts
    else
        children(index, :) = pop(parentIds(index,1), :);    % Take first parent in case of no cross over
    end
end
%------------- END OF CODE -------------
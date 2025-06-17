% Facts
is_bird(sparrow).           % Sparrows are birds
can_fly(sparrow).           % Sparrows can fly
is_animal(X) :- is_bird(X). % Every bird is an animal

% Rules
flies(X) :- can_fly(X), is_bird(X). % If X can fly and X is a bird, then X flies
% Calculate the Manhattan distance between two positions
heuristic(pos(R1, C1), pos(R2, C2), Distance) :-
    Distance is abs(R1 - R2) + abs(C1 - C2).



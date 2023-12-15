

%Distanza di Chebyshev: Calcola la distanza di Chebyshev tra lo stato corrente e lo stato goal. Questa è calcolata come la massima delle differenze tra le coordinate.
heuristic(pos(R1, C1), pos(R2, C2), Distance) :-
    Distance is max(abs(R1 - R2), abs(C1 - C2)),.

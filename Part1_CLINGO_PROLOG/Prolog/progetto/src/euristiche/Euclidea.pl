%Distanza Euclidea: Calcola la distanza Euclidea tra lo stato corrente e lo stato goal. Questa è calcolata come la radice quadrata della somma dei quadrati delle differenze tra le coordinate.

heuristic(pos(R1, C1), pos(R2, C2), Distance) :-
    Distance is (R1 - R2)^2 + (C1 - C2)^2,.

contaPositivi([],0).
contaPositivi([X|Tail],TotalePos):
    X>0,-!,
    contaPositivi(Tail,Y),
    TotalePos is 1+Y.
contaPositivi([_|Tail],TotalePos):-
    contaPositivi(Tail,TotalePos).

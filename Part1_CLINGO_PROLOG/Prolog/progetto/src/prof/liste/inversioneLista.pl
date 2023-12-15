% inverti(Lista,ListaInvertita)
inverti([],[]).
inverti([Head|Tail],Res):-inverti(Tail,InvTail),append(InvTail,[Head],Res).

/* invertiOpt(Lista,ListaInvertita)
   invertiAux(Lista,ListaTemp,ListaInvertita)
*/
invertiOpt(Lista,ListaInvertita):-invertiAux(Lista,[],ListaInvertita).
invertiAux([],ListaTemp,ListaTemp).
invertiAux([Head|Tail],ListaTemp,ListaInvertita):-
    invertiAux(Tail,[Head|ListaTemp],ListaInvertita).
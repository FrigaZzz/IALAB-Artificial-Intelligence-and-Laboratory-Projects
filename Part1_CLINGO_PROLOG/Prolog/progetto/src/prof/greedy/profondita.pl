risolvi(S,[],_):-finale(S),!.
risolvi(S,[Az|ListaAzioni],Visitati):-
    applicabile(Az,S),
    trasforma(Az,S,Snuovo),
    \+member(Snuovo,Visitati),
    risolvi(Snuovo,ListaAzioni,[S|Visitati]).
prova(Cammino,Limite):-
    iniziale(S0),risolvi(S0,Cammino,[],Limite).
risolvi(S,[],_,_):-finale(S),!.
risolvi(S,[Az|ListaAzioni],Visitati,ProfMax):-
    ProfMax > 0,
    applicabile(Az,S),
    trasforma(Az,S,Snuovo),
    \+member(Snuovo,Visitati),
    NuovaProfMax is ProfMax-1,
    risolvi(Snuovo,ListaAzioni,[S|Visitati],NuovaProfMax).
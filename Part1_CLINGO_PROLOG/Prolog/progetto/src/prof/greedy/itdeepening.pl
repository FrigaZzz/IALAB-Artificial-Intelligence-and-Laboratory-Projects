initialize:-retractall(current_depth(_)),
            assert(current_depth(1)).
:- initialize.
prova(Cammino):-
    iniziale(S0),
    current_depth(D),
    write('---- Profondita: '),write(D),write('\n'),
    risolvi(S0,Cammino,[],D).
prova(Cammino):-
    current_depth(D),
    DNew is D+1,
    retractall(current_depth(_)),
    assert(current_depth(DNew)),
    prova(Cammino).

risolvi(S,[],_,_):-finale(S),!.
risolvi(S,[Az|ListaAzioni],Visitati,ProfMax):-
    ProfMax > 0,
    applicabile(Az,S),
    trasforma(Az,S,Snuovo),
    \+member(Snuovo,Visitati),
    NuovaProfMax is ProfMax-1,
    risolvi(Snuovo,ListaAzioni,[S|Visitati],NuovaProfMax).
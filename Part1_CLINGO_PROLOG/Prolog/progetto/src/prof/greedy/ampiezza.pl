% Codice origianale del prof
% -> bisogna adattarlo ad A* per rankare gli stati

provaAmpiezza(Soluzione):-
    iniziale(S),
    bfs([nodo(S,[])],[],Soluzione).

bfs([nodo(S,AzioniPerS)|_],_,AzioniPerS):-
    finale(S),!.
bfs([nodo(S,AzioniPerS)|CodaStati],Visitati,Soluzione):-
    findall(Az,applicabile(Az,S),ListaAzioniApplicabili),
    generaStatiFigli(nodo(S,AzioniPerS),[S|Visitati],ListaAzioniApplicabili,StatiFigli),
    append(CodaStati,StatiFigli,NuovaCoda),
    bfs(NuovaCoda,[S|Visitati],Soluzione).

generaStatiFigli(_,_,[],[]).
generaStatiFigli(nodo(S,AzioniPerS),Visitati,[Az|AltreAzioni],[nodo(SNuovo,[Az|AzioniPerS])|AltriFigli]):-
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    !,
    generaStatiFigli(nodo(S,AzioniPerS),Visitati,AltreAzioni,AltriFigli).
generaStatiFigli(nodo(S,AzioniPerS),Visitati,[_|AltreAzioni],AltriFigli):-
    generaStatiFigli(nodo(S,AzioniPerS),Visitati,AltreAzioni,AltriFigli).
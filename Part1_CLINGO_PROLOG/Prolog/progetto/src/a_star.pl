% Predicato principale per trovare una soluzione al problema
prova(Soluzione) :-
    a_star(Soluzione).

% Algoritmo A* per la ricerca della soluzione
a_star(Soluzione) :-
    % Inizializzazione dello stato iniziale
    iniziale(S),
    % Avvio della ricerca in ampiezza (bfs) con uno stato iniziale
    bfs([nodo(S, [], 0)], [], Soluzione).

% Caso base: se lo stato attuale è uno stato finale, restituisci le azioni per raggiungerlo
bfs([nodo(S, AzioniPerS, _)|_], _, AzioniPerSInvertita) :- 
    finale(S), 
    invertiOpt(AzioniPerS, AzioniPerSInvertita).

% Altrimenti, espandi lo stato attuale
bfs([nodo(S, AzioniPerS, F)|CodaStati], Visitati, Soluzione) :-
    % Apri il file di log in modalità append
    open('log.txt', append, LogFile),
    % Scrivi un messaggio per indicare una nuova iterazione
    write(LogFile, 'New iteration...\n'),
    write(LogFile, Visitati),
    nl(LogFile),  % Nuova linea nel file di log
    % Chiudi il file di log
    close(LogFile),
    % Trova tutte le azioni applicabili nello stato corrente
    findall(Az, applicabile(Az, S), ListaAzApplicabili),
    % Genera gli stati figli a partire dalle azioni applicabili
    generaStatiFigli(nodo(S, AzioniPerS, F), [S|Visitati], ListaAzApplicabili, StatiFigli),
    % Ordina la coda degli stati secondo l'euristica
    insert_sort(CodaStati, StatiOrdered),
    % Aggiungi gli stati figli alla coda
    append(StatiOrdered, StatiFigli, NuovaCoda),
    % Continua la ricerca
    bfs(NuovaCoda, [S|Visitati], Soluzione).

% Genera gli stati figli a partire dalle azioni applicabili
generaStatiFigli(_, _, [], []).

generaStatiFigli(nodo(S, AzioniPerS, F), Visitati, [Az|AltreAzioni], [nodo(SNuovo, [Az|AzioniPerS], F)|AltriFigli]) :-  
    % Applica l'azione allo stato corrente per ottenere un nuovo stato
    trasforma(Az, S, SNuovo),
     % Verifica che lo stato non sia stato visitato in precedenza
     % controllo prima così da non dover calcolare l'euristica
    \+member(SNuovo, Visitati),
    !,
    % Calcola l'euristica per il nuovo stato
    calculate_heuristics(S, H),
    % Calcola il costo g(n) del cammino finora
    length(AzioniPerS, LenAzioniPerS),
    % Calcola il costo totale f(n) per il nuovo stato
    NF is H + LenAzioniPerS,
    % Genera gli stati figli per il nuovo stato
    generaStatiFigli(nodo(S, AzioniPerS, NF), Visitati, AltreAzioni, AltriFigli).

% Caso in cui l'azione non può essere applicata, continua senza generarne stati figli
generaStatiFigli(nodo(S, AzioniPerS, _), Visitati, [_|AltreAzioni], AltriFigli) :-
    % Calcola l'euristica per lo stato corrente S
    calculate_heuristics(S, H),
    % Calcola il costo totale f(n) per lo stato corrente
    length(AzioniPerS, LenAzioniPerS),
    NF is H + LenAzioniPerS,  
    % Genera gli stati figli per lo stato corrente
    generaStatiFigli(nodo(S, AzioniPerS, NF), Visitati, AltreAzioni, AltriFigli).


% Ordina la lista degli stati in base al costo totale f(n) usando l'algoritmo di inserimento
insert_sort(List, Sorted) :- i_sort(List, [], Sorted).
i_sort([], Acc, Acc).
i_sort([Head|Tail], Acc, Sorted) :-
    insert(Head, Acc, NAcc),
    i_sort(Tail, NAcc, Sorted).

% Inserisce uno stato nella lista ordinata in base al costo totale f(n)
insert(nodo(S, AzioniPerS, F_X), [nodo(S2, AzioniPerS2, F_Y)|T], [nodo(S2, AzioniPerS2, F_Y)|NT]) :- 
    F_X > F_Y,
    insert(nodo(S, AzioniPerS, F_X), T, NT).

insert(nodo(S, AzioniPerS, F_X), [nodo(S2, AzioniPerS2, F_Y)|T], [nodo(S, AzioniPerS, F_X),nodo(S2, AzioniPerS2, F_Y)|T]) 
    :-
    F_X =< F_Y.

insert(nodo(S, AzioniPerS, F_X), [], [nodo(S, AzioniPerS, F_X)]).

% Calculate the heuristic H for the current state against all possible final states
calculate_heuristics(pos(Riga, Col), MinimumHeuristic) :-
    findall(Heuristic, (
        finale(pos(RFin, ColFin)),
        heuristic(pos(Riga, Col), pos(RFin, ColFin), Heuristic)
    ), Heuristics),
    min_list(Heuristics, MinimumHeuristic).
    %write('Calcolo euristica per pos('), write(Heuristics), nl.

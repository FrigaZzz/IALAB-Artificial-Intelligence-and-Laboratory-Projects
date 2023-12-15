% IDA*

:- dynamic(nuovoLimite/1).
initialize:-retractall(current_depth(_)),
            assert(current_depth(1)).
:- initialize.
% Predicato principale per trovare una soluzione
prova(Soluzione) :-
    idaStar(Soluzione).

% Funzione principale IDA*.
idaStar(Soluzione) :- 
    iniziale(S), 
    % Inizializza il costo accumulato G a 0 e calcola il costo totale stimato F_S.
    f(S, 0, F_S), % G = 0, F_S = H_S
    provaPL(Soluzione, F_S).

% Inizializza il costo accumulato G a 0 e avvia la ricerca in profondità limitata.
provaPL(Soluzione, Limite) :-
    write('---- Profondita: '),write(Limite),write('\n'),

    iniziale(S),
    G is 0,
    retractall(nuovoLimite(_)),
    assert(nuovoLimite(inf)),
    ricerca_depth_limitata(S, [], Limite, Soluzione, G),
    !. % Il "!" impedisce al Prolog di cercare alternative. In questo caso, se una soluzione è trovata, interrompe la ricerca.

% Se provaPL fallisce, prova con un nuovo limite.
provaPL(Soluzione, _) :-
    nuovoLimite(NuovoLimite),
    provaPL(Soluzione, NuovoLimite).

% Verifica se lo stato è finale.
ricerca_depth_limitata(S, _, _, [], _) :- 
    finale(S), 
    !. % Il "!" impedisce al Prolog di cercare altre soluzioni dopo aver trovato una sequenza di azioni che porta a uno stato finale.

% Esegue la ricerca in profondità controllando il limite con l'euristica.
ricerca_depth_limitata(S, Visitati, Limite, [Az | SequenzaAzioni], G) :-

    % Apri il file di log in modalità append
    open('log.txt', append, LogFile),
    % Scrivi un messaggio per indicare una nuova iterazione
    write(LogFile, 'New iteration...\n'),
    write(LogFile, Visitati),
    nl(LogFile),  % Nuova linea nel file di log
    % Chiudi il file di log
    close(LogFile),

    f(S, G, F_S),
    F_S =< Limite,
    !, % Il "!" impedisce al Prolog di cercare alternative. Se f(S, G, F_S) <= Limite, continua l'esplorazione.

    applicabile(Az, S),
    trasforma(Az, S, SNuovo),
    \+member(SNuovo, Visitati), % Controlla se lo stato SNuovo è già stato visitato.
    NuovoG is G + 1, % Ogni passo è considerato a costo unitario.
    ricerca_depth_limitata(SNuovo, [S | Visitati], Limite, SequenzaAzioni, NuovoG).

% Calcola il nuovo limite se f(S, G, F_S) > Limite.
ricerca_depth_limitata(S, _, _, _, G) :-
    f(S, G, F_S),
    nuovoLimite(NuovoLimite),
    F_S < NuovoLimite,
    retractall(nuovoLimite(_)),
    assert(nuovoLimite(F_S)),
    false. % Il "false" forza il fallimento della regola, permettendo al Prolog di tornare indietro e continuare la ricerca con il nuovo limite.

% Funzione di valutazione f(S, G, F).
f(S, G, F) :- 
    calculate_heuristics(S, H), 
    F is G + H.

% Calculate the heuristic H for the current state against all possible final states
calculate_heuristics(pos(Riga, Col), MinimumHeuristic) :-
    findall(Heuristic, (
        finale(pos(RFin, ColFin)),
        heuristic(pos(Riga, Col), pos(RFin, ColFin), Heuristic)
    ), Heuristics),
    min_list(Heuristics, MinimumHeuristic).
    %write('Calcolo euristica per pos('), write(Heuristics), nl.
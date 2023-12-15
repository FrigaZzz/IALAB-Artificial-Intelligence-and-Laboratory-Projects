:- discontiguous finale/1.
:- discontiguous occupata/1.
:- discontiguous iniziale/1.
 % perché le mappe che genero hanno a volte (finale(pos..)) in fondo al file
% values : 5x5 10x10
:- include('./mappe/30x30.pl').
% values : Euclidea - Manhattan - Chebyshev, solo per A*
:- include('./src/euristiche/Manhattan.pl').


:- include('./src/azioni.pl').
:- include('./src/utils.pl').
:- include('./src/a_star.pl').

% :- include('./src/prof/greedy/itdeepening.pl').

% :- trace.

:- 
    prova(X),write(X)
   , length(X, N), 
   write('Lista: '), write(X), 
   nl,  % new line
   write('Numero di elementi: '), write(N),
   save_output_to_file('./mappe/output.txt', X+N).
% :- notrace.

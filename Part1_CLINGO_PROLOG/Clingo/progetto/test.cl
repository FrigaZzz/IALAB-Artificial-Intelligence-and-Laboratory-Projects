uccello(X):- pinguino(X).
-vola(X):- pinguino(X).
vola(X):- uccello(X), not -vola(X).


pinguino(tweety).



---------------

p:- a.
a:- not b.
b:- not a.

-> candidati sottinsiemi {{0},{a},{b},{a,b},{a,b,p}}


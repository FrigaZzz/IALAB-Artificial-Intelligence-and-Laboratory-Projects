piuCalorico(pancetta,wurstel).
piuCalorico(wurstel,banana).
piuCalorico(banana,verza).
piuCalorico(banana,cetriolo).

maggiormenteCalorico(X,Y):-piuCalorico(X,Y).
maggiormenteCalorico(X,Y):-
    piuCalorico(X,Z),
    maggiormenteCalorico(Z,Y).
:- include('./prof/liste/inversioneLista.pl').
% rimosso l'import di BFS siccome l'ho dovuta sistemare

% trovata online per stampare output su file
save_output_to_file(FileName, Output) :-
    open(FileName, write, Stream),
    write(Stream, Output),
    close(Stream).

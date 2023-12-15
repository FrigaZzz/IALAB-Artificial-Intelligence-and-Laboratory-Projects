% 1. Definizione delle squadre
squadra(a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t).

% 2. Definizione delle giornate
giornata(1..38).

% 3. Definizione delle città e mapping sulla squadra
citta(usfq; zviz; wisw; uwiw; azwk; vrge; dfjd; irzi; zkpc; ngma; ndgg; rtsw; xuwr; xuzx; cmgb; vinm; nxtb; fkhc; uhmg; ).

afferisce(a,usfq).         %  Due delle 20 squadre fanno riferimento alla medesima città 
afferisce(t,usfq).         
afferisce(b,zviz).        
afferisce(s,wisw).        
afferisce(c,vrge).        
afferisce(r,uwiw).        
afferisce(d,dfjd).          
afferisce(q,azwk).          
afferisce(e,irzi).
afferisce(p,zkpc).
afferisce(f,ngma).
afferisce(o,ndgg).
afferisce(g,rtsw).
afferisce(n,xuwr).
afferisce(h,xuzx).
afferisce(m,cmgb).
afferisce(i,vinm).
afferisce(l,nxtb).
afferisce(j,fkhc).
afferisce(k,uhmg).

% Regole per definire le partite

% Ogni squadra gioca MAX due volte contro tutte le altre squadre (una in casa e una fuori) 
1 {gioca(S,A,C,G):citta(C),giornata(G)} 1 :- squadra(S),squadra(A),S<>A,afferisce(S,C).
1 {gioca(A,S,C,G):citta(C),giornata(G)} 1 :- squadra(S),squadra(A),S<>A,afferisce(A,C).

% Violazione di vincolo se squadre diverse della stessa citta possono giocare in casa nella stessa giornata.
% Quindi violazione se S1 e S2 sono della stessa città e giocano in casa nella stessa giornata ma contro una squadra diversa.
:- squadra(S1;S2;S3),giornata(N),afferisce(S1,C),afferisce(S2,C),S1<>S2,gioca(S1,S3,C,N),gioca(S3,S1,C,N).
:- squadra(S1;S2;S3),giornata(N),afferisce(S1,C),afferisce(S2,C),S1<>S2,gioca(S2,S3,C,N),gioca(S3,S2,C,N).
% Scritta due volte per gestire sia per S1 sia per S2

% per ogni squadra e giornata, conta gli avversari che la prima squadra deve affrontare.
% Quindi quando S è il primo argomento di gioca.
1 { incasa(S,G,N) } 1 :- squadra(S),giornata(G),N = #count{A,S:squadra(S),afferisce(S,C),gioca(S,A,C,G)}.
% Ora, la stessa cosa, solo che devi contare per le partite in trasferta. Quindi quando S è il secondo argomento di gioca.
1 { fuoricasa(S,G,N) } 1 :- squadra(S),giornata(G),N = #count{A,S:squadra(S),afferisce(A,C),gioca(A,S,C,G)}.


% Ciascuna squadra non deve giocare mai più di due partite consecutive in casa o fuori casa
:- squadra(S), giornata(G), incasa(S, G, PiC), fuoricasa(S, G, PfC), N = PiC + PfC, N > 2.

% la distanza tra una coppia di gare di andata e ritorno è di almeno 10 giornate,
:- giornata(G1), giornata(G2), G1 < G2, gioca(S1, S2, _, G1), gioca(S2, S1, _, G2), G2 - G1 < 10.

#show gioca/4.



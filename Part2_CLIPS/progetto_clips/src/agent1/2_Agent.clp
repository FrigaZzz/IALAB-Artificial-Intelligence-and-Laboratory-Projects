;  ---------------------------------------------
;  --- Definizione del modulo e dei template ---
;  ---------------------------------------------
(defmodule AGENT (import MAIN ?ALL) (import ENV ?ALL) (export ?ALL))


(deftemplate agent-per-row
	(slot row)
	(slot num)
)

(deftemplate agent-per-col
	(slot col)
	(slot num)
)

(deftemplate agent-cell
	(slot x)
	(slot y)
	(slot content (allowed-values unknown water boat next-guess))
)


(deffacts agent-battle-field
	(agent-cell (x 0) (y 0) (content unknown) )
	(agent-cell (x 0) (y 1) (content unknown) )
	(agent-cell (x 0) (y 2) (content unknown) )
	(agent-cell (x 0) (y 3) (content unknown) )
	(agent-cell (x 0) (y 4) (content unknown) )
	(agent-cell (x 0) (y 5) (content unknown) )
	(agent-cell (x 0) (y 6) (content unknown) )
	(agent-cell (x 0) (y 7) (content unknown) )
	(agent-cell (x 0) (y 8) (content unknown) )
	(agent-cell (x 0) (y 9) (content unknown) )
	(agent-cell (x 1) (y 0) (content unknown) )
	(agent-cell (x 1) (y 1) (content unknown) )
	(agent-cell (x 1) (y 2) (content unknown) )
	(agent-cell (x 1) (y 3) (content unknown) )
	(agent-cell (x 1) (y 4) (content unknown) )
	(agent-cell (x 1) (y 5) (content unknown) )
	(agent-cell (x 1) (y 6) (content unknown) )
	(agent-cell (x 1) (y 7) (content unknown) )
	(agent-cell (x 1) (y 8) (content unknown) )
	(agent-cell (x 1) (y 9) (content unknown) )
	(agent-cell (x 2) (y 0) (content unknown) )
	(agent-cell (x 2) (y 1) (content unknown) )
	(agent-cell (x 2) (y 2) (content unknown) )
	(agent-cell (x 2) (y 3) (content unknown) )
	(agent-cell (x 2) (y 4) (content unknown) )
	(agent-cell (x 2) (y 5) (content unknown) )
	(agent-cell (x 2) (y 6) (content unknown) )
	(agent-cell (x 2) (y 7) (content unknown) )
	(agent-cell (x 2) (y 8) (content unknown) )
	(agent-cell (x 2) (y 9) (content unknown) )
	(agent-cell (x 3) (y 0) (content unknown) )
	(agent-cell (x 3) (y 1) (content unknown) )
	(agent-cell (x 3) (y 2) (content unknown) )
	(agent-cell (x 3) (y 3) (content unknown) )
	(agent-cell (x 3) (y 4) (content unknown) )
	(agent-cell (x 3) (y 5) (content unknown) )
	(agent-cell (x 3) (y 6) (content unknown) )
	(agent-cell (x 3) (y 7) (content unknown) )
	(agent-cell (x 3) (y 8) (content unknown) )
	(agent-cell (x 3) (y 9) (content unknown) )
	(agent-cell (x 4) (y 0) (content unknown) )
	(agent-cell (x 4) (y 1) (content unknown) )
	(agent-cell (x 4) (y 2) (content unknown) )
	(agent-cell (x 4) (y 3) (content unknown) )
	(agent-cell (x 4) (y 4) (content unknown) )
	(agent-cell (x 4) (y 5) (content unknown) )
	(agent-cell (x 4) (y 6) (content unknown) )
	(agent-cell (x 4) (y 7) (content unknown) )
	(agent-cell (x 4) (y 8) (content unknown) )
	(agent-cell (x 4) (y 9) (content unknown) )
	(agent-cell (x 5) (y 0) (content unknown) )
	(agent-cell (x 5) (y 1) (content unknown) )
	(agent-cell (x 5) (y 2) (content unknown) )
	(agent-cell (x 5) (y 3) (content unknown) )
	(agent-cell (x 5) (y 4) (content unknown) )
	(agent-cell (x 5) (y 5) (content unknown) )
	(agent-cell (x 5) (y 6) (content unknown) )
	(agent-cell (x 5) (y 7) (content unknown) )
	(agent-cell (x 5) (y 8) (content unknown) )
	(agent-cell (x 5) (y 9) (content unknown) )
	(agent-cell (x 6) (y 0) (content unknown) )
	(agent-cell (x 6) (y 1) (content unknown) )
	(agent-cell (x 6) (y 2) (content unknown) )
	(agent-cell (x 6) (y 3) (content unknown) )
	(agent-cell (x 6) (y 4) (content unknown) )
	(agent-cell (x 6) (y 5) (content unknown) )
	(agent-cell (x 6) (y 6) (content unknown) )
	(agent-cell (x 6) (y 7) (content unknown) )
	(agent-cell (x 6) (y 8) (content unknown) )
	(agent-cell (x 6) (y 9) (content unknown) )
	(agent-cell (x 7) (y 0) (content unknown) )
	(agent-cell (x 7) (y 1) (content unknown) )
	(agent-cell (x 7) (y 2) (content unknown) )
	(agent-cell (x 7) (y 3) (content unknown) )
	(agent-cell (x 7) (y 4) (content unknown) )
	(agent-cell (x 7) (y 5) (content unknown) )
	(agent-cell (x 7) (y 6) (content unknown) )
	(agent-cell (x 7) (y 7) (content unknown) )
	(agent-cell (x 7) (y 8) (content unknown) )
	(agent-cell (x 7) (y 9) (content unknown) )
	(agent-cell (x 8) (y 0) (content unknown) )
	(agent-cell (x 8) (y 1) (content unknown) )
	(agent-cell (x 8) (y 2) (content unknown) )
	(agent-cell (x 8) (y 3) (content unknown) )
	(agent-cell (x 8) (y 4) (content unknown) )
	(agent-cell (x 8) (y 5) (content unknown) )
	(agent-cell (x 8) (y 6) (content unknown) )
	(agent-cell (x 8) (y 7) (content unknown) )
	(agent-cell (x 8) (y 8) (content unknown) )
	(agent-cell (x 8) (y 9) (content unknown) )
	(agent-cell (x 9) (y 0) (content unknown) )
	(agent-cell (x 9) (y 1) (content unknown) )
	(agent-cell (x 9) (y 2) (content unknown) )
	(agent-cell (x 9) (y 3) (content unknown) )
	(agent-cell (x 9) (y 4) (content unknown) )
	(agent-cell (x 9) (y 5) (content unknown) )
	(agent-cell (x 9) (y 6) (content unknown) )
	(agent-cell (x 9) (y 7) (content unknown) )
	(agent-cell (x 9) (y 8) (content unknown) )
	(agent-cell (x 9) (y 9) (content unknown) )
)

; Debug: verifico che i facts vengano correttamente aggiornati
; (defrule restart (declare (salience 50))
;     (status (step ?s&:(< ?s 3))(currently running))
; =>
;    (printout t "Called agent "  crlf)    
; )

; Debug: verifico che i facts vengano correttamente aggiornati
; (defrule check_fired
;     (declare (salience 50))
;     (status (step ?s)(currently running))
;     ?act <- (n_actions (n_fire ?nf)(n_guess ?ng))
; =>
;     (printout t "step " ?s "> fire: " ?nf crlf)    
; )


; ------------------------------ INIZIALIZZAZIONE ------------------------------
; Rule to assert k-cell with content water for agent-per-row and initialize if necessary
(defrule setWaterKRow (declare (salience 30))
    (status (step 0)(currently running))
    (agent-per-row (row ?r) (num 0))
	?cell <- (agent-cell (x ?r) (y ?c) (content unknown) )
=>
;    (printout t "WATER on ROW " ?r crlf)
    (modify ?cell (content water))        
)

; Rule to assert k-cell with content water for agent-per-col and initialize if necessary
(defrule setWaterKCol (declare (salience 30))
    (status (step 0)(currently running))
    (agent-per-col (col ?c) (num 0))
	?cell <- (agent-cell (x ?r) (y ?c) (content unknown) )
=>
    ;  (printout t "WATER on ROW " ?r crlf)
    (modify ?cell (content water))        
)


; clone k-per-col inside agent-k-per-col only at step 0
(defrule clone-k-per-r
    (declare (salience 31))
    (status (step 0))
    (k-per-col (col ?c) (num ?n))
    (not (agent-per-col (col ?c) (num ?nc)))
   
=>
    (assert (agent-per-col (col ?c) (num ?n)))
)

(defrule clone-k-per 
    (declare (salience 30))
    (status (step 0))
  
    (k-per-row (row ?r) (num ?n))
    (not (agent-per-row (row ?r) (num ?nr)))
=>
    (assert (agent-per-row (row ?r) (num ?n)))
)

; ------------------------------ FIRE UNKNOWN------------------------------
; Fire centrato sulla cella di intersezione tra la riga e la colonna con piu navi ancora da colpire
  ; Disabilitato perché perriora le performance



; Fire centrato sulla cella di intersezione sulla riga con piu navi ancora da colpire
; se lo attivo si abbassa di moolto il punteggio (-64)

(defrule fire-most-probable-cell-row-col (declare (salience 5))
    (moves (fires ?n&:(> ?n 0)))
    (status (step ?s)(currently running))

    (agent-per-row (row ?r) (num ?max-row &:(> ?max-row 0)))
	(agent-per-col (col ?c) (num ?max-col&:(> ?max-col 0)))
	(not (agent-per-row (row ?r2&:(neq ?r2 ?r)) (num ?n1&:(> ?n1 ?max-row))))
    (not (agent-per-col (col ?c2&:(neq ?c2 ?c)) (num ?n2&:(> ?n2 ?max-col))))

    (agent-cell (x ?r) (y ?c) (content unknown))
    (not (exec (action fire|guess) (x ?r) (y ?c)))
=>
	
    (assert (exec (step ?s) (action fire) (x ?r) (y ?c)))
    (printout t "Fire row-col  [" ?r ", " ?c "] at step " ?s crlf)
    (pop-focus)
)

; Fire centrato sulla cella di intersezione sulla riga con piu navi ancora da colpire
(defrule fire-most-probable-cell-row-col-only (declare (salience 5))
    (moves (fires ?n&:(> ?n 0)))
    (status (step ?s)(currently running))

    (agent-per-row (row ?r) (num ?max-row &:(> ?max-row 0)))
	(not (agent-per-row (row ?r2&:(neq ?r2 ?r)) (num ?n1&:(> ?n1 ?max-row))))
	(agent-per-col (col ?c) (num ?max-col&:(> ?max-col 0)))

    (agent-cell (x ?r) (y ?c) (content unknown))
    (not (exec (action fire|guess) (x ?r) (y ?c)))
=>
	
    (assert (exec (step ?s) (action fire) (x ?r) (y ?c)))
    (printout t "Fire row su posizione [" ?r ", " ?c "] at step " ?s crlf)
    (pop-focus)
)
; Fire centrato sulla cella di intersezione sulla colonna con piu navi ancora da colpire
(defrule fire-most-probable-cell-col-only  (declare (salience 5))
    (moves (fires ?n&:(> ?n 0)))
	(status (step ?s)(currently running))

    (agent-per-col (col ?c) (num ?max-col&:(> ?max-col 0)))
    (not (agent-per-col (col ?c2&:(neq ?c2 ?c)) (num ?n2&:(> ?n2 ?max-col))))
    (agent-per-row (row ?r) (num ?max-row &:(> ?max-row 0)))

    (agent-cell (x ?r) (y ?c) (content unknown))
    (not (exec (action fire|guess) (x ?r) (y ?c)))
=>

    (assert (exec (step ?s) (action fire) (x ?r) (y ?c)))
    (printout t "Fire col su posizione [" ?r ", " ?c "] at step " ?s crlf)
    (pop-focus)
)


; ------------------------------ POST FIRE ------------------------------
; Post fire: k-cell sarà stata rivelata, di conseguenza aggiorno i fatti in seguito
; all'azione percettiva. Definiamo quindi le rule:

; Caso in cui la cella contiene un pezzo di barca
; Non riduco ncol e nrow perché altrimenti vengo penalizzato e l'agente non cerca piu di fare guess
(defrule observed-data-no-water (declare (salience 20))
    ?ag_cell <- (agent-cell (x ?x)(y ?y)(content unknown))
    ?k_cell <- (k-cell (x ?x) (y ?y) (content ?c&:(neq ?c water)))
	?nrow <- (agent-per-row (row ?x) (num ?nr))
	?ncol <- (agent-per-col (col ?y) (num ?nc))
=>
	; (printout t "pre ship per row/col [" ?x ", " ?y "]  " ?nr "|"  ?nc crlf)

    ; (modify ?ag_cell (content ?c))
	; (bind ?nr (- ?nr 1))
	; (modify ?nrow (num ?nr))
	; (bind ?nc (- ?nc 1))
	; (modify ?ncol (num ?nc))
    (printout t "nrow-observed in pos [" ?x ", " ?y "]" ?c crlf)
	; (printout t "pre ship row/col [" ?x ", " ?y "]  " ?nr "|" ?nc crlf)

)

; Caso in cui la cella contiene acqua
(defrule observed-data-water  (declare (salience 20))
    ?ag_cell <- (agent-cell (x ?x)(y ?y)(content unknown))
    ?k_cell <- (k-cell (x ?x) (y ?y) (content water))
=>

    (modify ?ag_cell (content water))
    ; (printout t "last shot fired was on water"  crlf)

)


; ------------------------------ GUESS ------------------------------

(defrule guess-most-probable-cell-row-col (declare (salience 2))
    (moves  (guesses ?ng&:(> ?ng 0)))
    (status (step ?s)(currently running))

	?nrow <- (agent-per-row (row ?r) (num ?nr))
	?ncol <- (agent-per-col (col ?c) (num ?nc))
	; non esiste un altro massimo 
    (not (agent-per-row (row ?r2&:(neq ?r2 ?r)) (num ?n2 &:(> ?n2 ?nr))))
	(not (agent-per-col (col ?c2&:(neq ?c2 ?c)) (num ?m2 &:(> ?m2 ?nc))))
    (agent-cell (x ?r) (y ?c)(content ~water))
    (not (exec (action guess) (x ?r) (y ?c)))
	
=>
    (assert (exec (step ?s) (action guess) (x ?r) (y ?c)))
	(bind ?nr (- ?nr 1))
	(modify ?nrow (num ?nr))
	(bind ?nc (- ?nc 1))
	(modify ?ncol (num ?nc))
    (printout t "Guess most prob, row+col  posizione [" ?r ", " ?c "] at step " ?s crlf)
    (pop-focus)
)
; Fire centrato sulla cella di intersezione sulla colonna con piu navi ancora da colpire
(defrule guess-most-probable-cell-col-only (declare (salience 5))
    (moves  (guesses ?ng&:(> ?ng 0)))
	(status (step ?s)(currently running))

    ?ncol <-(agent-per-col (col ?c) (num ?max-col&:(> ?max-col 0)))
    (not (agent-per-col (col ?c2) (num ?n2&:(> ?n2 ?max-col))))

    (agent-cell (x ?r) (y ?c) (content unknown))
    (not (exec (action fire|guess) (x ?r) (y ?c)))
=>
	(bind ?nc (- ?max-col 1))
	(modify ?ncol (num ?nc))
    (assert (exec (step ?s) (action guess) (x ?r) (y ?c)))
    (printout t "Guess most prob, su col  posizione [" ?r ", " ?c "] at step " ?s crlf)
    (pop-focus)
)

; Fire centrato sulla cella di intersezione sulla colonna con piu navi ancora da colpire
(defrule guess-most-probable-cell-row-only (declare (salience 5))
    (moves  (guesses ?ng&:(> ?ng 0)))
	(status (step ?s)(currently running))

    ?ncol <-(agent-per-row (row ?r) (num ?max-col&:(> ?max-col 0)))
    (not (agent-per-row (row ?c2) (num ?n2&:(> ?n2 ?max-col))))

    (agent-cell (x ?r) (y ?c) (content unknown))
    (not (exec (action fire|guess) (x ?r) (y ?c)))
=>
	(bind ?nc (- ?max-col 1))
	(modify ?ncol (num ?nc))
    (assert (exec (step ?s) (action guess) (x ?r) (y ?c)))
    (printout t "Guess most prob, su row  posizione [" ?r ", " ?c "] at step " ?s crlf)
    (pop-focus)
)

(defrule guess-tail (declare (salience 5))
	(moves  (guesses ?ng&:(> ?ng 0)))
    (status (step ?s)(currently running))

    (agent-cell (x ?x) (y ?y) (content unknown)) 

	?nrow <- (agent-per-row (row ?x) (num ?nr))
	?ncol <- (agent-per-col (col ?y) (num ?nc))
	(test (> ?nr 0))
	(test (> ?nc 0))
    (not (exec (action fire|guess) (x ?x) (y ?y)))
=>
	(assert (exec (step ?s) (action guess) (x ?x) (y ?y)))
	(bind ?nr (- ?nr 1))
	(modify ?nrow (num ?nr))
	(bind ?nc (- ?nc 1))
	(modify ?ncol (num ?nc))

    (printout t "Guess su elemento in coda [" ?x ", " ?y "] at step " ?s crlf)
    (pop-focus)
)


; ------------------------------ END ------------------------------

(defrule nothing-more-to-do (declare (salience -1))
	(status (step ?s)(currently running))
=>
	(assert (exec (step ?s) (action solve)))
	(printout t "called solve" crlf)
	(pop-focus)
)
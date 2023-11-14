= Derivanti dell'entropia
== Entropia congiunta
Siano $XX$ e $YY$ due variabili casuali con valori in insiemi finiti $Chi$ e $Y$, detta $p$ la loro distribuzione congiunta $p(x,y) = P(XX = x, YY = y)$, definiamo l'entropia congiunta $H(XX,YY)$ come 
$ H(XX,YY) = sum_(x in Chi) sum_(y in Y) p(x,y) log_2 1/ (p (x,y)) $
Possiamo pensare all'entropia congiunta come al numero medio di bit necessari per rappresentare una coppia di valori estratti da $Chi$ e $Y$.
== Entropia condizionale
Siano $XX$ e $YY$ due variabili casuali con valori in insiemi finiti $Chi$ e $Y$, detta $p$ la loro distribuzione congiunta $p(x,y) = P(XX = x, YY = y)$, definiamo l'entropia condizionale $H(YY,XX)$ come 
$ H(YY,XX) = sum_(x in Chi) p(x) dot H(YY | XX = x) =  sum_(x in Chi) p(x) (sum_(y in Y) p(y|x) log_2 1/p(y | x))$
$ = sum_(x in Chi) sum_(y in Y) p(x,y) dot log_2 1/p(y | x) $
dove p(x) è la marginale su $Chi$, ovvero la probabilità di un singolo evento o di un insieme di eventi in un sottoinsieme delle variabili, senza tener conto delle altre variabili.
$ p(x) = sum_(y in Y) p(x,y) $
e p(y | x) è la condizionata di $y$ su $x$, ovvero la probabilità che si verifica $y$ dato che già si è verificato $x$
$ p(y | x) = p(x, y) / p(x) $

== Chain rule per entropia
Chain rule per entropia è un teorema che stabilisce una relazione fra entropia, entropia congiunta ed entropia condizionale così denfinita,
$ H(XX | YY) = underbrace(H(XX), "entropia \ndi un evento") + underbrace(H(YY | XX), "entropia \nconfizionata di Y su X") $
oppure
$ H(XX | YY) =  H(YY) + H(XX + YY) $
Il risultato è quindi l'entropia dei due eventi.

Notiamo che questa relazione vale anche per gli spazi condizionati, ovvero
$ H(XX,YY | ZZ) = H(XX | ZZ) + H(YY | XX,ZZ) $
#pagebreak()
== Esercizi

=== Esercizio

Avendo una varliabile $x in Chi$ che mi estrae i numeri da 0 a 10 (in maniera equiprobabile), e avendo un variabile $Y = x + 2 mod 10$, quanti bit sono necessari per caratterizzare l'evento?

*Soluzione:*

Una volta cominciata l'estrazione di $x$ sappiamo anche quanto vale $y$ quindi $H(XX | YY) = 0$ (non ho bisogno di bit per caratterizzare l'evento).

=== Esercizio

Avendo $Chi = {-1, 0, 1}$ e $Y = x^2$, è possibile sapre a priori quanto valgono $H(Y | X)$ e $H(X | Y)$?

*Soluzione:*

Se io conosco $x$ non mi servono bit di informazione per sapere quanto vale $y$, quindi $H(Y | X) = 0$, per quanto riguarda $H(X | Y)$ non conosco il risultato a pripri perché $-1^2$ e $1^2$ restituiscono sempre 1. 

=== Esercizio

In una comunicazione S-C-R (sorgente canale ricevente) ricevo la seguente matrice:
#align(center)[
    #table(
        align: center + horizon,
        columns: (7%, 7%, 7%, 7%, 7%, 7%),
        inset: 10pt,

        [], [$b_1$], [$b_2$], [$b_3$], [$b_4$], [$b_5$],
        [$a_1$], [0.2], [0.2], [0.3], [0.2], [0.1],
        [$a_2$], [0.2], [0.5], [0.1], [0.1], [0.1],
        [$a_3$], [0.6], [0.1], [0.1], [0.1], [0.1],
        [$a_4$], [0.3], [0.1], [0.1], [0.1], [0.4]
    )
]
$Chi = {a_1, a_2, a_3, a_4}$

$P(a_i) = {a_i b_1, dots, a_i b_5} $

#underline[Calcolare l'entropia del ricevente data la sorgente]
      

*Soluzione:*

Prima di tutto bisogna controllare che $sum_(j=1)^5 a_1 b_j = 1$, ovvero che per ogni riga della matrice la somma delle probabilità sia = 1, altrimenti l'esercizio non si può fare.

Adesso possiamo procedere a calcolare l'entropia del ricevente data la sorgente grazie alla formula
$ H(R | S)= sum_(i=1)^4 p(a_i) dot H(R | a_i) $
$ = sum_(i=1)^4 p(a_i) dot sum_(j=1)^5 p(b_j | a_i) dot log_2 1/p(b_j | a_i) $
Adesso vado a calcolare i dai per la sommatoria più interna
$ H(R | a_1) = sum_(j=1)^5 p(b_j | a_1) dot log_2 1/p(b_j | a_1) = (0,2 dot log_2 1/(0,2)) dot 3 + 0,3 dot log_2 1/(0,3) + 0,1 dot log_2 1/(0,2) = 2,246 "bit" $ 
$ H(R | a_2) = sum_(j=1)^5 p(b_j | a_2) dot log_2 1/p(b_j | a_2) = 0,2 dot log_2 1/(0,2) + (0,1 dot log_2 1/(0,1)) dot 3 + 0,5 dot log_2 1/(0,5) = 1,96 "bit" $ 
$ H(R | a_3) = sum_(j=1)^5 p(b_j | a_3) dot log_2 1/p(b_j | a_3) = 0,6 dot log_2 1/(0,6) + (0,1 dot log_2 1/(0,1)) dot 4 = 1,77 "bit"$
$ H(R | a_4) = sum_(j=1)^5 p(b_j | a_4) dot log_2 1/p(b_j | a_4) = 0,3 dot log_2 1/(0,3) + (0,1 dot log_2 1/(0,1)) dot 3 + 0,3 dot log_2 1/(0,4) = 2,046 "bit" $
#pagebreak()
Ora andiamo a sostituire i dati alla formula originale
$ H(R | S)= sum_(i=1)^4 p(a_i) dot H(R | a_i) $
$ = (0,2 dot 2,246) + (0,3 dot 1,96) + (0,1 dot 1,77) + (0,4 dot 2,046) = underline(2","033 "bit") $
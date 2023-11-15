#import "@preview/lemmify:0.1.4": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
    it,
    stroke: green + 1pt,
    inset: 1em,
    breakable: true
)

= Informazione mutua
Ora introduciamo una nuova quantità l'informazione mutua $I(XX,YY)$, quest'ultima fa riferimento a due variabili casuali e ci dice quanta informazione rilascia una variabile casuale rispetto all'altra variabile. L'informazione mutua quindi è così definita,
$ I(XX,YY) = sum_(x in X) sum_(y in Y) p(x,y) log_2(p(x,y)/(p(x) dot p(y))) $
Notiamo che questa quantità corrisponde all'entropia relativa fra la congunta e il prodotto delle marginali (Ricordiamo che l'entropia relativa è $Delta(Chi bar.v.double Y) = sum_(s in S) p_X (s) log_D (p_Chi (s)) / (p_Y (s))$). Quindi essendo un'entropia relativa è sempre maggiore di 0 ($I(XX,YY) >= 0)$.

Possiamo quindi riscrivere $I(XX,YY)$ come:
$ I(XX,YY) = sum_(x in X) sum_(y in Y) p(x,y) log_2 (cancel(p(y)) dot p(x | y))/(p(x) dot cancel(p(y))) $
$ = underbracket(sum_(x in X) underbrace(sum_(y in Y) p(x,y), "probabilità\nmarginale"p(x)) dot log_2 1/p(x), H(x)) + underbracket(sum_(x in X) sum_(y in Y) p(x,y) dot log_2 p(x | y), "Definizione di entropia condizionata")  $
$ = H(XX) - H(XX | YY) >= 0 $
Può anche essere scritta come,
$ I(XX,YY) = H(YY) - underbrace(H(YY | XX),"condiziono su" XX) $
Quindi questo risultato ci permette di interpretare l'informazione mutua come una decrescita di entropia, ovvero il numero di bit che il valore di $YY$ fornisce in media riguardo il valore di $XX$. D'altra parte notiamo che la non negatività di $I(XX,YY)$ implica anche che $H(XX | YY) <= H(XX)$, ovvero il condizionamento di $YY$ decresce l'entropia di $XX$.

== Casi particolari
Vediamo ora alcuni casi particolari che coinvolgono il calcolo dell'informazione mutua:
- Se $XX$ e $YY$ sono indipendenti, allora $H(XX | YY) = H(XX)$ quindi, 
$ I(XX,YY) = H(X) - H(x) = 0 $
- Se $XX$ e $YY$ sono dipendenti, quindi $XX = g(YY)$ dove $g(YY)$ è una qualunque funzione che permetta di stabilire il valore di $XX$, allora $H(XX | YY) = 0$ quindi,
$ I(XX,YY) = H(X) - 0 = H(X) $
- Possiamo usare la chain rule per l'entropia, $H(XX,YY) = H(YY) + H(XX | YY)$, per riscrivere l'informazione mutua come:
$ I(XX,YY) = H(XX) - H(XX | YY) = H(XX) + H(YY) - H(XX,YY) $
Quindi graficamente le relazioni fra entropie e informazione muta è:
(AGGIUNGI DISEGNO)

- $H(XX) = H(XX | YY) + I(XX,YY)$
- $H(YY) = H(YY | XX) + I(XX,YY)$
- $H(XX,YY) = H(XX) + H(YY) - I(XX,YY)$
- $H(XX,YY) = H(XX | YY) + H(YY | XX) + I(XX,YY)$
Analogamente all'entropia, anche l'informazione mutua possiede una sua versione condizionata
$ I(XX,YY | ZZ) = sum_(x,y,z) p(x,y,z) dot log_2 p(x,y | z)/(p(y | z) dot p(x | z)) $

== Data Processing Inequality
Il seguente teorema ci dice che qualsiasi algoritmo di pulizia del rumore può al massimo ricostruire l'informazione tale e quale, non può quindi creare più informazione.
#theorem(numbering: none, name: "Data processing inequality")[
Siano $XX,YY,ZZ$ delle variabili casuali con codominio finito tali che la loro distribuzione congiunta $p(x,y,z)$ soddisfa $p(x,y | z) = p(x | y )p(z | y) 
" " forall x,y,z$; ovvero, $x$ e $z$ sono indipendenti dato $y$. Allora $I(XX,YY) >= I(XX,ZZ)$.
]
Quindi tornando al discorso di prima, il teorema ci dice che $I(XX,YY)$ è una soglia che non può essere superata.

=== Esempio
Supponiamo che vogliamo trovare $I(XX,YY)$ e $I(XX,YY | ZZ)$ nella situazione del lancio di una mometa, dove $ZZ = XX + YY$
$ p(x=1) = 1/2 $
$ p(x=2) = 1/2 $
$I(XX,YY) = 0$ perchè $YY$ è indipendente da $XX$, quindi non rilascia informazioni.

$I(XX,YY | ZZ) = H(XX | ZZ) - H(XX | ZZ, YY = 0)$ se ho $YY$ e $ZZ$ allora non dovrò comunicare nulla per $XX$ perchè lo conosciamo già, quindi sarà 0.

$P(ZZ = 0)H(XX | ZZ = 0) + p(ZZ = 1)H(XX | ZZ = 1) + p(ZZ = 2)H(XX | ZZ = 2) = 0+1/2+0=1/2$

Quindi l'entropia è massima.
$$
== Disuguaglianza di Fano
Il seguente risultato lega direttamente la probabilità di errore all'entropia.
#theorem(numbering: none, name:"Disuguaglianza di Fano")[
Siano $XX$ e $YY$ due variabili casuali con valori in $Chi$ e $Y$ entrambi finiti e sia $g: Y -> X$ una funzione qualunque che mappa i valori di $Y$ in quelli di $X$. Sia $p_e$ la probabilità di errore quando uso $g(YY)$ per predire $X,p_e = P(g(YY) != XX)$. Allora
$ p_e >= (H(XX | YY) - 1) / (log_2 |Chi|) $
]
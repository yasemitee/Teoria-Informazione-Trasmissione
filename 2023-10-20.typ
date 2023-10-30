= Entropia

Dato il modello sorgente $Chi,p$, con $Chi = {x_1, dots, x_m}$ e $P = {p_1, dots, p_m}$, anche $XX : Chi arrow.long RR = {a_1, dots, a_m} ("sottoinsieme")$, $P(XX = a_i) = p_i$

Definisco $ H_D(Chi) = sum_(i=1)^m p_i log_D (1 / p_i) $

Se non metto pedici è entropia binaria $D = 2$

Entropia fa solo riferimento alla distribuzione di probabilità, non c'entra niente con i simboli

Se volessi fare cambio base (quindi cambiare l'entropia binaria) devo ricordarmi che $ log_b p = (ln p) / (ln b) = (ln p) / (ln b) dot (ln a) / (ln a) = underbracket((ln p) / (ln a), log_a p) dot underbracket((ln a) / (ln b), log_b a) $

Ovvero cambiare base significa cambiare base e portarsi dietro una costante

Quindi $ H_b (Chi) = sum_(i=1)^m p_i log_b 1 / p_i arrow.long H_a (Chi) = sum_(i=1)^m p_i log_a 1 / p_i log_b a arrow.long log_b aleph dot H_a (Chi) $

Proviamo a graficare l'entropia binaria con una bernoulliana

$p(XX = 1) = p$ e $p(XX = 0) = 1 - p$, sviluppa entropia e vedi che in $0$ e $1$ l'entropia vale 0

In $1/2$ ho la massima entropia e vale $1$

Aggiungi grafico

So inoltre che $ 1 - 1 / x lt.eq ln x lt.eq x - 1 $

Questi bound ci serviranno dopo (aggiungi grafico)


Che proprietà ha l'entropia?

$H_D (Chi) lt.eq log_D m$

Sia $XX$ variabile casuale che assume i valori distinti $a_1, dots, a_m$; allora $H_D (Chi) lt.eq log_D m space forall D > 1$; inoltre, vale uguaglianza se e solo se $XX$ ha una distribuzione uniforme su $a_1, dots, a_m$

DIMOSTRAZIONE (voglio far vedere $lt.eq 0$)

$ H_D (Chi) - log_D m &= sum_(i=1)^m p_i log_D 1 / p_i - log_D m dot underbracket(sum_(i=1)^m p_i, =1) \ &= sum_(i=1)^m p_i log_D 1 / p_i - p_i log_D m = sum_(i=1)^m p_i dot (log_D 1 / p_i - log_D m) \ &= sum_(i=1)^m p_i dot (log_D 1 / p_i + log_D m^(-1)) = sum_(i=1)^m p_i dot log_D m^(-1) / p_i ("sistema") $

Io so la maggiorazione del logaritmo

$ sum_(i=1)^m p_i dot ln underbracket(1 / (p_i dot m), x) dot 1 / (ln D) &lt.eq sum_(i=1)^m p_i (1 / (p_i dot m) - 1) 1 / (ln D) \ &lt.eq 1 / (ln D) sum_(i=1)^m 1 / m - p_i = 1 / (ln D) underbracket([ underbracket(sum_(i=1)^m 1 / m, 1) - underbracket(sum_(i=1)^m p_i, 1) ], 0) = 0 $

Quindi $H_D (Chi) - log_D m lt.eq 0 arrow.long H_D (Chi) lt.eq log_D m$

Ora, se $P(X = a_i) = 1 / m space forall i = 1, dots, m$ allora $ H_D (Chi) = sum_(i=1)^m 1 / p_i log_D 1 / p_i = sum_(i=1)^m 1 / m log_D m = log_D m underbracket(sum_(i=1)^m 1 / m, 1) = log_D m $ 

FINE DIMOSTRAZIONE

Introduciamo l'entropia relativa $Delta(Chi bar.v.double Y)$ misura la distanza tra $Chi$ e $Y$, la diversità tra $Chi$ e $Y$, due distribuzioni di probabilità

$ Delta(Chi bar.v.double Y) = sum_(s in S) p_X (s) log_D (p_Chi (s)) / (p_Y (s)) $

$S$ è il dominio sul quale $Chi$ e $Y$ lavorano

Teorema: per ogni coppia di variabili casuali $Chi,Y$ definite sullo stesso dominio $S$, vale la disuguaglianza $Delta(Chi bar.v.double Y) gt.eq 0$

DIMOSTRAZIONE

$ D(Chi bar.v.double Y) &= sum_(s in S) p_Chi (s) log_D (p_Chi (s)) / (p_Y (s)) = sum_(s in S) p_Chi (s) ln (p_Chi (s)) / (p_Y (s)) 1 / (ln D) \ &= 1 / (ln D) sum_(s in S) p_Chi (s) ln underbracket((p_Chi (s)) / (p_Y (s)), x) \ &gt.eq 1 / (ln D) sum_(s in S) p_Chi (s) dot (1 - (p_Y (s)) / (p_Chi (s))) = 1 / (ln D) sum_(s in S) p_Chi (s) - p_Y (s) \ &gt.eq underbracket(sum_(s in S) p_Chi (s), 1) - underbracket(sum_(s in S) p_Y (S), 1) = 0 $

FINE DIMOSTRAZIONE

Ora vediamo relazione tra il valore atteso delle lunghezze del codice e l'entropia

Teorema: sia $c : Chi arrow DD^+$ codice istantaneo $D$-ario per una sorgente $angle.l Chi, p angle.r$, allora $ EE[l_c] gt.eq H_D (Chi) $

DIMOSTRAZIONE

Definisco $ZZ : Chi arrow.long RR$ variabile casuale alla quale associamo una distribuzione di probabilità $ q(x) = D^(-l_c (x)) / ( limits(sum)_(x' in Chi) D^(-l_c (x')) ) $

$ EE[l_c] - H_D (Chi) &= sum_(x in Chi) p_i l_c (x_i) - sum_(x in Chi)^m p(x) log_D 1 / p(x) = sum_(x in Chi) p(x) dot (l_c (x) - log_D 1 / p(x)) \ &= sum_(x in Chi) p(x) dot (log_D D^(l_c (x)) - log_D 1 / p(x)) = sum_(x in Chi) p(x) dot (log_D D^(l_c (x)) + log_D p(x)) \ &= sum_(x in Chi) p(x) log_D ( D^(l_c (x)) dot p(x)) = sum_(x in Chi) p(x) dot (log_D (p(x)) / (D^(-l_c (x))) dot 1) = sum_(x in X) p(x) dot (log_D (p(x) / (D^(-l_c (x))) dot (sum_(x' in Chi) D^(-l_c (x'))) / (sum_(x' in Chi) D^(-l_c (x'))))) \ &= sum_(x in Chi) p(x) dot (log_D p(x) (sum_(x' in Chi) D^(-l_c (x'))) / (D^(-l_c (x))) - log_D sum_(x' in Chi) D^(-l_c (x'))) = sum_(x in Chi) p(x) dot (log_D p(x) / q(x) - log_D sum_(x' in Chi) D^(-l_c (x'))) \ &= sum_(x in Chi) p(x) log_D p(x) / q(x) - p(x) log_D sum_(x' in Chi) D^(-l_c (x')) = sum_(x in Chi) p(x) log_D p(x) / q(x) - sum_(x in Chi) p(x) log_D sum_(x' in Chi) D^(-l_c (x')) \ &= underbracket(Delta(Chi bar.v.double ZZ), gt.eq 0) underbracket(- underbracket(log_D sum_(x' in Chi) D^(-l_c (x')), "c istantaneo" arrow log(t lt.eq 1) lt.eq 0), gt.eq 0) dot underbracket(sum_(x in Chi) p(x), =1) gt.eq 0 $

FINE DIMOSTRAZIONE

#pagebreak()

= Sardinas-Patterson

Algoritmo che permette di dimostrare se un codice è univocamente decodificabile

Inserisci due esempi risolti a mano

Sia $S_1 = Chi$, allora proseguo in modo iterativo applicando le due regole seguenti:
- per ogni $x in S_1$, se esiste $y in S_i$ tale che $\x\y in S_i$ allora $y in S_(i+1)$
- per ogni $z in S_i$, se esiste $y in S_1$ tale che $\x\y in S_1$ allora $y in S_(i+1)$

Inserisci secondo esempio risolto con Sardinas-Patterson

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
= Entropia
== Definizione
L'entropia è usata per quantificare la quantità di informazione contenuta in una sorgente di dati o, in altre parole, per misurare quanto siamo incerti riguardo a un evento futuro quando conosciamo l'insieme degli eventi possibili. Maggiore è l'entropia, maggiore è l'incertezza o la mancanza di informazione. D'altro canto, minore è l'entropia, minore è l'incertezza e maggiore è l'informazione contenuta nel sistema.

Dato il modello sorgente $angle.l Chi,p angle.r$, con $Chi = {x_1, dots, x_m}$ e $P = {p_1, dots, p_m}$, introduciamo $XX : Chi arrow.long RR = {a_1, dots, a_m}$ (funzione iniettiva) con $a_1, dots, a_m in RR$ tali che $P(XX = a_i) = p_i$.

Definisco l'entropia sulla variabile casuale $XX$: 
$ H_D (XX) = sum_(i=1)^m p_i log_D (1 / p_i) $

Se non metto pedici è entropia binaria $D = 2$ e in questo caso l'unità di misura è il _bit_.

=== Esempio
Immaginiamo di voler modellare il lancio di una moneta.

*Il caso con entropia maggiore* è quello più “incerto”, ovvero quello in cui testa e croce hanno la medesima probabilità di uscire: prima di lanciare la moneta, non si ha modo di azzeccare quale faccia cadrà a testa in giù.

*Quando invece uno stato ha probabilità maggiore di realizzarsi, l’entropia diminuisce*, e con lei la nostra “sorpresa” nel vedere il risultato. Quindi lanciando una moneta truccata ripetutamente, non saremo sopresi del risultato o se vogliamo il risultato è più predicibile.

== Entropia binaria
L'entropia binaria è definita su una variabile casuale Bernoulliana $XX in {0,1}$ dove
$P(XX = 1) = p$ e $P(XX = 0) = 1 - p$, per $p in [0,1]$.
Quindi dalla definizione di entropia abbiamo che $H(x) = h(p)$ dove
$ h(p) = p log_2 (1/2) + (1-p) log_2 (1/(1-p)) $

#v(12pt)

#figure(
    image("assets/23-10-20 bernoulliana-entropia-binaria.png", width: 40%)
)
_$ "Grafico dell'entropia binaria" h(p) "nel suo intervallo di definizione" [0,1] $_
#v(12pt)
Come si evince dalla bernoulliana, in 0 e 1 ho entropia 0, mentre in $1/2$ ho entropia massima.

So inoltre che $ 1 - 1 / x lt.eq ln x lt.eq x - 1 $

Questi bound ci serviranno dopo.
#v(12pt)

#figure(
    image("assets/2023-10-20 disuguaglianze.png", width: 40%)
)
_$ "la linea rossa in mezzo è " ln_x $_
#v(12pt)

== Proprietà dell'entropia

- L'entropia fa solo riferimento alla distribuzione di probabilità, quindi non c'entra niente con i simboli ${a_1, dots, a_m}$. Infatti l’entropia di una sorgente dipende dall’insieme delle probabilità che tale sorgente ha di generare i suoi possibili output.
- se volessi fare un cambio base (quindi cambiare l'entropia binaria) devo ricordarmi che $ log_b p = (ln p) / (ln b) = (ln p) / (ln b) dot (ln a) / (ln a) = underbracket((ln p) / (ln a), log_a p) dot underbracket((ln a) / (ln b), log_b a) $

Ovvero cambiare base significa cambiare base e portarsi dietro una costante. Quindi
 $ H_b (XX) = sum_(i=1)^m p_i log_b 1 / p_i arrow.long H_a (XX) = sum_(i=1)^m p_i log_a 1 / p_i log_b a arrow.long log_b a dot H_a (XX) $
- L'entropia è non negativa, ovvero $H(XX) >= 0$. Infatti, l'entropia è una combinazione lineare con coefficienti positivi $p_i$ di numeri non negativi $log 1/p_i$.
- $H(XX) = 0$ se e solo se esiste un $a in RR$ tale che $P(XX = a) = 1$. Infatti, $H(XX) = 1 ln 1 = 0$

- $H_D (Chi) lt.eq log_D m$
#lemma(numbering:none)[
Sia $XX$ variabile casuale che assume i valori distinti $a_1, dots, a_m$; allora $H_D (XX) lt.eq log_D m space forall D > 1$; inoltre, vale l'uguaglianza $H(XX) = log_D m$ se e solo se $XX$ ha una distribuzione uniforme su $a_1, dots, a_m$
]<thm>
#pagebreak()
#proof[
(voglio far vedere $lt.eq 0$)

$ H_D (XX) - log_D m &= sum_(i=1)^m p_i log_D 1 / p_i - log_D m dot underbracket(sum_(i=1)^m  p_i, =1) $ 
$ = sum_(i=1)^m p_i log_D 1 / p_i - p_i log_D m = sum_(i=1)^m p_i dot (log_D 1 / p_i - log_D m) $ $ = sum_(i=1)^m p_i dot (log_D 1 / p_i + log_D m^(-1)) = sum_(i=1)^m p_i dot log_D m^(-1) / p_i ("sistema") $

Io so la maggiorazione del logaritmo

$ sum_(i=1)^m p_i dot ln underbracket(1 / (p_i dot m), x) dot 1 / (ln D) &lt.eq sum_(i=1)^m p_i (1 / (p_i dot m) - 1) 1 / (ln D) \ &lt.eq 1 / (ln D) sum_(i=1)^m 1 / m - p_i = 1 / (ln D) underbracket([ underbracket(sum_(i=1)^m 1 / m, 1) - underbracket(sum_(i=1)^m p_i, 1) ], 0) = 0 $

Quindi $H_D (XX) - log_D m lt.eq 0 arrow.long H_D (XX) lt.eq log_D m$

Ora, se $P(X = a_i) = 1 / m space forall i = 1, dots, m$ allora $ H_D (XX) = sum_(i=1)^m 1 / m log_D m = log_D m underbracket(sum_(i=1)^m 1 / m, 1) = log_D m $ 
]<proof>

== Entropia relativa
Introduciamo l'entropia relativa $Delta(Chi bar.v.double Y)$ misura la distanza tra $Chi$ e $Y$, la diversità tra $Chi$ e $Y$, due distribuzioni di probabilità

$ Delta(XX bar.v.double YY) = sum_(s in S) p_XX (s) log_D (p_XX (s)) / (p_YY (s)) $

$S$ è il dominio sul quale $Chi$ e $Y$ lavorano
#theorem(numbering:none)[
per ogni coppia di variabili casuali $XX,YY$ definite sullo stesso dominio $S$, vale la disuguaglianza $Delta(XX bar.v.double YY) gt.eq 0$
]<thm>
#pagebreak()
#proof[
$ D(XX bar.v.double YY) &= sum_(s in S) p_XX (s) log_D (p_XX (s)) / (p_YY (s)) = sum_(s in S) p_XX (s) ln (p_XX (s)) / (p_YY (s)) 1 / (ln D) \ &= 1 / (ln D) sum_(s in S) p_XX (s) ln underbracket((p_XX (s)) / (p_YY (s)), x) \ &gt.eq 1 / (ln D) sum_(s in S) p_XX (s) dot (1 - (p_YY (s)) / (p_XX (s))) = 1 / (ln D) sum_(s in S) p_XX (s) - p_YY (s) \ &gt.eq underbracket(sum_(s in S) p_XX (s), 1) - underbracket(sum_(s in S) p_YY (S), 1) = 0 $
]<proof>
== Relazione tra $EE$ e l'entropia
Ora vediamo relazione tra il valore atteso delle lunghezze del codice e l'entropia
#theorem(numbering:none)[
sia $c : Chi arrow DD^+$ codice istantaneo $D$-ario per una sorgente $angle.l Chi, p angle.r$, allora $ EE[l_c] gt.eq H_D (Chi) $
]

#proof[
Definisco $ZZ : Chi arrow.long RR$ variabile casuale alla quale associamo una distribuzione di probabilità $ q(x) = D^(-l_c (x)) / ( limits(sum)_(x' in Chi) D^(-l_c (x')) ) $
Possiamo quindi scrivere:
$ EE[l_c] - H_D (Chi) = sum_(x in Chi) p_i l_c (x_i) - sum_(x in Chi)^m p(x) log_D 1 / p(x) $ $ = sum_(x in Chi) p(x) dot (l_c (x) - log_D 1 / p(x)) = sum_(x in Chi) p(x) dot (log_D D^(l_c (x)) - log_D 1 / p(x)) $ $ = sum_(x in Chi) p(x) dot (log_D D^(l_c (x)) + log_D p(x)) = sum_(x in Chi) p(x) log_D ( D^(l_c (x)) dot p(x)) $ $ = sum_(x in Chi) p(x) dot (log_D (p(x)) / (D^(-l_c (x))) dot 1) = sum_(x in X) p(x) dot (log_D (p(x) / (D^(-l_c (x))) dot (sum_(x' in Chi) D^(-l_c (x'))) / (sum_(x' in Chi) D^(-l_c (x')))))  $ $ = sum_(x in Chi) p(x) dot (log_D p(x) (sum_(x' in Chi) D^(-l_c (x'))) / (D^(-l_c (x))) - log_D sum_(x' in Chi) D^(-l_c (x'))) $ $ = sum_(x in Chi) p(x) dot (log_D p(x) / q(x) - log_D sum_(x' in Chi) D^(-l_c (x'))) $ $ = sum_(x in Chi) p(x) log_D p(x) / q(x) - p(x) log_D sum_(x' in Chi) D^(-l_c (x')) $ $ = sum_(x in Chi) p(x) log_D p(x) / q(x) - sum_(x in Chi) p(x) log_D sum_(x' in Chi) D^(-l_c (x')) $ $ = underbracket(Delta(Chi bar.v.double ZZ), gt.eq 0) underbracket(- underbracket(log_D sum_(x' in Chi) D^(-l_c (x')), "c istantaneo" arrow log(t lt.eq 1) lt.eq 0), gt.eq 0) dot underbracket(sum_(x in Chi) p(x), =1) gt.eq 0 $
]

Questo risultato dà un significato operativo all'entropia, mostrando che l'entropia di una variabile casuale $XX$ è un limite inferiore (lower bound) al numero di simboli di codice istantaneo che dobbiamo usare in media per descrivere una relazione di $XX$.

= Sardinas-Patterson

Algoritmo che permette di dimostrare se un codice è univocamente decodificabile

Inserisci due esempi risolti a mano

Sia $S_1 = Chi$, allora proseguo in modo iterativo applicando le due regole seguenti:
- per ogni $x in S_1$, se esiste $y in S_i$ tale che $\x\y in S_i$ allora $y in S_(i+1)$
- per ogni $z in S_i$, se esiste $y in S_1$ tale che $\x\y in S_1$ allora $y in S_(i+1)$

Inserisci secondo esempio risolto con Sardinas-Patterson
